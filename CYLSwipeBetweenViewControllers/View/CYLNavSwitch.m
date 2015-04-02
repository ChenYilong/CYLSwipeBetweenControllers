//
//  NavSwitch.m
//  Bells
//
//  Created by whj on 15/1/11.
//  Copyright (c) 2015年 jinglingzaixian. All rights reserved.
//  kBackgroundColor决定着背景颜色，kSelectedTextColor决定着选中后的字体颜色

#import "CYLNavSwitch.h"
#define kNormalTextColor [UIColor whiteColor]
#define kSelectedTextColor [UIColor colorWithRed:(0)/255.f green:(150)/255.f blue:(136)/255.f alpha:1.f]
#define  kBackgroundColor [UIColor colorWithRed:158/255.0 green:221/255.0 blue:214/255.0 alpha:1]
#define kUnderLineColor kSelectedTextColor;
#define kUnderLineViewHeight 2.0
@interface CYLNavSwitch ()
/** 记录被选中的按钮 */
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *underLineView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) NSString *notifiPrefix;
@property (nonatomic, strong) NSArray *nameArr;

@end


@implementation CYLNavSwitch


- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (id)sharedInit {
    self.underLineColor = kUnderLineColor;
    self.switchViewbgColor = kBackgroundColor;
    self.normalTextColor = kNormalTextColor;
    self.selectedTextColor = kSelectedTextColor;
    return self;
}

// 懒加载
- (NSMutableArray *)buttonsArray
{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}

//static NSArray *nameArr;

/**
 *  懒加载_nameArr
 *
 *  @return NSArray
 */
- (NSArray *)nameArr
{
    if (_nameArr == nil) {
        _nameArr = [[NSArray alloc] init];
    }
    return _nameArr;
}

+ (instancetype)navSwitchWithNameArray:(NSArray *)nameArray
{
//    nameArr = nameArray;
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
//        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
        self.backgroundColor = self.switchViewbgColor;

        // 创建并设置按钮
        for (NSUInteger i = 0; i < self.nameArr.count; i++) {
            [self btnWithName:self.nameArr[i] number:i];
        }

        // 创建滑动条
        UIView *underLineView = [[UIView alloc] init];
        [self addSubview:underLineView];
        underLineView.backgroundColor = self.underLineColor;
        self.underLineView = underLineView;

        // 监听BellsLibraryViewController中主scrollView滚动结束的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBtnState:) name:@"ScrollViewDidEndDraggingNotification" object:nil];
    }
    return self;
}
/**
 *  初始化创建CYLNavSwitch对象
 *
 *  @param nameArray           switch 的标题，是字符串数组
 *  @param notificationPrefix 通知名称，如果为 nil，默认是当前类名，如果想更改，直接传入任意字符串
 *
 *  @return 初始化过的CYLNavSwitch对象
 */
- (instancetype)initWithNameArray:(NSArray *)nameArray andNotificationPrefix:(NSString *)notificationPrefix delegate:(id<NavSwitchDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.nameArr = nameArray;
        NSString *classNameString = NSStringFromClass([self.delegate class]);
        NSLog(@"classNameString：%@", classNameString);
        if(notificationPrefix.length == 0) {
            notificationPrefix = classNameString;
        }
        if (![self.notifiPrefix isEqualToString:notificationPrefix]) {
            self.notifiPrefix = notificationPrefix;
            [self addNewNotification:notificationPrefix];
            
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
            self.backgroundColor = self.switchViewbgColor;
            // 创建并设置按钮
            for (NSUInteger i = 0; i < self.nameArr.count; i++) {
                [self btnWithName:self.nameArr[i] number:i];
            }
            
            // 创建滑动条
            UIView *vw = [[UIView alloc] init];
            [self addSubview:vw];
            vw.backgroundColor = self.underLineColor;
            self.underLineView = vw;
        }
    }
    return self;
}
/**
 *  添加监听
 */
- (void)addNewNotification:(NSString *)notificationName
{
    // 监听BellsLibraryViewController中主scrollView滚动结束的通知
    NSString *draggingStr = [NSString stringWithFormat:@"%@ScrollViewDidEndDraggingNotification", notificationName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBtnState:) name:draggingStr object:nil];
}
/**
 * 取消监听通知
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 创建并设置子控件
 */
- (void)btnWithName:(NSString *)name number:(NSUInteger)number
{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor:self.switchViewbgColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btn.contentMode = UIViewContentModeCenter;
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:self.normalTextColor forState:UIControlStateNormal];
    [btn setTitleColor:self.selectedTextColor forState:UIControlStateDisabled];

    // 监听按钮点击
    [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 默认情况下，选中的是defaultBtn
    if (number == 0) {
        [self btnDidClick:btn];
        btn.enabled = NO;
    }
    // 绑定tag
    btn.tag = number;
    
    [self addSubview:btn];
    [self.buttonsArray addObject:btn];
}

/**
 *  监听按钮点击（当按钮被点击时，通知代理去做一些操作）
 */
- (void)btnDidClick:(UIButton *)btn
{
    // 通知代理做事情 --- (第一来这里时，此时的delegate == nil)
    if ([self.delegate respondsToSelector:@selector(navSwitch:didBtnClick:)]) {
        [self.delegate navSwitch:self didBtnClick:(NSUInteger)btn.tag];
    }
}

/**
 * 接收到通知后，改变按钮的状态
 */
- (void)changeBtnState:(NSNotification *)notification
{
    NSString *notificationName = [NSString stringWithFormat:@"%@ScrollVwContextOffsetX", [[notification userInfo] valueForKey:@"notificationPrefix"]];
    NSLog(@"%@", notificationName);
    NSString *str = [[notification userInfo] valueForKey:notificationName];
    
    
    CGFloat offsetX = [str doubleValue];
    
    NSUInteger offset = (NSUInteger)((offsetX + [UIScreen mainScreen].bounds.size.width/2)/[UIScreen mainScreen].bounds.size.width);
    
    for (NSUInteger ii = 0; ii < self.buttonsArray.count; ii++) {
        UIButton *btn = self.buttonsArray[ii];
        if (ii == offset) {
            if (btn.enabled==TRUE) {
                NSLog(@"‼️‼️‼️‼️‼️%@btn.enabled==NO",@(ii));
                btn.enabled = FALSE;
                [self changeButtonLineState:btn];
            }
        } else
        {
            if (btn.enabled==FALSE) {
            btn.enabled = TRUE;
            NSLog(@"‼️‼️‼️‼️‼️%@btn.enabled==YES",@(ii));
            }
        }
    }
}


/**
 * 改变滑动的位置
 */
- (void)changeButtonLineState:(UIButton *)btn
{
    CGFloat locationX = ([UIScreen mainScreen].bounds.size.width/self.nameArr.count)*btn.tag;
    if (self.underLineView.frame.origin.x != locationX) {
        [UIView animateWithDuration:0.3 animations:^{
            //仅修改self.underLineView的x,ywh值不变
            self.underLineView.frame = CGRectMake(locationX, self.underLineView.frame.origin.y, self.underLineView.frame.size.width, self.underLineView.frame.size.height);
        }];
    }
}




/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局子控件UIButton
    for (int i = 0; i < self.subviews.count; i++) {
        
        id sub = self.subviews[i];
        
        if ([sub isKindOfClass:[UIButton class]]) {
            // 子控件是UIButton
            UIButton *btn = (UIButton *)sub;
            //仅修改btn的宽度,xyh值不变
            btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, [UIScreen mainScreen].bounds.size.width/self.nameArr.count, btn.frame.size.height);
            //仅修改btn的高度,xyw值不变
            btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, self.frame.size.height);
            //仅修改btn的y,xwh值不变
            btn.frame = CGRectMake(btn.frame.origin.x, 0, btn.frame.size.width, btn.frame.size.height);
            //仅修改btn的x,ywh值不变
            btn.frame = CGRectMake(btn.frame.size.width*btn.tag, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        }
    }
    
    // 布局子控件UIView
    self.underLineView.frame = CGRectMake(0, self.frame.size.height -kUnderLineViewHeight, [UIScreen mainScreen].bounds.size.width/self.nameArr.count, kUnderLineViewHeight);
}

@end

