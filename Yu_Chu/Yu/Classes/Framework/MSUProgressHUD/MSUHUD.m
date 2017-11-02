//
//  YTPromptView.m
//  CityYouTian
//
//  Created by MSU on 16/4/13.
//  Copyright © 2016年 qz. All rights reserved.
//
#import "MSUHUD.h"


@interface MSUHUD()

@property (nonatomic,strong) NSTimer *timer;

@end

//获取屏幕宽度
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
//获取屏幕高度
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define FoutOfSize 13.0

@implementation MSUHUD {
    UIImageView *_bgImageView;
}

static MSUHUD *g_instance = nil;

+ (instancetype )shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[MSUHUD alloc] init];
    });
    return g_instance;
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

+ (void)showStatusWithString:(NSString *)string {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD showWithStatus:string];
}

+ (void)showWhiteStatusWithString:(NSString *)string {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD showWithStatus:string];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

+ (void)showSuccessWithString:(NSString *)string {
    [SVProgressHUD showSuccessWithStatus:string];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    MSUHUD *tools = [MSUHUD shareInstance];
    [tools.timer invalidate];
    tools.timer = nil;
    tools.timer = [NSTimer timerWithTimeInterval:3 target:tools selector:@selector(dismiss) userInfo:nil repeats:NO];
}

+ (void)showErrorWithString:(NSString *)string {
    [SVProgressHUD showErrorWithStatus:string];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    MSUHUD *tools = [MSUHUD shareInstance];
    [tools.timer invalidate];
    tools.timer = nil;
    tools.timer = [NSTimer timerWithTimeInterval:0.7 target:tools selector:@selector(dismiss) userInfo:nil repeats:NO];
}

+ (void)showStatusWithString:(NSString *)string hideAfterDelay:(CGFloat)delay {
    [SVProgressHUD showWithStatus:string];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

+ (void)showWhiteStatusWithString:(NSString *)string hideAfterDelay:(CGFloat)delay {
    [SVProgressHUD showWithStatus:string];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

+ (void)showWhiteFileWithString:(NSString *)string {
    //    CGSize labelSize =[MSUHUD calculateTextHeight:string];
    [MSUHUD showWhiteFileWithString:string OffsetxY:0];
}

+ (void)showWhiteFileWithString:(NSString *)string OffsetxY:(CGFloat)Y {
    [MSUHUD dismiss];
    UIImageView *imageView =[[MSUHUD shareInstance] imageWhiteView:string delayX:2];
    
    if (imageView.hidden) {
        imageView.alpha = 1;
        imageView.hidden=NO;
    }
    
    UILabel *label =(UILabel*)imageView.subviews[0];
    label.center =CGPointMake(KScreenWidth/2, KScreenHeight/2+Y);
    
    UIWindow *window =[[[UIApplication sharedApplication] windows]lastObject];
    [window addSubview:imageView];
}

- (UIImageView*)imageWhiteView:(NSString*)string delayX:(CGFloat)delay {
    UILabel *label =nil;
    if (!_bgImageView) {
        _bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _bgImageView.alpha = 1;
        _bgImageView.backgroundColor=[UIColor clearColor];
        
        label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.center =CGPointMake(KScreenWidth/2, KScreenHeight-KScreenHeight/4);
        label.textColor =[UIColor blackColor];
        label.backgroundColor =[UIColor whiteColor];
        label.textAlignment =NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:FoutOfSize];
        label.numberOfLines =0;
        label.text =@"";
        label.layer.cornerRadius =5;
        label.clipsToBounds =YES;
        [_bgImageView addSubview:label];
    } else {
        label =(UILabel*)_bgImageView.subviews[0];
    }
    CGSize labelSize =[MSUHUD calculateTextHeight:string];
    label.bounds =CGRectMake(0, 0, KScreenWidth-176, labelSize.height+30);
    label.text =string;
    
    [[MSUHUD shareInstance] performSelector:@selector(deleteSelfView:) withObject:label afterDelay:delay+0.5];
    
    return _bgImageView;
}


+ (void)showFileWithString:(NSString *)string {
//    CGSize labelSize =[MSUHUD calculateTextHeight:string];
    [MSUHUD showFileWithString:string OffsetY:0];
}

+ (void)showFileWithString:(NSString *)string OffsetY:(CGFloat)Y {
    [MSUHUD dismiss];
    UIImageView *imageView =[[MSUHUD shareInstance] imageView:string delay:2];
    
    if (imageView.hidden) {
        imageView.alpha = 1;
        imageView.hidden=NO;
    }
    
    UILabel *label =(UILabel*)imageView.subviews[0];
    label.center =CGPointMake(KScreenWidth/2, KScreenHeight/2+Y);
    
    UIWindow *window =[[[UIApplication sharedApplication] windows]lastObject];
    [window addSubview:imageView];
}

- (UIImageView*)imageView:(NSString*)string delay:(CGFloat)delay {
    UILabel *label =nil;
    if (!_bgImageView) {
        _bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _bgImageView.alpha = 1;
        _bgImageView.backgroundColor=[UIColor clearColor];
        
        label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.center =CGPointMake(KScreenWidth/2, KScreenHeight-KScreenHeight/4);
        label.textColor =[UIColor whiteColor];
        label.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.9];
        label.textAlignment =NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:FoutOfSize];
        label.numberOfLines =0;
        label.text =@"";
        label.layer.cornerRadius =5;
        label.clipsToBounds =YES;
        [_bgImageView addSubview:label];
    } else {
        label =(UILabel*)_bgImageView.subviews[0];
    }
    CGSize labelSize =[MSUHUD calculateTextHeight:string];
    label.bounds =CGRectMake(0, 0, KScreenWidth-176, labelSize.height+30);
    label.text =string;
    
    [[MSUHUD shareInstance] performSelector:@selector(deleteSelfView:) withObject:label afterDelay:delay+0.5];

    return _bgImageView;
}


-(void)deleteSelfView:(UILabel*)label {
    [UIView animateWithDuration:0.5 animations:^{
        _bgImageView.alpha = 0;
    } completion:^(BOOL finished) {
        _bgImageView.hidden=YES;
    }];
}


+(CGSize)calculateTextHeight:(NSString*)string {
    CGRect textRect=[string boundingRectWithSize:CGSizeMake(KScreenWidth-176, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FoutOfSize]} context:nil];
    return textRect.size;
}

@end