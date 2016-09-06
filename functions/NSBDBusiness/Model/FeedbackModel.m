//
//  FeedbackModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/6.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "FeedbackModel.h"

@implementation FeedbackModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_date forKey:@"_date"];
    [aCoder encodeObject:_detail forKey:@"_detail"];
    
    [aCoder encodeObject:_images forKey:@"_images"];
    [aCoder encodeObject:_video forKey:@"_video"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        _date = [aDecoder decodeObjectForKey:@"_date"];
        _detail = [aDecoder decodeObjectForKey:@"_detail"];
        
        _images = [aDecoder decodeObjectForKey:@"_images"];
        _video = [aDecoder decodeObjectForKey:@"_video"];
    }
    
    return self;
}
@end
