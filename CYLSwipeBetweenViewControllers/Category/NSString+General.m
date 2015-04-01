//
//  NSString+General.m
//  hospitalLevelCheckDemo
//
//  Created by chenyilong on 15/3/31.
//  Copyright (c) 2015年 chenyilong. All rights reserved.
//

#import "NSString+General.h"

@implementation NSString (General)
-(id)JSONValue
{
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil) return nil;
    
    return result;
    
}

+(NSString *)cutoutString:(NSString *)string From:(NSString *)left to:(NSString *)right {
    //1.匹配字符串
    NSRange rangeLeft = [string rangeOfString:left];//匹配得到的下标
    NSString *leftStr =[string substringFromIndex:rangeLeft.location+1];//截取下标2之后的字符串
    //    MyLog(@"截取的值为：%@",leftStr);
    NSRange rangeRight = [leftStr rangeOfString:right];//匹配得到的下标
    NSString *responseStrRemanent = [leftStr substringToIndex:rangeRight.location];//截取下标7之前的字符串
    //    MyLog(@"--------截取的值为：%@",responseStrRemanent);
    return responseStrRemanent;
}

+(NSString *)cutoutAndBelongOldStrWithString:(NSString *)string From:(NSString *)left to:(NSString *)right {
    //1.匹配字符串
    NSRange rangeLeft = [string rangeOfString:left];//匹配得到的下标
    NSString *leftStr =[string substringFromIndex:rangeLeft.location];//截取下标2之后的字符串
    //    MyLog(@"截取的值为：%@",leftStr);
    NSRange rangeRight = [leftStr rangeOfString:right];//匹配得到的下标
    NSString *responseStrRemanent = [leftStr substringToIndex:rangeRight.location + 1];//截取下标7之前的字符串
    //    MyLog(@"--------截取的值为：%@",responseStrRemanent);
    return responseStrRemanent;
}

+(NSString *)deleteString:(NSString *)deletedStr From:(NSString *)responseStr
{
    NSString *haystack = responseStr;
    NSString *needle = deletedStr;
    NSRange range = [haystack rangeOfString:needle];
    if (range.location == NSNotFound) {
        return responseStr;
    }
    else {
        NSArray *array = [responseStr componentsSeparatedByString:needle];
        NSString *string = [array componentsJoinedByString:@""];
        /* Found the needle in the haystack */
        return string;
    }
}

- (BOOL)isContainString:(NSString *)needleString {
    BOOL isContainString = NO;
    NSString *needle = needleString;
    NSRange range = [self rangeOfString:needle];
    if (range.location == NSNotFound) {
        isContainString = NO;
    } else {
        isContainString = YES;
    }
    return isContainString;
}

+(NSString *)exchangeString:(NSString *)responseStr From:(NSString *)oldStr to:(NSString *)newStr{
    
    NSString *haystack = responseStr;
    NSString *needle = oldStr;
    NSRange range = [haystack rangeOfString:needle];
    if (range.location == NSNotFound) {
        return responseStr;
    }
    else {
        NSArray *array = [responseStr componentsSeparatedByString:oldStr];
        NSString *string = [array componentsJoinedByString:newStr];
        /* Found the needle in the haystack */
        return string;
    }
}
//+(NSString *)separateStringForSpeak:(NSString *)responseStr  from:(NSString *)oldStr
//{
////    //1.匹配字符串
////    NSRange rangeLeft = [responseStr rangeOfString:oldStr];//匹配得到的下标
////    NSString *leftStr =[string substringFromIndex:rangeLeft.location+1];//截取下标2之后的字符串
////    //    MyLog(@"截取的值为：%@",leftStr);
//    NSRange rangeRight = [responseStr rangeOfString:oldStr];//匹配得到的下标
//    NSString *responseStrRemanent = [responseStr substringToIndex:rangeRight.location +1];//截取下标7之前的字符串
//    //    MyLog(@"--------截取的值为：%@",responseStrRemanent);
//    return responseStrRemanent;
//
//
//
////        NSArray *array = [responseStr componentsSeparatedByString:@""];
////        NSString *string = [array componentsJoinedByString:exchangeStr];
////        /* Found the needle in the haystack */
////        return string;
////    }
//}
+(NSString *)separatePhoneStringForSpeak:(NSString *)PhoneNumStr {
    NSString *nameForSpeak = [NSString stringWithFormat:@"(%@)",PhoneNumStr ];
    return nameForSpeak;
}


@end
