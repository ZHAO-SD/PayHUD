







#import <UIKit/UIKit.h>

@interface SDPaymentLoadingHUD : UIView

-(void)start;

-(void)hide;

+(SDPaymentLoadingHUD *)showIn:(UIView *)view;

+(SDPaymentLoadingHUD *)hideIn:(UIView *)view;

@end
