//
//  WordListViewController.h
//  fels_100
//
//  Created by Abu Khalid on 12/17/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WordListViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >

@property (strong, nonatomic) IBOutlet UIButton *filterButton1;
@property (strong, nonatomic) IBOutlet UITableView *filterTable1;
@property (strong, nonatomic) IBOutlet UIButton *filterButton2;
@property (strong, nonatomic) IBOutlet UITableView *filterTable2;
@property (strong, nonatomic) IBOutlet UITableView *resultTable;

- (IBAction)filterAction1:(id)sender;
- (IBAction)filterAction2:(id)sender;

@property (strong, nonatomic) NSArray *filterData1;
@property (strong, nonatomic) NSArray *filterData2;
@property (strong, nonatomic) NSMutableArray *resultData;


@property (strong, nonatomic) NSString *authenticationToken;

@property (strong, nonatomic) NSNumber *wordsTotalPage;
@property (strong, nonatomic) NSNumber *categoryId;//Filter 1
@property (strong, nonatomic) NSString *optionsFilter;//Filter 2
@property (strong, nonatomic) NSNumber *wordsCurrentPage;



@end
