





#import "ViewController.h"
#import "SDPaymentResultHUD.h"
#import "SDPaymentLoadingHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始支付" style:UIBarButtonItemStylePlain target:self action:@selector(showLoadingAnimation)];
    
    UIBarButtonItem *successBar = [[UIBarButtonItem alloc] initWithTitle:@"支付完成" style:UIBarButtonItemStylePlain target:self action:@selector(showSuccessAnimation)];
    
    UIBarButtonItem *failBar = [[UIBarButtonItem alloc] initWithTitle:@"支付失败" style:UIBarButtonItemStylePlain target:self action:@selector(showFailAnimation)];
    
    
    
    self.navigationItem.rightBarButtonItems = @[successBar,failBar];
    
    
    
    
}

-(void)showLoadingAnimation{
    
    self.title = @"正在付款...";
    
    //隐藏支付完成动画
    [SDPaymentResultHUD hideIn:self.view];
    //显示支付中动画
    [SDPaymentLoadingHUD showIn:self.view];
}

-(void)showSuccessAnimation{
    
    self.title = @"付款成功";
    
    //隐藏支付中成动画
    [SDPaymentLoadingHUD hideIn:self.view];
    //显示支付完成动画
    [SDPaymentResultHUD showSuccessIn:self.view];
}

-(void)showFailAnimation{
    self.title = @"付款失败";
    
    //隐藏支付中成动画
    [SDPaymentLoadingHUD hideIn:self.view];
    //显示支付完成动画
    [SDPaymentResultHUD showFailIn:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
