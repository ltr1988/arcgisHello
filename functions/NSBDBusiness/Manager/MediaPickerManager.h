//
//  MediaPickerManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELCImagePickerController.h"


typedef void (^ImagePickBlock)(NSArray *imageList);
typedef void (^VideoPickBlock)(NSURL *videoURL);

@interface MediaPickerManager : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,ELCImagePickerControllerDelegate>
@property (nonatomic,assign) BOOL pickImage;
@property (nonatomic,weak) UIViewController *weakVC;
@property (nonatomic,copy) ImagePickBlock imagePickBlock;
@property (nonatomic,copy) VideoPickBlock videoPickBlock;

-(instancetype) initWithViewController:(UIViewController *)vc ImagePickBlock:(ImagePickBlock) iblock VideoPickBlock:(VideoPickBlock) vblock;
-(void)openMenuInView:(UIView *)view;

+(void) movContertToMp4:(NSURL *)sourceUrl completeBlock:(VideoPickBlock) block;
@end
