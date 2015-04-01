//
//  NSString+General.h
//  hospitalLevelCheckDemo
//
//  Created by chenyilong on 15/3/31.
//  Copyright (c) 2015年 chenyilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (General)
-(id)JSONValue;
+(NSString *)cutoutString:(NSString *)string From:(NSString *)left to:(NSString *)right ;
+(NSString *)deleteString:(NSString *)deletedStr From:(NSString *)responseStr;
/**
 *  替换字符串
 *
 *  @param responseStr  原来的字符串
 *  @param oldStr 旧的字符串
 *  @param newStr 新的字符串
 *  @return 置换后的字符串
 */
+(NSString *)exchangeString:(NSString *)responseStr From:(NSString *)oldStr to:(NSString *)newStr;
+(NSString *)cutoutAndBelongOldStrWithString:(NSString *)string From:(NSString *)left to:(NSString *)right ;
+(NSString *)separatePhoneStringForSpeak:(NSString *)PhoneNumStr ;
- (BOOL)isContainString:(NSString *)needleString;
@end
