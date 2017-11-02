//
//  MSUHomeScrollView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUHomeScrollView.h"

#import "MSUHomeTableCell.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUScrollHeaderView.h"

@interface MSUHomeScrollView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic , strong) MSUScrollHeaderView *headerView;

@end

@implementation MSUHomeScrollView

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
    _tableView.rowHeight = 137 + SelfWidth*9/16;
    [_tableView registerClass:[MSUHomeTableCell class] forCellReuseIdentifier:@"homeCell"];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.bottom.equalTo(self.bottom).offset(0);;
    }];
    
    self.headerView = [[MSUScrollHeaderView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, SelfWidth*3/7)];
    _headerView.backgroundColor = HEXCOLOR(0xffffff);
    _tableView.tableHeaderView = _headerView;
    _headerView.scrollView.delegate = self;
  
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_headerView.pageControl setCurrentPage:(_headerView.scrollView.contentOffset.x + SelfWidth*0.5)/(SelfWidth-20)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUHomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewDidSelect)]) {
        [self.delegate tableViewDidSelect];
    }
}


@end
