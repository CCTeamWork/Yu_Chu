//
//  DCCBaseNavgationView.h
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCBaseNavgationView : UIView

@property (nonatomic, strong)UIButton *backBtn;

@property (nonatomic, strong)UILabel *titleLab;


- (void)setTitle:(NSString *)title andBackGroundColor:(UIColor *)color andTarget:(UIViewController *)target;

- (void)redBackGroundSetTitle:(NSString *)title andBackGroundColor:(UIColor *)color andTarget:(UIViewController *)target;

- (void)loginSetTitle:(NSString *)title andBackGroundColor:(UIColor *)color andTarget:(UIViewController *)target;
@end
