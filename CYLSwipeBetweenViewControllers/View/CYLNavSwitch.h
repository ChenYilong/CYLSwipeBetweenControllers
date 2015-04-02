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

/**
 *  对象方法初始化创建CYLNavSwitch对象
 *
 *  @param nameArray           switch 的标题，是字符串数组
 *  @param notificationPrefix 通知名称，如果为 nil，默认是当前类名，如果想更改，直接传入任意字符串
 *
 *  @return 初始化过的CYLNavSwitch对象
 */
- (instancetype)initWithNameArray:(NSArray *)nameArray andNotificationPrefix:(NSString *)notificationPrefix delegate:(id<NavSwitchDelegate>)delegate;
/**
 *  类方法初始化创建CYLNavSwitch对象
 *
 *  @param nameArray           switch 的标题，是字符串数组
 *  @param notificationPrefix 通知名称，如果为 nil，默认是当前类名，如果想更改，直接传入任意字符串
 *
 *  @return 初始化过的CYLNavSwitch对象
 */
+ (instancetype)navSwitchWithNameArray:(NSArray *)nameArray andNotificationPrefix:(NSString *)notificationPrefix delegate:(id<NavSwitchDelegate>)delegate;
+(void)postNotificationWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate;

@property (nonatomic, weak) id<NavSwitchDelegate> delegate;
@property (nonatomic, strong) UIColor *underLineColor;
@property (nonatomic, strong) UIColor *switchViewbgColor;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
//@property (nonatomic, strong) NSArray *nameArray;

@end
