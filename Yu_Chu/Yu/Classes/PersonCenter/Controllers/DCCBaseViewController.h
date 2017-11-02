//
//  DCCBaseViewController.h
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCBaseViewController : UIViewController

//一级页面push全部用这个方法
- (void)pushToViewcontroller:(UIViewController *)vc;

//二级页面push全部用这个方法
- (void)secondPushToViewcontroller:(UIViewController *)vc;


@end
