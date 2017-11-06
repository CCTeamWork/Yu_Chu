//
//  MSUAllOrderView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUAllOrderView.h"

#import "MSUOrderTopTableCell.h"
#import "MSUOrderBottomTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MSUAllOrderView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MSUAllOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.topTableView = [[UITableView alloc] init];
    _topTableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    _topTableView.scrollEnabled = YES;
    [self addSubview:_topTableView];
    self.topTableView.delegate = self;
    self.topTableView.dataSource = self;
    self.topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topTableView.panGestureRecognizer.delaysTouchesBegan = self.topTableView.delaysContentTouches;
    _topTableView.rowHeight = 108;
    [_topTableView registerClass:[MSUOrderTopTableCell class] forCellReuseIdentifier:@"orderTopell"];
    [_topTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(108);
    }];

    self.bootomTableView = [[UITableView alloc] init];
    _bootomTableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    _bootomTableView.scrollEnabled = YES;
    [self addSubview:_bootomTableView];
    self.bootomTableView.delegate = self;
    self.bootomTableView.dataSource = self;
    self.bootomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.bootomTableView.panGestureRecognizer.delaysTouchesBegan = self.bootomTableView.delaysContentTouches;
    _bootomTableView.rowHeight = 167;
    [_bootomTableView registerClass:[MSUOrderBottomTableCell class] forCellReuseIdentifier:@"orderBottomell"];
    [_bootomTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topTableView.bottom).offset(6);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfHeight-64-49-108-6);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.topTableView == tableView) {
        return 1;
    } else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.topTableView) {
        MSUOrderTopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderTopell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        
 
        
        return cell;
    } else{
        MSUOrderBottomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderBottomell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        
        __weak typeof(self) weakSelf = self;
        cell.commentBlickBlock = ^(UIButton *btn) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(commentClick)]) {
                [strongSelf.delegate commentClick];
            }
        };
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _topTableView) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(topTableViewCellDidSelect)]) {
            [self.delegate topTableViewCellDidSelect];
        }
    } else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(bottomTableViewCellDidSelect)]) {
            [self.delegate bottomTableViewCellDidSelect];
        }
    }
}

@end
