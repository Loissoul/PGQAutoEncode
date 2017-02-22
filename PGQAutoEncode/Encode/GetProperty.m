//
//  GetProperty.m
//  PGQAutoEncode
//
//  Created by Lois_pan on 17/2/22.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "GetProperty.h"
#import <objc/runtime.h>

@interface GetProperty()

+ (GetProperty *)sharedInstance;

@property (nonatomic, strong) NSCache *propertyCache;

- (NSDictionary *)getPropertyDicFromCacheClass:(Class)objc;

- (void)addPropertyDicToCache:(NSDictionary *)propertyDic class:(Class)objc;

@end

@implementation GetProperty

+ (GetProperty *)sharedInstance {

    static GetProperty * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GetProperty alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (NSDictionary *)getPropertyDicFromClass:(Class)objc {
    
    NSDictionary * cachaePropertyDic = [[GetProperty sharedInstance] getPropertyDicFromCacheClass:objc];
    if (cachaePropertyDic) {
        return cachaePropertyDic;
    } else  {
    
        NSMutableDictionary * propertyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        Class superClass = class_getSuperclass(objc);
        if (superClass != [NSObject class]) {
            [propertyDic  addEntriesFromDictionary:[GetProperty getPropertyDicFromClass:superClass]];
        }
        
        u_int count;
        Ivar * ivars = class_copyIvarList(objc, &count);
        for (int i = 0; i < count; i++) {
            const char* ivarName = ivar_getName(ivars[i]);
            const char* ivarType = ivar_getTypeEncoding(ivars[i]);
            NSString * propertyName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
            NSString * propertyType = [NSString stringWithCString:ivarType encoding:NSUTF8StringEncoding];
            propertyType = [propertyType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            propertyType = [propertyType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            [propertyDic setValue:propertyType forKey:propertyName];
        }
        free(ivars);
        
        if (propertyDic) {
            [[GetProperty sharedInstance] addPropertyDicToCache:propertyDic class:objc];
        }
        return propertyDic;
    }
    return nil;
}

- (void)addPropertyDicToCache:(NSDictionary *)propertyDic class:(Class)objc {

    if (!self.propertyCache) {
        self.propertyCache = [NSCache new];
    }
    
    [self.propertyCache setObject:propertyDic forKey: NSStringFromClass(objc)];
}

- (NSDictionary *)getPropertyDicFromCacheClass:(Class)objc {

    NSString *className = NSStringFromClass(objc);
    if (self.propertyCache && [self.propertyCache objectForKey:className]) {
        return [self.propertyCache objectForKey:className];
    }
    return nil;
}
@end









