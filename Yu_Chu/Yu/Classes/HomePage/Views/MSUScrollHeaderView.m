//
//  MSUScrollHeaderView.m
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


#import "MSUScrollHeaderView.h"

@implementation MSUScrollHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(SelfWidth * 4 ,0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfWidth*3/7);
    }];
    

    for (NSInteger i = 0; i < 4; i++) {
        self.imaView = [[UIImageView alloc] init];
        //        _imaView.backgroundColor = [UIColor];
        //        [_imaView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://source.showbuy100.com%@",arr[i]]]];
        _imaView.backgroundColor = [UIColor brownColor];
        _imaView.contentMode = UIViewContentModeScaleToFill;
        [_scrollView addSubview:_imaView];
        [_imaView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView.top).offset(0);
            make.left.equalTo(_scrollView.left).offset(SelfWidth*i);
            make.width.equalTo(SelfWidth);
            make.height.equalTo(SelfWidth*3/7);
        }];
    }

    
    
    self.pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPageIndicatorTintColor = HEXCOLOR(0xff4e1e);
    _pageControl.pageIndicatorTintColor = HEXCOLOR(0xffffff);
    _pageControl.numberOfPages = 4;
    [_scrollView addSubview:_pageControl];
    [_pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-18);
        make.left.equalTo(self.left).offset(SelfWidth * 0.5-100);
        make.width.equalTo(200);
        make.height.equalTo(25);
    }];
    
}


@end
