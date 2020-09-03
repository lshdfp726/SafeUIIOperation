//
//  UIView+exchange.m
//  Demo
//
//  Created by 刘松洪 on 2020/9/2.
//  Copyright © 2020 刘松洪. All rights reserved.
//

#import "UIView+exchange.h"
#import <objc/runtime.h>

@implementation UIView (exchange)
+ (void)load {
    [self exchange:@selector(addSubview:) newSel:@selector(lsh_addSubView:)];
    [self exchange:@selector(layoutSubviews) newSel:@selector(lsh_layoutSubviews)];
    [self exchange:@selector(setNeedsLayout) newSel:@selector(lsh_NeedsLayout)];
    [self exchange:@selector(setFrame:) newSel:@selector(lsh_setFrame:)];
    [self exchange:@selector(frame) newSel:@selector(lsh_frame)];
    [self exchange:@selector(layoutIfNeeded) newSel:@selector(lsh_layoutIfNeeded)];
    [self exchange:@selector(setNeedsUpdateConstraints) newSel:@selector(lsh_setNeedsUpdateConstraints)];
}

+ (void)exchange:(SEL)originSel newSel:(SEL)newSel {
    Method origin = class_getInstanceMethod(self, originSel);
    Method new = class_getInstanceMethod(self, newSel);

    if (class_addMethod(self, newSel, method_getImplementation(new), method_getTypeEncoding(new))) {
        class_replaceMethod(self, originSel, method_getImplementation(origin), method_getTypeEncoding(origin));
    } else {
        method_exchangeImplementations(new, origin);
    }
}


- (void)lsh_setNeedsUpdateConstraints {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self lsh_setNeedsUpdateConstraints];
        });
    } else {
        [self lsh_setNeedsUpdateConstraints];
    }
}


- (void)lsh_layoutIfNeeded {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self lsh_layoutIfNeeded];
        });
    } else {
        [self lsh_layoutIfNeeded];
    }
}

- (void)lsh_addSubView:(UIView *)view {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self lsh_addSubView:view];
        });
    } else {
        [self lsh_addSubView:view];
    }
}

- (void)lsh_layoutSubviews {
   if (![[NSThread currentThread] isMainThread]) {
       dispatch_sync(dispatch_get_main_queue(), ^{
           [self lsh_layoutSubviews];
       });
   } else {
       [self lsh_layoutSubviews];
   }
}


- (void)lsh_NeedsLayout {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self lsh_NeedsLayout];
        });
    } else {
        [self lsh_NeedsLayout];
    }
}


- (void)lsh_setFrame:(CGRect)frame {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self lsh_setFrame:frame];
        });
    } else {
        [self lsh_setFrame:frame];
    }
}

- (CGRect)lsh_frame {
    __block CGRect rect = CGRectZero;
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            rect = [self lsh_frame];
        });
        return rect;
    } else {
        return [self lsh_frame];
    }
}

@end
