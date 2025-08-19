//
//  NSString+MacAddress.h
//  Yscoco
//
//  Created by 杨俊艺 on 2025/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MacAddress)

#pragma mark - 每隔2个字符添加一个:的字符串算法
- (NSString *)ColonFormatting;

@end

NS_ASSUME_NONNULL_END
