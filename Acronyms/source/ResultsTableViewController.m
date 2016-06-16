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
    
    if (searchString && ![searchString isEqualToString:@""] ) {
        [[RequestManager sharedRequestManager] fetchAcronyms:searchString withCompletionHandler:^(NSMutableArray *acronymList, NSError *err) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ((acronymList && err == nil)) {
                    self.searchResults = acronymList;
                    [self.tableView reloadData];
                }
                else
                {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Acronyms" message:@"Error fetching Acronyms." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    
                    [alert addAction:action];
                    
                    [self presentViewController:alert animated:YES completion:^{
                        searchController.searchBar.text = @"";
                    }];
                    
                }
                
            });
            
        }];
    }
    else
    {
        self.searchResults = nil;
        [self.tableView reloadData];
    
    }    
    
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
