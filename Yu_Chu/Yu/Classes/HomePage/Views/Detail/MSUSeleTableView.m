//
//  MSUSeleTableView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUSeleTableView.h"

#import "MSULeftTableCell.h"
#import "MSURightTableCell.h"

#import "UIImageView+WebCache.h"

#import "MSUStringTools.h"

@interface MSUSeleTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , assign) BOOL isScrollDown;


@end

@implementation MSUSeleTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}

- (void)setDetailModel:(MSUDetailModel *)detailModel{
    _detailModel = detailModel;
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

//     bgView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), WIDTH, HEIGHT-CGRectGetMaxY(_topView.frame)-49);

- (void)createView{
    self.leftTableView = [[UITableView alloc] init];
    _leftTableView.backgroundColor = HEXCOLOR(0xf4f4f4);
    _leftTableView.scrollEnabled = YES;
    [self addSubview:_leftTableView];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.panGestureRecognizer.delaysTouchesBegan = self.leftTableView.delaysContentTouches;
    _leftTableView.rowHeight = 56;
    [_leftTableView registerClass:[MSULeftTableCell class] forCellReuseIdentifier:@"leftCell"];
    [_leftTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(74);
        make.height.equalTo(SelfHeight-64-SelfWidth*9/21-40-49);
    }];

    self.rightTableView = [[UITableView alloc] init];
    _rightTableView.backgroundColor = HEXCOLOR(0xffffff);
    _rightTableView.scrollEnabled = YES;
    [self addSubview:_rightTableView];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.panGestureRecognizer.delaysTouchesBegan = self.rightTableView.delaysContentTouches;
    _rightTableView.rowHeight = 119;
    [_rightTableView registerClass:[MSURightTableCell class] forCellReuseIdentifier:@"rightCell"];
    [_rightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(_leftTableView.right).offset(0);
        make.width.equalTo(SelfWidth-74);
        make.height.equalTo(SelfHeight-64-SelfWidth*9/21-40-49);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_leftTableView == tableView) {
        return 1;
    } else{
        return _detailModel.data.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_rightTableView == tableView) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_rightTableView == tableView) {
        UIView *bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(0, 0, 0, 40);
        bgView.backgroundColor = HEXCOLOR(0xffffff);
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 0, SelfWidth-74, 1);
        lineView.backgroundColor = HEXCOLOR(0xfafafa);
        [bgView addSubview:lineView];

        MSUShopDetailModel *detaiModel = _detailModel.data[section];
        UILabel *attentionLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 1, SelfWidth-74, 39)];
        attentionLab.text = detaiModel.dishClassName;
        attentionLab.font = [UIFont systemFontOfSize:12];
        attentionLab.textColor = HEXCOLOR(0xff2d4b);
        [bgView addSubview:attentionLab];

        
        return bgView;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_leftTableView == tableView) {
        return _detailModel.data.count;
    } else{
        MSUShopDetailModel *detaiModel = _detailModel.data[section];

        return detaiModel.dishList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_leftTableView == tableView) {
        MSULeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = HEXCOLOR(0xf4f4f4);
        
        MSUShopDetailModel *shopModel = _detailModel.data[indexPath.row];
        NSMutableString *text = [[NSMutableString alloc] initWithString:shopModel.dishClassName];
        [text insertString:@"\n" atIndex:2];
        if (shopModel.dishClassName.length <= 4) {
            cell.centerLab.hidden = NO;
            cell.topLab.hidden = YES;
            cell.bottomlab.hidden = YES;
            cell.centerLab.text = shopModel.dishClassName;
        } else{
            cell.centerLab.hidden = YES;
            cell.topLab.hidden = NO;
            cell.bottomlab.hidden = NO;
            cell.topLab.text = [text substringToIndex:2];
            cell.bottomlab.text = [text substringFromIndex:2];
        }
        
//        cell.top

        if (indexPath.row == 0) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                            animated:YES
                                      scrollPosition:UITableViewScrollPositionNone];
        }
        
        return cell;
    } else{
        MSURightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MSUShopDetailModel *detaiModel = self.detailModel.data[indexPath.section];
        MSUMenuModel *menuModel = detaiModel.dishList[indexPath.row];
        
        [cell.shopImaView sd_setImageWithURL:[NSURL URLWithString:menuModel.coverImage]];
        cell.nameLab.text = menuModel.dishName;
        cell.introLab.text = menuModel.dishDisc;
        cell.priceLab.text = [NSString stringWithFormat:@"¥%@",menuModel.dishPrice];
        
        
        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        cell.addClickBlock = ^(UIButton *btn) {
            
//            NSInteger num = 0;

            __strong typeof(weakCell) strongCell = weakCell;
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            strongCell.numLab.hidden = NO;
            strongCell.deleBtn.hidden = NO;
            strongCell.numLab.text = [NSString stringWithFormat:@"%ld",[strongCell.numLab.text integerValue]+1];
//            CGSize sizeA = [MSUStringTools danamicGetWidthFromText:strongCell.numLab.text WithFont:15];
//            strongCell.numLab.frame = CGRectMake(SelfWidth-46-sizeA.width, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
            
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(seleDelegateToCaculateWithGoodsID:goodsNum:model:isAdd:)]) {
                [self.delegate seleDelegateToCaculateWithGoodsID:strongCell.priceLab.text goodsNum:strongCell.numLab.text model:menuModel isAdd:1];
            }
        };
        
       
        cell.deleClickBlock = ^(UIButton *btn) {
            __strong typeof(weakCell) strongCell = weakCell;
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            strongCell.numLab.text = [NSString stringWithFormat:@"%ld",[strongCell.numLab.text integerValue]-1];
            if ([strongCell.numLab.text isEqualToString:@"0"]) {
                [UIView animateWithDuration:0.25 animations:^{
                    weakCell.numLab.hidden = YES;
                    weakCell.deleBtn.hidden = YES;
                }];
            }
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(seleDelegateToCaculateWithGoodsID:goodsNum:model:isAdd:)]) {
                [strongSelf.delegate seleDelegateToCaculateWithGoodsID:strongCell.priceLab.text goodsNum:strongCell.numLab.text model:menuModel isAdd:0];
            }

        };
        
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_leftTableView == tableView) {
        
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } else{
        if (self.delegate && [_delegate respondsToSelector:@selector(seleRightDelegateToPush)]) {
            [self.delegate seleRightDelegateToPush];
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MSULeftTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];;
    cell.leftBtn.selected = NO;
}


// 标记一下 RightTableView 的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

// TableView 分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的 tableView 是 RightTableView，RightTableView 滚动的方向向上， RightTableView 是用户拖拽而产生滚动的（（主要判断 RightTableView 用户拖拽而滚动的，还是点击 LeftTableView 而滚动的）
    if ((_rightTableView == tableView) && !_isScrollDown && _rightTableView.dragging)
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView 分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的 tableView 是 RightTableView，RightTableView 滚动的方向向下， RightTableView 是用户拖拽而产生滚动的（主要判断 RightTableView 用户拖拽而滚动的，还是点击 LeftTableView 而滚动的）
    if ((_rightTableView == tableView) && _isScrollDown && _rightTableView.dragging)
    {
        [self selectRowAtIndexPath:section + 1];
    }
}

// 当拖动右边 TableView 的时候，处理左边 TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}



@end
