//
//  ViewController.m
//  SymptomPatientDemp
//
//  Created by chenyilong on 15/4/1.
//  Copyright (c) 2015年 chenyilong. All rights reserved.
//

#import "ViewController.h"
#import "CYLNavSwitch.h"
@interface ViewController ()<NavSwitchDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *switchScrollView;
@property (nonatomic, strong) NSArray *switchTitleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupScrollView];
    // 添加顶部菜单
    [self addNavSwitch];
}

/**
 * 添加顶部菜单
 */
- (void)addNavSwitch
{
    CYLNavSwitch *navSwitch = [CYLNavSwitch navSwitchWithNameArray:self.switchTitleArray];
    navSwitch.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    [self.view addSubview:navSwitch];
    [self.view bringSubviewToFront:navSwitch];
    // 设置代理
    navSwitch.delegate = self;
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height  - 44)];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * [self.switchTitleArray count], 0);
    scrollView.backgroundColor = [UIColor colorWithRed:(244.0)/255.f green:(248.0)/255.f blue:(247.0)/255.f alpha:1.f];
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [self.view bringSubviewToFront:scrollView];
    self.switchScrollView = scrollView;
    
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    firstView.backgroundColor = [UIColor redColor];
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    secondView.backgroundColor = [UIColor blueColor];
    [self.switchScrollView addSubview:firstView];
    [self.switchScrollView addSubview:secondView];
}

/**
 *  懒加载_switchTitleArray
 *
 *  @return NSArray
 */
- (NSArray *)switchTitleArray
{
    if (_switchTitleArray == nil) {
        _switchTitleArray = @[@"第一",@"第二"];
    }
    return _switchTitleArray;
}


#pragma UIScrollViewDelegate

/**
 * 实时调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 发通知
    NSString *str = [NSString stringWithFormat:@"%f",scrollView.contentOffset.x];
    NSDictionary *usInfo = [NSDictionary dictionaryWithObject:str forKey:@"ScrollVwContextOffsetX"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrollViewDidEndDraggingNotification" object:nil userInfo:usInfo];
}

#pragma NavSwitchDelegate方法

- (void)navSwitch:(CYLNavSwitch *)navSwitch didBtnClick:(NSUInteger)number
{
    [self.switchScrollView setContentOffset:CGPointMake(number*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
}

@end
