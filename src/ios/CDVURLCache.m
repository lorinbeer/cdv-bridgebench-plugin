//
//  CDVURLCache.m
//  READFILE
//
//  Created by Lorin Beer on 8/12/13.
//
//

#import "CDVURLCache.h"
//#import "GTMNSDictionary+URLArguments.h"
#import "NativeAction.h"
#import "../../CordovaLib/Classes/NSData+Base64.h"

//#import "SBJsonWriter.h"

// We'll intercept all requests going to the following host:

const NSString *kAppHost = @"cordova.plugin.file";
@implementation JavascriptBridgeURLCache

@synthesize delegate = mDelegate;


- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    
    NSURL *url = [request URL];

    if ([[url host] caseInsensitiveCompare:(NSString *) kAppHost] == NSOrderedSame) {
        
        
        NSString *action = nil;
        if ([[url pathComponents] count] > 1) { // use index 1 since index 0 is the '/'
            // Theoretically, we could use the :controller/:action/:id pattern here, but for simplicity we'll just do
            // /:action
            action = [[url pathComponents] objectAtIndex:1];
        }
        NSString *query = [url query];
        
        NSString *method = [request HTTPMethod];
        NSDictionary *params = nil;
        
        if ([method isEqualToString:@"GET"]) {
            NSArray * args = [query componentsSeparatedByString: @"&"];
            
            NSString * timestampstr = [args objectAtIndex:0];
    
            NSString * timestamp = [[timestampstr componentsSeparatedByString:@"="] objectAtIndex:1];
            NSCachedURLResponse *cached1Response = nil;
            NSData * data = [NSMutableData dataWithLength:1024];
            //NSLog([data base64EncodedString]);
            /*
            NSString *jsonString = [NSString stringWithFormat: @"%@%@%@%@%@%@%@",
                                    @"{\"",
                                    [[[args objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:0],
                                    @"\":\"",
                                    [[[args objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:1],
                                    @"\",\"data\":",
                                    [data base64EncodedString],
                                    "}"];
            */
            //NSData *jsonBody = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSURLResponse *res = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:@"application/octet-stream" expectedContentLength: 1024/*[jsonBody length]*/ textEncodingName:nil];
            cached1Response = [[NSCachedURLResponse alloc] initWithResponse:res data:data];

            return cached1Response;

        }
     /*
        // we also want to extract any arguments passed in the request. In a GET, we can get these from the URL query
        // string. In requests with entities, we can get this from the request body (assume www-form encoded for our purposes
        // here, but we could also handle JSON entities)
        if ([method isEqualToString:@"POST"] || [method isEqualToString:@"PUT"]) {
            NSString *body = nil;
            body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
            params = nil;//[NSDictionary gtm_dictionaryWithHttpArgumentsString:body];
        } else {
            params = nil;//[NSDictionary gtm_dictionaryWithHttpArgumentsString:query];
        }
        
        // construct a NativeAction object to transport this request message to our handler in native code
        NativeAction *nativeAction = [[NativeAction alloc] initWithAction:action method:method params:params];
        NSError *error1 = nil;
        NSMutableDictionary *result = [[self.delegate handleAction:nativeAction error:&error1] mutableCopy];
        
        // if we got an error, assign it in the hash we'll pass back to javascript
        if (error1) {
            [result setObject:@{
             @"code" : [NSNumber numberWithInt:error1.code],
             @"message" : [error1 localizedDescription]
             
             }          forKey:@"error"];
        }
        
        // Lastly, we need to construct an NSCachedURLResponse object to return from this method. This is the response
        // (headers + body) that will be passed back to our jQuery callback
        NSCachedURLResponse *cachedResponse = nil;
        if (result) {
            NSString *jsonString = nil;//[[[SBJsonWriter alloc] init] stringWithObject:result];
            NSData *jsonBody = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSURLResponse *res = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:@"application/json" expectedContentLength:[jsonBody length] textEncodingName:nil];
            cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:res data:jsonBody];
        }
        return cachedResponse;
    */
    }
    
    // if not matching our custom host, allow system to handle it
    return [super cachedResponseForRequest:request];
}

@end


@implementation NSURLCache (JavascriptBridge)

+ (id <JavascriptBridgeDelegate>)javascriptBridgeDelegate {
    NSURLCache *sharedURLCache = [NSURLCache sharedURLCache];
    if ([sharedURLCache isKindOfClass:[JavascriptBridgeURLCache class]]) {
        return [(JavascriptBridgeURLCache *) sharedURLCache delegate];
    }
    return nil;
}

+ (void)setJavascriptBridgeDelegate:(id <JavascriptBridgeDelegate>)delegate {
    NSURLCache *sharedURLCache = [NSURLCache sharedURLCache];
    if ([sharedURLCache isKindOfClass:[JavascriptBridgeURLCache class]]) {
        [(JavascriptBridgeURLCache *) sharedURLCache setDelegate:delegate];
    }
}

@end