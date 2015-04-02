//
//  NavSwitch.h
//  Bells
//
//  Created by chenyilong on 15/1/11.
//  Copyright (c) 2015年 chenyilong. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum {
//    NavSwitchButtonTypeHot,  // “我的关注”按钮
//    NavSwitchButtonTypeNewest,  // “关注我的”按钮
//} NavSwitchButtonType;

@class CYLNavSwitch;

@protocol NavSwitchDelegate<NSObject>
@optional
- (void)navSwitch:(CYLNavSwitch *)navSwitch didBtnClick:(NSUInteger)number;
@end




@interface CYLNavSwitch : UIView

+ (instancetype)navSwitchWithNameArray:(NSArray *)nameArray;
- (instancetype)initWithNameArray:(NSArray *)nameArray andNotificationPrefix:(NSString *)notificationPrefix delegate:(id<NavSwitchDelegate>)delegate;

@property (nonatomic, weak) id<NavSwitchDelegate> delegate;
@property (nonatomic, strong) UIColor *underLineColor;
@property (nonatomic, strong) UIColor *switchViewbgColor;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
//@property (nonatomic, strong) NSArray *nameArray;

@end
