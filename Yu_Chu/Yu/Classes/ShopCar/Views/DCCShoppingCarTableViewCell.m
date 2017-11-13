//
//  DCCShoppingCarTableViewCell.m
//  Yu
//
//  Created by duanchongchong on 2017/11/4.
//

#import "DCCShoppingCarTableViewCell.h"
#import "XLZHHeader.h"
#import "Masonry.h"
#import "YYText.h"

@implementation DCCShoppingCarTableViewCell{
    UIImageView *_shopHeadIMGV;
    UILabel *_shopNameLab;
    
    UILabel *_discountLab;
    UILabel *_totalLab;
    UIView *_shopOwerV;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initAllSubviews];
    }
    return self;
}
- (void)clickShopOwner:(UITapGestureRecognizer *)ges{
    //点击了标题
    UIView *singleTapView = [ges view];
    NSInteger tag = singleTapView.tag;
    NSLog(@"%ld",tag);
    if (tag == 500) {
        //跳转商家主页
        if (self.callBackClimpSale) {
            self.callBackClimpSale();
        }
    }else{
        //跳转对应商品列表
        
    }
}
- (void)initAllSubviews{
    self.backgroundColor = JQXXXLZHFAFAFACLOLR;
    _shopOwerV = [[UIView alloc] init];
    _shopOwerV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    _shopOwerV.userInteractionEnabled = YES;
    [self addSubview:_shopOwerV];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShopOwner:)];
    [_shopOwerV addGestureRecognizer:tapGes];
    UIView *singleTapView = [tapGes view];
    singleTapView.tag = 500;
    
    UIView *bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    bottomV.userInteractionEnabled = YES;
    [self addSubview:bottomV];
    
    [_shopOwerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.height.mas_equalTo(63.0);
    }];
    
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.height.mas_equalTo(100);
    }];
    
    _shopHeadIMGV = [[UIImageView alloc] init];
    _shopHeadIMGV.layer.cornerRadius = 17.5;
    _shopHeadIMGV.clipsToBounds = YES;
    _shopHeadIMGV.image =[UIImage imageNamed:@"img_big"];
    [_shopOwerV addSubview:_shopHeadIMGV];
    
    _shopNameLab = [[UILabel alloc] init];
    _shopNameLab.textColor = JQXXXLZH272727CLOLR;
    _shopNameLab.font = [UIFont systemFontOfSize:14];
    [_shopOwerV addSubview:_shopNameLab];
    
    UIImageView *rightIMGV = [[UIImageView alloc] init];
    rightIMGV.image = [UIImage imageNamed:@"icon_arrow"];
    [_shopOwerV addSubview:rightIMGV];
    
    _removeBtn = [[UIButton alloc] init];
    [_removeBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    _removeBtn .contentHorizontalAlignment = 0;
    _removeBtn.contentVerticalAlignment = 0;
    [_shopOwerV addSubview:_removeBtn];
    
    UIView *topLineV = [[UIView alloc] init];
    topLineV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [_shopOwerV addSubview:topLineV];
    
    [_shopHeadIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopOwerV.mas_left).with.offset(14);
        make.centerY.equalTo(_shopOwerV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    [_shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopHeadIMGV.mas_right).with.offset(13.5);
        make.centerY.equalTo(_shopOwerV.mas_centerY).with.offset(0);
    }];
    
    [rightIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopNameLab.mas_right).with.offset(10);
        make.centerY.equalTo(_shopOwerV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(13);
    }];
    
    [_removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_shopOwerV.mas_right).with.offset(0);
        make.centerY.equalTo(_shopOwerV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
    
    [topLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopOwerV.mas_left).with.offset(14);
        make.right.equalTo(_shopOwerV.mas_right).with.offset(-14);
        make.bottom.mas_equalTo(_shopOwerV.frameSizeHeight-1);
        make.height.mas_equalTo(1.0);
    }];
    
    
    _discountLab = [UILabel new];
    _discountLab.preferredMaxLayoutWidth = kScreenWidth - 30; //设置最大的宽度
    [bottomV addSubview:_discountLab];
    
    _totalLab = [[UILabel alloc] init];
    _totalLab.textColor = JQXXXLZHFF2D4BCLOLR;
    _totalLab.font = [UIFont systemFontOfSize:14];
    [bottomV addSubview:_totalLab];
    
    _commitBtn = [[UIButton alloc] init];
    [_commitBtn setTitle:@"结算" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _commitBtn.contentHorizontalAlignment = 0;
    _commitBtn.contentVerticalAlignment = 0;
    _commitBtn.backgroundColor = JQXXXLZHFF2D4BCLOLR;
    _commitBtn.layer.cornerRadius = 5.0;
    [bottomV addSubview:_commitBtn];
    
    [_discountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomV.mas_left).with.offset(14);
        make.top.equalTo(bottomV.mas_top).with.offset(14);
    }];
    
    [_totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomV.mas_right).with.offset(-14);
        make.top.equalTo(bottomV.mas_top).with.offset(14);
    }];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomV.mas_right).with.offset(-14);
        make.top.equalTo(_totalLab.mas_bottom).with.offset(25);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(29);
    }];
    
}
- (void)initAllData:(DCCShopCarModel *)model{
    _shopNameLab.text = model.shopName;
    [_shopHeadIMGV sd_setImageWithURL:[NSURL URLWithString:model.shopLogo]];
    NSString *contentS = [NSString stringWithFormat:@"已享受满减，优惠%@元",@"0"];
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: contentS];
    text.yy_font = [UIFont systemFontOfSize:12];
    text.yy_color = JQXXXLZHD2D2D2CLOLR;
    [text yy_setColor:JQXXXLZHFF2D4BCLOLR range:[contentS rangeOfString:@"0"]];
    _discountLab.attributedText = text;
    _discountLab.hidden = YES;

    
    UIView *currentV = _shopOwerV;
    CGFloat totalPrice = 0;
    for (NSInteger i=0; i< model.shopCars.count; i++) {
        NSArray <DCCGoodsModel *>*modelARR = model.shopCars;
        DCCGoodsModel *goodModel = modelARR[i];
        UIView *contentV = [[UIView alloc] init];
        contentV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
        contentV.userInteractionEnabled = YES;
        [self addSubview:contentV];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShopOwner:)];
        [contentV addGestureRecognizer:tapGes];
        UIView *singleTapView = [tapGes view];
        singleTapView.tag = i + 501;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.top.equalTo(currentV.mas_bottom).with.offset(0);
            make.height.mas_equalTo(80);
        }];
        
        UIImageView *leftIMGV = [[UIImageView alloc] init];
        [leftIMGV sd_setImageWithURL:[NSURL URLWithString:goodModel.coverImage]];
        leftIMGV.layer.cornerRadius = 2.5;
        [contentV addSubview:leftIMGV];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = JQXXXLZH272727CLOLR;
        titleLab.text = goodModel.dishName;
        titleLab.font = [UIFont systemFontOfSize:12];
        [contentV addSubview:titleLab];
        
        UILabel *countLab = [[UILabel alloc] init];
        countLab.textColor = JQXXXLZH272727CLOLR;
        countLab.text = [NSString stringWithFormat:@"x%@",goodModel.count];
        countLab.font = [UIFont systemFontOfSize:12];
        [contentV addSubview:countLab];
        
        UILabel *priceLab = [[UILabel alloc] init];
        priceLab.textColor = JQXXXLZHFF2D4BCLOLR;
        priceLab.font = [UIFont systemFontOfSize:14];
        priceLab.text = [NSString stringWithFormat:@"¥%.2f",goodModel.dishPrice.doubleValue];
        [contentV addSubview:priceLab];
        
        [leftIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentV.mas_left).with.offset(14);
            make.centerY.equalTo(contentV.mas_centerY).with.offset(0);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftIMGV.mas_right).with.offset(12);
            make.top.equalTo(leftIMGV.mas_top);
        }];
        
        [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftIMGV.mas_right).with.offset(12);
            make.top.equalTo(titleLab.mas_top).with.offset(12);
        }];
        
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentV.mas_right).with.offset(-14);
            make.centerY.equalTo(contentV.mas_centerY).with.offset(0);
        }];
        currentV = contentV;
        if (i == (model.shopCars.count-1)) {
            UIView *topLineV = [[UIView alloc] init];
            topLineV.backgroundColor = JQXXXLZHFAFAFACLOLR;
            [contentV addSubview:topLineV];
            
            [topLineV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(contentV.mas_left).with.offset(14);
                make.right.equalTo(contentV.mas_right).with.offset(-14);
                make.bottom.mas_equalTo(contentV.frameSizeHeight-1);
                make.height.mas_equalTo(1.0);
            }];
        }
        totalPrice += goodModel.dishPrice.doubleValue * goodModel.count.integerValue;
    }
    _totalLab.text = [NSString stringWithFormat:@"合计 ¥%.2f元",totalPrice];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
