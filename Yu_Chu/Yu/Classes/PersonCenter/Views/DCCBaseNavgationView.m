//
//  DCCBaseNavgationView.m
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCBaseNavgationView.h"
#import "XLZHHeader.h"

@implementation DCCBaseNavgationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initAllSubviews];
    }
    return self;
}
- (void)initAllSubviews{
    self.userInteractionEnabled = YES;
    self.frame = CGRectMake(0, 0, kScreenWidth, STATUS_AND_NAVIGATION_HEIGHT);
    [self addSubview:self.backBtn];
    [self addSubview:self.titleLab];
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 60, 44)];
        [_backBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    }
    return _backBtn;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(60, STATUS_BAR_HEIGHT, kScreenWidth-120, 44)];
        _titleLab.textColor = JQXXXLZH272727CLOLR;
        _titleLab.font = [UIFont systemFontOfSize:17];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (void)setTitle:(NSString *)title andBackGroundColor:(UIColor *)color andTarget:(UIViewController *)target{
    self.titleLab.text = title;
    self.backgroundColor = color;
    [[self.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(__kindof UIControl * _Nullable x) {
             [target.navigationController popViewControllerAnimated:YES];
     }];
}
@end
