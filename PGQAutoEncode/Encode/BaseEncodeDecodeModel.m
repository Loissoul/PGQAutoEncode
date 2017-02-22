//
//  BaseEncodeDecodeModel.m
//  PGQAutoEncode
//
//  Created by Lois_pan on 17/2/22.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "BaseEncodeDecodeModel.h"
#import "NSObject+NSCoding.h"

@implementation BaseEncodeDecodeModel

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [self autoEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self autoDecodeWithCoder:aDecoder];
    }
    return self;
}

@end
