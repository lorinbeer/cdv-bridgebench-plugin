//
//  CDVURLCache.h
//  READFILE
//
//  Created by Lorin Beer on 8/12/13.
//
//

#import <Foundation/Foundation.h>

@class NativeAction;
@protocol JavascriptBridgeDelegate;

@interface JavascriptBridgeURLCache : NSURLCache {
    id <JavascriptBridgeDelegate> __weak mDelegate;
}

@property(weak) id <JavascriptBridgeDelegate> delegate;

@end


@protocol JavascriptBridgeDelegate <NSObject>
- (NSDictionary *)handleAction:(NativeAction *)action error:(NSError **)error;
@end


/*!
 * These are convenience methods for setting/getting the delegate from our custom instance of NSURLCache. They safely check
 * the type of the shared NSURLCache object to make sure it is our class before attempting to retrieve the deletgate.
 */
@interface NSURLCache (JavascriptBridge)
+ (id <JavascriptBridgeDelegate>)javascriptBridgeDelegate;

+ (void)setJavascriptBridgeDelegate:(id <JavascriptBridgeDelegate>)delegate;
@end