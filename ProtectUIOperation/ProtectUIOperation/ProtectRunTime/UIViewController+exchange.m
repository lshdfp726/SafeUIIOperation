//
//  UIViewController+exchange.m
//  Demo
//
//  Created by 刘松洪 on 2020/9/3.
//  Copyright © 2020 刘松洪. All rights reserved.
//

#import "UIViewController+exchange.h"
#import <objc/runtime.h>
@implementation UIViewController (exchange)
+ (void)load {
    [self exchange:@selector(view) newSel:@selector(lsh_view)];

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


- (UIView *)lsh_view {
    __block UIView *v = nil;
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            v = [self lsh_view];
        });
        return v;
    } else {
        return [self lsh_view];
    }
}
@end
