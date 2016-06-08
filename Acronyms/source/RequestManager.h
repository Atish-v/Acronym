//
//  RequestManager.h
//  Acronyms
//
//  Created by atish vishwakarma on 06/06/16.
//  Copyright © 2016 atish vishwakarma. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RequestManager : NSObject
{
   

}

/** returns shared instance for Request manager */
+(id)sharedRequestManager;

/**Performs GET request for the given url and calls completion handler with response data and error */
- (void)performGetRequestForTargetUrl:(NSURL *)url withCompletionHandler:( void (^)(NSData *responseData, NSInteger statusCode, NSError *err)) completionHandler;


@end
