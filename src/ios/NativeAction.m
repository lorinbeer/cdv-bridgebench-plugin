//
//  NativeAction.m
//  READFILE
//
//  Created by Lorin Beer on 8/12/13.
//
//
#import "NativeAction.h"


@implementation NativeAction
@synthesize method = mMethod;
@synthesize params = mParams;

- (id)initWithAction:(NSString *)action method:(NSString *)method params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.action = action;
        mMethod = method;
        mParams = params;
    }
    return self;
}

+ (id)objectWithAction:(NSString *)action method:(NSString *)method params:(NSDictionary *)params {
    return [[NativeAction alloc] initWithAction:action method:method params:params];
}

- (NSString *)action {
    return mAction;
}

- (void)setAction:(NSString *)action {
    if (mAction != action) {
        mAction = [action lowercaseString];
    }
    
}


@end