#import <MapKit/MapKit.h>

#import "TourGeoLocation.h"

@class  TourComponent;

@interface TourMapAnnotation : NSObject <MKAnnotation> {

    TourComponent *component;
    NSString *subtitle;
    BOOL hasTransform;
    CGAffineTransform transform;
    id<TourGeoLocation> tourGeoLocation;

}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (readonly) NSString *title;
@property (nonatomic, retain) TourComponent *component;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic) BOOL hasTransform;
@property (nonatomic) CGAffineTransform transform;
@property (nonatomic, retain) id<TourGeoLocation> tourGeoLocation;

@end