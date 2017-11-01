/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

//获得视图的父控制器
- (UIViewController *)getParentviewController;
//设置push后的界面的leftItem只是箭头，且title为白色
- (void)setPushToViewLeftItemNil;
- (void)setTabBarPushToViewLeftItemNil;

/**
 *  获取cell所在的tableview,一般只是用来确定UITableViewCell的所属UITableview
 *
 *  @return 找到的UITableview
 */
- (UITableView *)ex_superTableView;


/**
 *  获取view所在的tableViewCell
 *
 *  @return view所在的tableViewCell
 */
- (UITableViewCell*)ex_superTableCell;

/**
 *  获取第一响应对象,可以是自己,或者自己的子类中寻找
 *
 *  @return 第一响应对象
 */
- (UIView *)ex_findFirstResponder;

@end
