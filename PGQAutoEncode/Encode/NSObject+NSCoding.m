//
//  NSObject+NSCoding.m
//  PGQAutoEncode
//
//  Created by Lois_pan on 17/2/22.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "NSObject+NSCoding.h"
#import <objc/runtime.h>
#import "GetProperty.h"

@implementation NSObject (NSCoding)

- (void)autoEncodeWithCoder:(NSCoder *)coder {
    NSDictionary * dic = [GetProperty getPropertyDicFromClass: [self class]];
    for (NSString * key in dic) {
        [coder encodeConditionalObject: [self valueForKey:key] forKey:key];
    }
}

- (void)autoDecodeWithCoder:(NSCoder *)coder {
    NSDictionary * dic = [GetProperty getPropertyDicFromClass:[self class]];
    for (NSString * key in dic) {
        objc_setAssociatedObject(self, [key UTF8String], [coder decodeObjectForKey:key], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
    
    

@end
