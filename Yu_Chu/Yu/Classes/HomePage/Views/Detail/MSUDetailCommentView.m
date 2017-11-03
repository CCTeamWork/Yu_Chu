//
//  MSUDetailCommentView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//


#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUPathTools.h"
#import "MSUStringTools.h"

#import "MSUDetaiCommentTableCell.h"


#import "MSUDetailCommentView.h"
#import "MSUCommentTopView.h"

@interface MSUDetailCommentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , assign) CGFloat cellHeight;

@end

@implementation MSUDetailCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = HEXCOLOR(0xffffff);
    _tableView.scrollEnabled = YES;
    [self addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.panGestureRecognizer.delaysTouchesBegan = self.tableView.delaysContentTouches;
    [_tableView registerClass:[MSUDetaiCommentTableCell class] forCellReuseIdentifier:@"commentCell"];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfHeight - (SelfWidth*9/21+64+37));
    }];
    
    MSUCommentTopView *topView = [[MSUCommentTopView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, 165.5)];
    _tableView.tableHeaderView = topView;
    

}


#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUDetaiCommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contenLab.text = @"呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵";
    CGRect rectA = [MSUStringTools danamicGetHeightFromText:cell.contenLab.text WithWidth:SelfWidth-(14+33+10+14) font:14];
    cell.contenLab.frame = CGRectMake(14+33+10, 28+14+10+11+8+11+16, SelfWidth-(14+33+10+14), rectA.size.height);
    
    cell.lineView.frame = CGRectMake(0, CGRectGetMaxY(cell.contenLab.frame)+14,SelfWidth, 1);
    
    self.cellHeight = CGRectGetMaxY(cell.lineView.frame);
    
    return cell;
}



@end
