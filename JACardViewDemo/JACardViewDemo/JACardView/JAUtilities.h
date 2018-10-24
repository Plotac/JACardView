//
//  JAUtilities.h
//  JACardViewDemo
//
//  Created by Ja on 2018/10/24.
//  Copyright © 2018年 Ja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIColorFromHexStr(str) [JAUtilities colorWithHexString:(str)]

@interface JAUtilities : NSObject

+ (UIColor *)colorWithHexString:(NSString *)color;

@end

