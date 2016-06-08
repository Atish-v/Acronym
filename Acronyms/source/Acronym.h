//
//  Acronym.h
//  Acronyms
//
//  Created by atish vishwakarma on 07/06/16.
//  Copyright © 2016 atish vishwakarma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Acronym : NSObject

/** Property to hold Acronym's short form */
@property (nonatomic,strong) NSString *shortForm;

/** Property to hold Acronym's long form */
@property (nonatomic,strong) NSString *longForm;

/** Property to hold number of occurrences in corpus */
@property (nonatomic,strong) NSNumber *freq;

/** Property to hold year of first occurrence of this acronym */
@property (nonatomic,strong) NSNumber *since;

/** Property to hold variations of this acronym */
@property (nonatomic,strong) NSArray  *vars;


+ (instancetype)acronymWithSortForm:(NSString *)shortForm longForm:(NSString *)longForm frequency:(NSNumber *)freq firstOccurance:(NSNumber *)since variations:(NSArray *) vars ;

@end
