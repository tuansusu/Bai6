//
//  NSArray+NSArray_Extent.m
//  AllCollectionDemo
//
//  Created by iOS17 on 9/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "NSArray+NSArray_Extent.h"

@implementation NSArray (NSArray_Extent)

-(void) display{
    for (id Object in self) {
        NSLog(@"%@", Object);
    }
}

@end
