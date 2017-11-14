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

#import "UIButton+WebCache.h"

#import "MSUDetailCommentView.h"
#import "MSUCommentTopView.h"

#import "MSUHUD.h"
#import "MSUAFNRequest.h"
#import "MSUTimerHandler.h"

@interface MSUDetailCommentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , assign) CGFloat cellHeight;

@property (nonatomic , strong) MSUCommentTopView *topView;

@end

@implementation MSUDetailCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}

- (void)setCommentModel:(MSUDataModel *)commentModel{
    _commentModel = commentModel;
    
    MSUCommentDetailModel *dataModel = _commentModel.dataList[0];
    _topView.commentLab.text = [NSString stringWithFormat:@"%0.1f",[dataModel.averageCcore doubleValue]];
    for (NSInteger i = 0; i < [dataModel.averageCcore integerValue]; i++) {
        UIImageView *ima = _topView.starArr[i];
        ima.highlighted = YES;
    }
    
    [self.tableView reloadData];
    
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
    
    self.topView = [[MSUCommentTopView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, 165.5)];
    _tableView.tableHeaderView = _topView;
    

}


#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentModel.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUDetaiCommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MSUCommentDetailModel *detailModel = self.commentModel.dataList[indexPath.row];
    [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:detailModel.portrait] forState:UIControlStateNormal placeholderImage:[MSUPathTools showImageWithContentOfFileByName:@"shop_img_head"]];
    cell.nickLab.text = detailModel.nickname;
    
    for (NSInteger i = 0; i < [detailModel.averageCcore integerValue]; i++) {
        UIImageView *ima = cell.starArr[i];
        ima.highlighted = YES;
    }
    
    cell.timeLab.text = [MSUTimerHandler exchangeTimefromTimeTamp:detailModel.createdTime];
    
    cell.contenLab.text = detailModel.content;
    CGRect rectA = [MSUStringTools danamicGetHeightFromText:cell.contenLab.text WithWidth:SelfWidth-(14+33+10+14) font:14];
    cell.contenLab.frame = CGRectMake(14+33+10, 28+14+10+11+8+11+16, SelfWidth-(14+33+10+14), rectA.size.height);
    
    if ([detailModel.isPraise isEqualToString:@"1"]) {
        cell.likeBtn.selected = YES;
        cell.likeBtn.userInteractionEnabled = NO;
    } else{
        cell.likeBtn.selected = NO;
    }
    
    cell.numLab.text = detailModel.praiseNum;

    __weak typeof(cell) weakCell = cell;
    cell.likeBtnBlock = ^(UIButton *sender) {
        __strong typeof(weakCell) strongCell = weakCell;

        sender.selected = !sender.selected;
        if (sender.selected) {
            strongCell.numLab.text = [NSString stringWithFormat:@"%ld",[detailModel.praiseNum integerValue] +1];
        } else{
            strongCell.numLab.text = [NSString stringWithFormat:@"%ld",[detailModel.praiseNum integerValue] ];
        }
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"dccLoginToken"];
        if (!token) {
            token = @"";
        }
        
        NSDictionary *dic = @{@"token":token,@"id":detailModel.comment_id};
        NSLog(@"--- dic %@",dic);
        [[MSUAFNRequest sharedInstance] postRequestWithURL:@"http://192.168.10.21:8202/member/shop/praise" parameters:dic withBlock:^(id obj, NSError *error) {
            if (obj) {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableLeaves error:nil];
                if (!error) {
                    NSLog(@"访问成功%@",jsonDict);
                    if([jsonDict[@"code"] isEqualToString:@"200"]){
//                        strongCell.numLab.text = [NSString stringWithFormat:@"%@",jsonDict[@"data"][@"isPraise"]];
                        
                        
                    } else{
                      
                    }
                    
                }else{
                    NSLog(@"访问报错%@",error);
                }
                
            } else{
                [MSUHUD showFileWithString:@"服务器请求为空"];
            }
            
        }];

    };
    
    cell.lineView.frame = CGRectMake(0, CGRectGetMaxY(cell.contenLab.frame)+14,SelfWidth, 1);
    
    self.cellHeight = CGRectGetMaxY(cell.lineView.frame);
    
    return cell;
}



@end
