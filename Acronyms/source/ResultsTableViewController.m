//
//  ResultsTableViewController.m
//  Acronyms
//
//  Created by atish vishwakarma on 06/06/16.
//  Copyright © 2016 atish vishwakarma. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "Acronym.h"
#import "RequestManager.h"
#import "AcronymDetailViewController.h"

@interface ResultsTableViewController () <UISearchResultsUpdating>
{
        UISearchController *_searchController;
}

@end


@implementation ResultsTableViewController
@synthesize searchResults;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Configure search controller
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.placeholder = @"Acronym Search";
    
    self.tableView.tableHeaderView = _searchController.searchBar;
    self.definesPresentationContext = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acronymCell" forIndexPath:indexPath];
    
    //Configure cell
    Acronym * acronym = [self.searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = acronym.longForm;
    cell.detailTextLabel.text = acronym.since.stringValue;
    
    return cell;
}

#pragma mark - search result updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString * searchString = searchController.searchBar.text;
    
    
        NSURL *url = [NSURL  URLWithString:[NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",searchString]];
        
        [[RequestManager sharedRequestManager] performGetRequestForTargetUrl:url withCompletionHandler:^(NSData *responseData, NSInteger statusCode, NSError *err) {
            
            
            if (statusCode == 200 && err ==nil) {
                if (responseData) {
                    
                    NSError *err = nil;
                    NSArray * responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:0  error:&err ]; //Handle error
                    
                    if (err == nil) {
                        
                        NSDictionary *responseDict = nil;
                        if (responseArray.count >0) {
                            responseDict = responseArray[0];
                        }
                        NSMutableArray * searchResult = [responseDict valueForKey:@"lfs"];
                        NSMutableArray * acronymsList = [[NSMutableArray alloc] init];
                        
                        NSString *shortForm = [responseDict valueForKey:@"sf"];
                        
                        for (NSDictionary *dict in searchResult) {
                            
                            Acronym *acronym = [Acronym acronymWithSortForm:shortForm longForm:dict[@"lf"] frequency:dict[@"freq"] firstOccurance:dict[@"since"] variations:dict[@"vars"]];
                            
                            [acronymsList addObject:acronym];
                            
                        }
                        
                        self.searchResults = acronymsList;
                        
                        [self.tableView reloadData];

                    }
                    else
                    {
                         NSLog(@"Error while parsing response:%@", err);
                    
                    }
                    
                }
            }
            else{
                
                NSLog(@"HTTP Status Code = %ld",statusCode);
                NSLog(@"Error while searching Acronym:%@", err);
                
            }
            
        }];

}

#pragma mark - show detail view

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"showDetail"]) {
        
        AcronymDetailViewController * detailController = (AcronymDetailViewController *)segue.destinationViewController;
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        [detailController setDetailItem:self.searchResults[indexPath.row]];
        
    }
    
}





@end
