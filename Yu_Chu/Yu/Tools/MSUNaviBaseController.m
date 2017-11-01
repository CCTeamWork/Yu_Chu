//
//  MSUNaviBaseController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/5.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUNaviBaseController.h"

@interface MSUNaviBaseController ()

@end

@implementation MSUNaviBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 旋转相关 （导航控制器下的子控制器需要旋转需要重写此方法，且需要旋转哪个控制器就传入哪个）
- (BOOL)shouldAutorotate
{
    //在viewControllers中返回需要改变的viewController
    return [[self.viewControllers lastObject] shouldAutorotate];
}

@end
