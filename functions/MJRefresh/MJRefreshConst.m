//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

const CGFloat MJRefreshHeaderHeight = 54.0;
const CGFloat MJRefreshFooterHeight = 64.0;
const CGFloat MJRefreshFastAnimationDuration = 0.4;
const CGFloat MJRefreshSlowAnimationDuration = 0.8;
#pragma mark QQReader 拓展
const CGFloat MJRefreshHeadNeedStayTime = 0.6;
#pragma mark QQReader 拓展end

NSString *const MJRefreshKeyPathContentOffset = @"contentOffset";
NSString *const MJRefreshKeyPathContentInset = @"contentInset";
NSString *const MJRefreshKeyPathContentSize = @"contentSize";
NSString *const MJRefreshKeyPathPanState = @"state";

NSString *const MJRefreshHeaderLastUpdatedTimeKey = @"MJRefreshHeaderLastUpdatedTimeKey";

NSString *const MJRefreshHeaderIdleText = @"下拉可以刷新";
NSString *const MJRefreshHeaderPullingText = @"松开立即刷新";
NSString *const MJRefreshHeaderRefreshingText = @"正在刷新数据中...";

NSString *const MJRefreshAutoFooterIdleText = @"点击或上拉加载更多";
NSString *const MJRefreshAutoFooterRefreshingText = @"加载中...";
NSString *const MJRefreshAutoFooterNoMoreDataText = @"已经全部加载完毕";

NSString *const MJRefreshBackFooterIdleText = @"上拉可以加载更多";
NSString *const MJRefreshBackFooterPullingText = @"松开立即加载更多";
NSString *const MJRefreshBackFooterRefreshingText = @"加载中...";
NSString *const MJRefreshBackFooterNoMoreDataText = @"没有更多了";