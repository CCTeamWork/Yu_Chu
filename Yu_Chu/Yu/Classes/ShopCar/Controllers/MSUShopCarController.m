//
//  MSUShopCarController.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUShopCarController.h"
#import "XLZHHeader.h"

@interface MSUShopCarController ()

@end

@implementation MSUShopCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initAllData];
    
    [self initAllSubviews];
}

- (void)initAllData{
    
}

- (void)initAllSubviews{
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    DCCBaseNavgationView *navV = [[DCCBaseNavgationView alloc] init];
    [navV redBackGroundSetTitle:@"购物车" andBackGroundColor:JQXXXLZHFF2D4BCLOLR andTarget:self];
    [self.view addSubview:navV];
    
}
@end
