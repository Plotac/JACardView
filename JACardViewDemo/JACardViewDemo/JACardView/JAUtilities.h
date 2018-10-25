//
//  JAUtilities.h
//  JACardViewDemo
//
//  Created by Ja on 2018/10/24.
//  Copyright © 2018年 Ja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IS_IPHONE_X_OR_AFTER   [JAUtilities isIPhoneXOrAfter]

#define kNavToolBarHeight               44

#define kStatusBarHeight                (IS_IPHONE_X_OR_AFTER ? 44 : 20)

#define UIColorFromHexStr(str) [JAUtilities colorWithHexString:(str)]

@interface JAUtilities : NSObject

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (BOOL)isIPhoneXOrAfter;

@end


