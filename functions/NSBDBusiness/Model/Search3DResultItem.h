//
//  Search3DResultItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search3DResultItem : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) CGPoint location;
@property (nonatomic,strong) NSArray *imageList;
@end
