//
//  RBBTweenAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/13/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RBBLinearInterpolation.h"

#import "RBBTweenAnimation.h"

@implementation RBBTweenAnimation

#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    if (self == nil) return nil;

    self.easing = RBBEasingFunctionLinear;

    return self;
}

#pragma mark - KVO

+ (NSSet *)keyPathsForValuesAffectingAnimationBlock {
    return [NSSet setWithArray:@[ @"from", @"to", @"easing" ]];
}

#pragma mark - RBBAnimation

- (RBBAnimationBlock)animationBlock {
    NSParameterAssert(self.easing != nil);

    RBBEasingFunction easing = [self.easing copy];
    RBBLinearInterpolation lerp = RBBInterpolate(self.from, self.to);

    return ^(CGFloat elapsed, CGFloat duration) {
        return lerp(easing(elapsed / duration));
    };
}

#pragma mark - NSObject

- (id)copyWithZone:(NSZone *)zone {
    RBBTweenAnimation *copy = [super copyWithZone:zone];
    if (copy == nil) return nil;

    copy->_easing = _easing;

    copy->_from = _from;
    copy->_to = _to;

    return copy;
}

@end
