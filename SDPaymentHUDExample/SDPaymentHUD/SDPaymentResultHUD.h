







#import <UIKit/UIKit.h>

@interface SDPaymentResultHUD : UIView<CAAnimationDelegate>

- (void)startWithResult:(BOOL)isSuccess;

-(void)hide;

+(SDPaymentResultHUD *)showSuccessIn:(UIView *)view;
+(SDPaymentResultHUD *)showFailIn:(UIView *)view;

+(SDPaymentResultHUD *)hideIn:(UIView *)view;

@end
