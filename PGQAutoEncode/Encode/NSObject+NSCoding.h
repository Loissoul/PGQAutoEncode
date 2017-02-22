//
//  NSObject+NSCoding.h
//  PGQAutoEncode
//
//  Created by Lois_pan on 17/2/22.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSCoding)

- (void)autoDecodeWithCoder:(NSCoder *)coder;

- (void)autoEncodeWithCoder:(NSCoder *)coder;

@end
