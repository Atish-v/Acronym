//
//  RequestManager.m
//  Acronyms
//
//  Created by atish vishwakarma on 06/06/16.
//  Copyright © 2016 atish vishwakarma. All rights reserved.
//

#import "RequestManager.h"
#import "Acronym.h"

@implementation RequestManager



+(id)sharedRequestManager
{
    static dispatch_once_t token = 0;
    static id sharedRequestManager = nil;
    
    dispatch_once( &token, ^{ sharedRequestManager = [[self alloc] init];});
    
    return sharedRequestManager;
    
}


- (void)fetchAcronyms:(NSString *)searchString withCompletionHandler:( void (^)(NSMutableArray *acronymList, NSError *err)) completionHandler
{
    
    NSURL *url = [NSURL  URLWithString:[NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",searchString]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        
        if (!error && httpResponse.statusCode == 200) {
            
            NSError* parseError;
            id json = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:NSJSONReadingAllowFragments
                       error:&parseError];
            
            if (parseError) {
                
                completionHandler(nil, parseError);
                
            } else {
                
                if (json) {
                    if ([json isKindOfClass:[NSArray class]]) {
                        
                        NSMutableArray *resultArray = (NSMutableArray *) json;
                        NSDictionary *responseDict =   nil;
                        if (resultArray.count >0) {
                            responseDict = resultArray[0];
                        }
                        
                        NSMutableArray * searchResult = [responseDict valueForKey:@"lfs"];
                        NSMutableArray * acronymsList = [[NSMutableArray alloc] init];
                        
                        NSString *shortForm = [responseDict valueForKey:@"sf"];
                        
                        for (NSDictionary *dict in searchResult) {
                            
                            Acronym *acronym = [Acronym acronymWithSortForm:shortForm longForm:dict[@"lf"] frequency:dict[@"freq"] firstOccurance:dict[@"since"] variations:dict[@"vars"]];
                            
                            [acronymsList addObject:acronym];
                            
                        }
                        
                        completionHandler(acronymsList, nil);
                        
                    } else {
                        
                        NSDictionary *userInfo = @{
                                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Failed to fetch Acronyms", nil),
                                                   };
                        error = [NSError errorWithDomain:@"" code:100 userInfo:userInfo];
                        
                        completionHandler(nil,error);
                    }
                }
            }
            
        } else {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: NSLocalizedString(@"Failed to fetch Acronyms", nil),
                                       };
            error = [NSError errorWithDomain:@"" code:100 userInfo:userInfo];
            completionHandler(nil,error);
        }
        
    }];
    
    [task resume];
    
}




@end
