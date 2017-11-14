//
//  MSUCoomentController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUCoomentController.h"
#import "MSUThankCommentController.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"

#import "MSUComView.h"

@interface MSUCoomentController ()<UITextViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , strong) MSUComView *comView;

@end

@implementation MSUCoomentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = REDCOLOR;

    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:6];
    [self.view addSubview:nav];
    [nav.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.comView = [[MSUComView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    [self.view addSubview:_comView];
    _comView.backgroundColor = HEXCOLOR(0xffffff);
    _comView.textView.delegate = self;
    [_comView.pushBtn addTarget:self action:@selector(pushBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_comView.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.detailModel.shopLogo] forState:UIControlStateNormal];
    _comView.nameLab.text = self.detailModel.shopName;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)tapView:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqual:@"UITableViewCellContentView"]){
        
        return NO;
    }
    return YES;
}


#pragma - 点击事件
- (void)backArrowBtnClick:(UIButton *)sender{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pushBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUThankCommentController *than = [[MSUThankCommentController alloc] init];
//    [self.navigationController pushViewController:than animated:YES];
    than.str = _comView.textView.text;
    [self presentViewController:than animated:YES completion:nil];
}

#pragma - 代理
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _comView.placeLab.hidden = YES;
}



@end
