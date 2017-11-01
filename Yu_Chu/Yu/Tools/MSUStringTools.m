//
//  MSUStringTools.m
//  测试
//
//  Created by Zhuge_Su on 2017/7/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUStringTools.h"
#import <UIKit/UIKit.h>

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUStringTools

#pragma mark - 移除字符串中的空格和换行
/* 移除字符串中的空格和换行 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

#pragma mark - 判断字符串中是否有中文
/* 判断字符串中是否有中文 */
+ (BOOL)isContainChinese:(NSString *)str{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

#pragma mark - 将阿拉伯数字转换成汉文数字
/* 将阿拉伯数字转换成汉文数字 */
+ (NSString *)translationToStringWithArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
            
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

#pragma mark - 将日期转换成古月份
/* 将日期转换成古月份 */
+ (NSString *)translationChineseWithArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    NSArray *chineseNumeralsArray = @[@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖",@"拾",@"冬",@"腊"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    NSString *chinese = [dictionary objectForKey:arabicNumStr];
    return chinese;
    
}

#pragma mark - 富文本 修改局部字段颜色
/* 富文本 修改局部（前半部或后半部）字段颜色 */
+ (NSMutableAttributedString*)changeLabelWithText:(NSString*)needText AndFromOrigiFont:(CGFloat)origi toChangeFont:(CGFloat)change AndFromOrigiLoca:(NSInteger)loca WithBeforePart:(NSInteger)part
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:origi] range:NSMakeRange(0,loca)];
    
    [attrString addAttribute:NSKernAttributeName value:@1.0f range:NSMakeRange(0, needText.length)];
    
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:change] range:NSMakeRange(loca,needText.length-loca)];

    // 如果是前半部分
    if (!part) {
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:236/255.0 green:0/255.0 blue:0/255.0 alpha:1] range:NSMakeRange(0,loca)];
        
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(loca,needText.length-loca)];
    }else{
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,loca)];
        
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:236/255.0 green:0/255.0 blue:0/255.0 alpha:1] range:NSMakeRange(loca,needText.length-loca)];

    }
    
    return attrString;
}

/* 在已有字符串中 修改 输入字符 颜色和大小 */
+ (NSMutableAttributedString *)makeKeyWordAttributedWithSubText:(NSString *)subText inOrigiText:(NSString *)origiText font:(CGFloat)font color:(UIColor *)color{
    // 获取关键字的位置
    NSRange range = [origiText rangeOfString:subText];
    
    // 转换成可以操作的字符串类型.
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:origiText];
    
    // 添加属性(粗体)
    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    
    // 关键字高亮
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return attribute;
}

/* 在已有富文本字符串中 修改 输入字符 颜色和大小 */
+ (NSMutableAttributedString *)makeAttrubuteKeyWordAttributedWithSubText:(NSString *)subText inOrigiText:(NSMutableAttributedString *)origiText font:(CGFloat)font color:(UIColor *)color{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:origiText];

    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,subText.length)];

    
    return attrString;
}

#pragma amrk - 动态获取 String 宽高
/* 动态获取 String 宽 */
+ (CGSize)danamicGetWidthFromText:(NSString *)text WithFont:(CGFloat)font{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil]];
    return size;
}

/* 动态获取 String 高 */
+ (CGRect)danamicGetHeightFromText:(NSString *)text WithWidth:(CGFloat)width font:(CGFloat)font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil];
    return rect;
}

/* 判断两个数组是否相同 */
+ (BOOL)judgeTheSameOfArrA:(NSMutableArray *)arrA WithArrB:(NSMutableArray *)arrB{
    //创建俩新的数组
    NSMutableArray *oldArr = [NSMutableArray arrayWithArray:arrA];
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:arrB];
    BOOL bol = false;

    //对数组1排序。
    [oldArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return obj1 > obj2;
    }];
    
    //对数组2排序。
    [newArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return obj1 > obj2;
    }];
    
    if (newArr.count == oldArr.count) {
        
        bol = true;
        for (int16_t i = 0; i < oldArr.count; i++) {
            
            id c1 = [oldArr objectAtIndex:i];
            id newc = [newArr objectAtIndex:i];
            
            if (![newc isEqualToString:c1]) {
                bol = false;
                break;
            }
        }
    }
    
    if (bol) {
//        NSLog(@"两个数组的内容相同！");
        return YES;
    }   
    else {   
//        NSLog(@"两个数组的内容不相同！");
        return NO;
    }
}

/* 压缩图片到指定尺寸  */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return image;
}

/* 压缩图片到指定大小  */
+ (NSData *)compressOriginalImage:(UIImage *)image withScale:(NSInteger)scale{
    NSData *data = nil;
    data =UIImageJPEGRepresentation(image,scale);

//    if(!UIImagePNGRepresentation(image)) {
//        data =UIImageJPEGRepresentation(image,scale);
//    }else{
//        data =UIImagePNGRepresentation(image);
//    }
    return data;
}

@end
