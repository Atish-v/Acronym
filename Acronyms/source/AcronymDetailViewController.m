//
//  AcronymDetailViewController.m
//  Acronyms
//
//  Created by atish vishwakarma on 07/06/16.
//  Copyright © 2016 atish vishwakarma. All rights reserved.
//

#import "AcronymDetailViewController.h"

@interface AcronymDetailViewController ()

@end

@implementation AcronymDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(Acronym *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.fullformLabel.text = [self.detailItem longForm];
        self.sinceLabel.text = [[self.detailItem since] stringValue];
        self.frequencyLabel.text = [[self.detailItem freq] stringValue];
        self.title = [self.detailItem shortForm];
    }
}




@end
