//
//  SearchHistoryTaskItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchHistoryItem;

@interface SearchHistoryTaskItem : NSObject
@property (nonatomic,strong) NSArray* datalist;

-(SearchHistoryItem*) searchHistoryItem;
-(instancetype) initWithSearchHistoryMetaArray:(NSArray *)array;
@end
