//
//  MSUWaitCommentView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "MSUWaitCommentView.h"

#import "MSUOrderBottomTableCell.h"

@interface MSUWaitCommentView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MSUWaitCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    
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
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfHeight-64-49);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUOrderBottomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderBottomell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    cell.commentBlickBlock = ^(UIButton *btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(commentClick)]) {
            [strongSelf.delegate commentClick];
        }
    };

    
    return cell;
}


@end
