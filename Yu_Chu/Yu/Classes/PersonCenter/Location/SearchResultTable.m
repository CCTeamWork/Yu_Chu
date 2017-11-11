//
//  SearchResultTableVC.m
//  小莱
//
//  Created by jack on 16/7/19.
//  Copyright © 2016年 李丹阳. All rights reserved.
//

#import "SearchResultTable.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "XLZHHeader.h"

@interface SearchResultTable () <AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation SearchResultTable
{
    NSString *_city;
    // 搜索key
    NSString *_searchString;
    // 搜索页数
    NSInteger searchPage;
    // 搜索API
    AMapSearchAPI *_searchAPI;
    // 搜索结果数组
    NSMutableArray *_searchResultArray;
    // 下拉更多请求数据的标记
    BOOL isFromMoreLoadRequest;
}

- (void)searchWithText:(NSString *)text
{
    _searchString = text;
    searchPage = 1;
    [self searchPoiBySearchString:_searchString];
}

#pragma mark - AMapSearchDelegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    // 判断是否从更多拉取
    if (isFromMoreLoadRequest) {
        isFromMoreLoadRequest = NO;
    }
    else{
        [_searchResultArray removeAllObjects];
        // 刷新后TableView返回顶部
        [self setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    // 刷新完成,没有数据时不显示footer
    if (response.pois.count == 0) {
        //self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    else {
        //self.tableView.mj_footer.state = MJRefreshStateIdle;
        // 添加数据并刷新TableView
        [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
            [_searchResultArray addSafeObject:obj];
        }];
    }
    if ([self.mDelegate respondsToSelector:@selector(shouldShowTable:)]) {
        [self.mDelegate shouldShowTable:self];
    }
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellReuseIdentifier = @"searchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseIdentifier];
    }
    AMapPOI *poi = [_searchResultArray objectAtIndex:indexPath.row];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:poi.name];
    [text addAttribute:NSForegroundColorAttributeName value:JQXXXLZH272727CLOLR range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, text.length)];
    //高亮
    NSRange textHighlightRange = [poi.name rangeOfString:_searchString];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:textHighlightRange];
    cell.textLabel.attributedText = text;
    
    NSMutableAttributedString *detailText = [[NSMutableAttributedString alloc] initWithString:poi.address];
    [detailText addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, detailText.length)];
    [detailText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, detailText.length)];
    //高亮
    NSRange detailTextHighlightRange = [poi.address rangeOfString:_searchString];
    [detailText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:detailTextHighlightRange];
    cell.detailTextLabel.attributedText = detailText;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    tableView.hidden = YES;

    if ([self.mDelegate respondsToSelector:@selector(setSelectedLocationWithLocation:)]) {
        [self.mDelegate setSelectedLocationWithLocation:_searchResultArray[indexPath.row]];
    }
}

#pragma mark - Action
- (void)searchPoiBySearchString:(NSString *)searchString
{
    //POI关键字搜索
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = searchString;
    request.city = _city;
    request.cityLimit = YES;
    request.page = searchPage;
    [_searchAPI AMapPOIKeywordsSearch:request];
}

- (void)loadMoreData
{
    searchPage++;
    isFromMoreLoadRequest = YES;
    [self searchPoiBySearchString:_searchString];
}

#pragma mark - 初始化
- (instancetype)init{
    if (self = [super init]) {
        
        _searchAPI = [[AMapSearchAPI alloc] init];
        _searchAPI.delegate = self;
        self.delegate = self;
        self.dataSource = self;
        
        _searchResultArray = [NSMutableArray array];
    }
    return self;
}

- (void)setSearchCity:(NSString *)city
{
    _city = city;
}

@end
