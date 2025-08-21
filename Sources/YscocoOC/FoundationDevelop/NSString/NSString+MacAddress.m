//
//  NSString+MacAddress.m
//  Yscoco
//
//  Created by 杨俊艺 on 2025/8/19.
//

#import "NSString+MacAddress.h"

@implementation NSString (MacAddress)

#pragma mark - 每隔2个字符添加一个:的字符串算法
- (NSString *)colonFormatting {
    NSString *result = @"";
    int count = 0;
    for (int i = 0; i < self.length; i++) {
        count++;
        result = [result stringByAppendingString:[self substringWithRange:NSMakeRange(i, 1)]];
        if (count == 2 && i != self.length - 1) {
            result = [NSString stringWithFormat:@"%@:", result];
            count = 0;
        }
    }
    return result;
}

@end
