#import <UIKit/UIKit.h>
#import "ShareDetailViewController.h"


@class QRReaderResult;
@interface QRReaderDetailViewController : UIViewController {
    QRReaderResult *_scanResult;
    UIImageView *_qrImage;
    UITextView *_textView;
    UIButton *_actionButton;
    UIButton *_shareButton;
}

@property (nonatomic,readonly,retain) QRReaderResult *scanResult;
@property (nonatomic,readonly,retain) IBOutlet UIImageView *qrImage;
@property (nonatomic,readonly,retain) IBOutlet UITextView *textView;
@property (nonatomic,readonly,retain) IBOutlet UIButton *actionButton;
@property (nonatomic,readonly,retain) IBOutlet UIButton *shareButton;

+ (QRReaderDetailViewController*)detailViewControllerForResult:(QRReaderResult*)result;

@end