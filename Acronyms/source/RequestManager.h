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

/**Performs GET request for the given url and calls completion handler with Acronym list and error */
- (void)fetchAcronyms:(NSString *)searchString withCompletionHandler:( void (^)(NSMutableArray *acronymList, NSError *err)) completionHandler;


@end
