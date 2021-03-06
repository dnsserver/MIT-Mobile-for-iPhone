#import "MGSUtility.h"
#import "MGSGeometry.h"

AGSPoint* AGSPointFromCLLocationCoordinate2D(CLLocationCoordinate2D coord) {
    // Set the spatial reference to nil here so the point will inherit whatever
    // the reference of its parent object is. This is done to simplify creating
    // complex geometry objects such as AGSPolygon/AGSPolyline since it appears
    // like points in those objects are only reprojected if their spatial
    // reference is inherited.
    AGSPoint *clPoint = [AGSPoint pointWithX:coord.longitude
                                           y:coord.latitude
                            spatialReference:nil];

    return clPoint;
}

AGSPoint* AGSPointFromCLLocationCoordinate2DInSpatialReference(CLLocationCoordinate2D coord, AGSSpatialReference *targetReference) {
    AGSPoint *clPoint = (AGSPoint *) [AGSPoint pointWithX:coord.longitude
                                                        y:coord.latitude
                                         spatialReference:[AGSSpatialReference wgs84SpatialReference]];

    AGSPoint *projectedPoint = (AGSPoint *) [[AGSGeometryEngine defaultGeometryEngine] projectGeometry:clPoint
                                                                                    toSpatialReference:targetReference];

    return projectedPoint;
}

CLLocationCoordinate2D CLLocationCoordinate2DFromAGSPoint(AGSPoint *point) {
    AGSGeometryEngine *geoEngine = [AGSGeometryEngine defaultGeometryEngine];
    AGSPoint *projectedPoint = (AGSPoint *) [geoEngine projectGeometry:point
                                                    toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
    return CLLocationCoordinate2DMake(projectedPoint.y, projectedPoint.x);
}

MKCoordinateRegion MKCoordinateRegionFromAGSEnvelope(AGSEnvelope *envelope)
{
    MKCoordinateRegion region = MKCoordinateRegionInvalid;
    
    BOOL regionValid = ([envelope isValid] &&
                        ([envelope isEmpty] == NO));
    if (regionValid) {
        AGSGeometryEngine *engine = [AGSGeometryEngine defaultGeometryEngine];
        AGSEnvelope *projectedEnvelope = (AGSEnvelope*) [engine projectGeometry:envelope
                                                             toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
        
        CLLocationDegrees latitudeDelta = fabs(projectedEnvelope.ymax - projectedEnvelope.ymin);
        CLLocationDegrees longitudeDelta = fabs(projectedEnvelope.xmax - projectedEnvelope.xmin);
        region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(projectedEnvelope.ymin + (latitudeDelta / 2.0),
                                                                   projectedEnvelope.xmin + (longitudeDelta / 2.0)),
                                        MKCoordinateSpanMake(latitudeDelta, longitudeDelta));
    }
    
    return region;
}


AGSEnvelope* AGSEnvelopeFromMKCoordinateRegion(MKCoordinateRegion region)
{
    if (MKCoordinateRegionIsValid(region)) {
        CLLocationDegrees latitudeCenterOffset = region.span.latitudeDelta / 2.0;
        CLLocationDegrees longitudeCenterOffset = region.span.longitudeDelta / 2.0;
        
        AGSEnvelope *envelope = [AGSEnvelope envelopeWithXmin:(double) (region.center.longitude - longitudeCenterOffset)
                                                         ymin:(double) (region.center.latitude - latitudeCenterOffset)
                                                         xmax:(double) (region.center.longitude + longitudeCenterOffset)
                                                         ymax:(double) (region.center.latitude + latitudeCenterOffset)
                                             spatialReference:[AGSSpatialReference wgs84SpatialReference]];
        return envelope;
    } else {
        return nil;
    }
}


AGSEnvelope* AGSEnvelopeFromMKCoordinateRegionWithSpatialReference(MKCoordinateRegion region, AGSSpatialReference *reference)
{
    AGSEnvelope *envelope = AGSEnvelopeFromMKCoordinateRegion(region);
    
    if (envelope && reference) {
        return (AGSEnvelope*) [[AGSGeometryEngine defaultGeometryEngine] projectGeometry:envelope
                                                                      toSpatialReference:reference];
    }
    
    return nil;
}