//
//  MSUNoDataView.m
//  Yu
//
//  Created by yl20027 on 2017/11/11.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUNoDataView.h"

#import "MSUPathTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

@implementation MSUNoDataView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}


- (void)createView{
    UIImageView *imaView = [[UIImageView alloc] init];
    imaView.contentMode = UIViewContentModeScaleAspectFit;
    imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"comment_image_none"];
    [self addSubview:imaView];
    [imaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(SelfWidth*0.5-50);
        make.left.equalTo(self.left).offset(SelfWidth*0.5-50);
        make.width.equalTo(100);
        make.height.equalTo(100);
    }];

}

@end
