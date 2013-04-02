//
//  DiningDetailHeaderView.m
//  MIT Mobile
//
//  Created by Austin Emmons on 4/2/13.
//
//

#import "DiningHallMenuHeaderView.h"

@interface DiningHallMenuHeaderView ()

@property (nonatomic, retain) UIImageView   * icon;
@property (nonatomic, retain) UILabel       * titleLabel;
@property (nonatomic, retain) UILabel       * timeLabel;
@property (nonatomic, retain) UIButton      * infoButton;

@end


@implementation DiningHallMenuHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // dimensions derived from https://jira.mit.edu/jira/secure/attachment/26097/house+menu.pdf
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 10, frame.size.width - 114, 44)];
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, frame.size.width - 60, 13)];
        self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.infoButton.frame = CGRectMake(frame.size.width - 40, 0, 40, frame.size.height);
        
        [self styleSubviews];
        [self debugInfo];
        
        [self addSubview:self.icon];
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.infoButton];
    }
    return self;
}

- (void) styleSubviews
{
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    
    [self.infoButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.infoButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    
}

- (void) debugInfo
{
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.titleLabel.text = @"Some Dining Hall";
    self.timeLabel.text = @"Opens never";
    self.icon.image = [UIImage imageNamed:@"icons/home-map.png"];
    [self.infoButton setImage:[UIImage imageNamed:@"icons/tab-about.png"] forState:UIControlStateNormal];
}

@end
