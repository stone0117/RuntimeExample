//
//  Person.m
//  消息转发机制
//
//  Created by stone on 16/7/10.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "Car.h"
#import "Person.h"
#import <objc/runtime.h>
@implementation Person

/** 方案一: */
//void run(id self, SEL _cmd){
//    NSLog(@"%@ %s",self,sel_getName(_cmd));
//}
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    if (sel == @selector(run)) {
//
//        //typedef void (*IMP)(void /* id, SEL, ... */ );
//
//        class_addMethod(self, sel, (IMP)(run), "v@:");
//
//        return YES;
//    }
//
//    return  [super resolveInstanceMethod:sel];
//}
/** 方案二: 鬼知道 哪个对象有run方法... */
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return [Car new];
//}
/** 方案三: */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString * sel = NSStringFromSelector(aSelector);

    if ([sel isEqualToString:@"run"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"]; // nil; 返回nil就直接崩 , 描述 方法(返回值 & 参数等);
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {

    SEL selector = [anInvocation selector];
    Car * car = [[Car alloc] init];
    if ([car respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:car];
    }
    NSLog(@"%@", @(class_getName([self class])).class);
}
/** class method??? */
@end
