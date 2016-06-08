//
//  Acronym.m
//  Acronyms
//
//  Created by atish vishwakarma on 07/06/16.
//  Copyright © 2016 atish vishwakarma. All rights reserved.
//

#import "Acronym.h"

@implementation Acronym
@synthesize shortForm,longForm,since,freq,vars;


+ (instancetype)acronymWithSortForm:(NSString *)shortForm longForm:(NSString *)longForm frequency:(NSNumber *)freq firstOccurance:(NSNumber *)since variations:(NSArray *) vars
{

    Acronym *newAcronym = [[self alloc] init];
    
    newAcronym.shortForm = shortForm;
    newAcronym.longForm = longForm;
    newAcronym.freq = freq;
    newAcronym.since = since;
    newAcronym.vars = vars;
    
    return newAcronym;

}

-(NSString *)description
{
    
    return [NSString stringWithFormat:@"longForm: %@, shortForm: %@,freq:%@, since: %@, vars: %@",self.longForm, self.shortForm, self.freq, self.since, self.vars ];
    
}

@end
