//
//  RequestManager.m
//  Acronyms
//
//  Created by atish vishwakarma on 06/06/16.
//  Copyright © 2016 atish vishwakarma. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager



+(id)sharedRequestManager
{
    static dispatch_once_t token = 0;
    static id sharedRequestManager = nil;
    
    dispatch_once( &token, ^{ sharedRequestManager = [[self alloc] init];});
    
    return sharedRequestManager;
    
}


- (void)performGetRequestForTargetUrl:(NSURL *)url withCompletionHandler:( void (^)(NSData *responseData, NSInteger statusCode, NSError *err)) completionHandler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(data, [(NSHTTPURLResponse *)response statusCode], error );
        });
        
    }];
    
    [task resume];
 
}

@end
