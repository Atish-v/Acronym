//
//  AcronymDetailViewController.h
//  Acronyms
//
//  Created by atish vishwakarma on 07/06/16.
//  Copyright © 2016 atish vishwakarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Acronym.h"

@interface AcronymDetailViewController : UIViewController
{

}

/** Label for displaying full name of Acronym */
@property (weak, nonatomic) IBOutlet UILabel *fullformLabel;

/** Label for displaying first occurrence of this Acronym */
@property (weak, nonatomic) IBOutlet UILabel *sinceLabel;

/** Label for displaying occurrences in corpus */
@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;

/** Property to hold Acronym object */
@property (strong, nonatomic) Acronym *detailItem;

@end
