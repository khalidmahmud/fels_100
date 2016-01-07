//
//  WordListViewController.m
//  fels_100
//
//  Created by Abu Khalid on 12/17/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "WordListViewController.h"
#import "DataAccess.h"
#import "User.h"
#import "MBProgressHUD.h"

@interface WordListViewController ()

@end

@implementation WordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.filterData1 = [[NSMutableArray alloc] init];
    self.filterData2 = [[NSArray alloc] initWithObjects:@"All",@"Learned",@"Not learn", nil];
    self.filterData2Compare = [[NSArray alloc] initWithObjects:@"all_word",@"learned",@"no_learn", nil];
    self.authenticationToken = [User sharedInstance].theToken;
    self.resultData = [[NSMutableArray alloc] init];
    self.filterTable1.hidden = YES;
    self.filterTable2.hidden = YES;
    
    self.categoryId = 1;
    self.optionsFilter = @"all_word";
    self.wordsCurrentPage = 1;
    self.categoriesCurrentPage = 1;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DataAccess *accessWord = [[DataAccess alloc] init];
    //initial values
    [accessWord categoryId:@(self.categoryId)
                    option:self.optionsFilter
                     page:@(self.wordsCurrentPage)
                 authToken:self.authenticationToken
                  complete: ^ (NSDictionary *wordsReturn) {
                      if (wordsReturn != nil) {
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          if ([wordsReturn objectForKey:@"words"] && [wordsReturn objectForKey:@"total_pages"]) {
                              [self.resultData addObjectsFromArray:[wordsReturn objectForKey:@"words"]];
                              self.wordsTotalPage = [[wordsReturn objectForKey:@"total_pages"] integerValue];
                              [self.resultTable reloadData];
                          }
                      } else {
                          NSLog(@"///// Error Occured /////////////");
                      }
                  }];
    DataAccess *accessCategories = [[DataAccess alloc] init];
    //initial values
    [accessCategories page:@(self.categoriesCurrentPage)
                 authToken:self.authenticationToken
                  complete: ^ (NSDictionary *categoriesReturn) {
                      if (categoriesReturn != nil) {
                          if ([categoriesReturn objectForKey:@"categories"] && [categoriesReturn objectForKey:@"total_pages"]) {
                              [self.filterData1 addObjectsFromArray:[categoriesReturn objectForKey:@"categories"]];
                              self.categoriesTotalPage = [[categoriesReturn objectForKey:@"total_pages"] integerValue];
                              [self.filterTable1 reloadData];
                          }
                      } else {
                          NSLog(@"///// Error Occured /////////////");
                      }
                  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(NSInteger *)tableView:(UITableView *)tableView nu
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.filterTable1) {
        return [self.filterData1 count];
    } else if(tableView == self.filterTable2) {
        return [self.filterData2 count];
    } else {
        return [self.resultData count];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"Cell"];
    }
    
    if (tableView == self.filterTable1) {
        if( [[self.filterData1 objectAtIndex:indexPath.row] objectForKey:@"name"] != nil) {
        cell.textLabel.text = [[self.filterData1 objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        } else {
            NSLog(@" Error Occured in Categories....");
        }
    } else if (tableView == self.filterTable2) {
    cell.textLabel.text = [self.filterData2 objectAtIndex:indexPath.row];
    } else {
        if (self.resultData != nil) {
            NSArray *theDic = self.resultData;
            NSArray *answerArray = [[theDic objectAtIndex:indexPath.row] objectForKey:@"answers"];
            NSString *answerString = [[NSString alloc] init];
            NSString *wordString = [[theDic objectAtIndex:indexPath.row] objectForKey:@"content"];
            for (NSDictionary *currentValue in answerArray)
            {
                if ([[currentValue objectForKey:@"is_correct"]  isEqual: @1]) {
                    answerString = [currentValue objectForKey:@"content"];
                    break;
                }
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@|||%@", wordString, answerString];
        } else {
            NSLog(@" Error Occured in Words....");
        }
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.filterTable1) {
        UITableViewCell *cell = [self.filterTable1 cellForRowAtIndexPath:indexPath];
        NSInteger currentCategoryId = self.categoryId;
        self.categoryId = [[[self.filterData1 objectAtIndex:indexPath.row] objectForKey:@"id"] integerValue];
        [self.filterButton1 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.filterTable1.hidden = YES;
        if (currentCategoryId != self.categoryId) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.wordsCurrentPage = 1;
            DataAccess *accessWord2 = [[DataAccess alloc] init];
            //initial values
            [accessWord2 categoryId:@(self.categoryId)
                             option:self.optionsFilter
                               page:@(self.wordsCurrentPage)
                          authToken:self.authenticationToken
                           complete: ^ (NSDictionary *wordsReturn) {
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                               if (wordsReturn != nil) {
                                   if ([wordsReturn objectForKey:@"words"] && [wordsReturn objectForKey:@"total_pages"]) {
                                       [self.resultData removeAllObjects];
                                       [self.resultData addObjectsFromArray:[wordsReturn objectForKey:@"words"]];
                                       self.wordsTotalPage = [[wordsReturn objectForKey:@"total_pages"] integerValue];
                                       [self.resultTable reloadData];
                                   }
                               } else {
                                   NSLog(@"///// Error Occured /////////////");
                               }
                           }];
            
        }
        if ((self.filterTable1.hidden == YES) && (self.filterTable2.hidden == YES)) {
            self.resultTable.hidden = NO;
        }
    } else if (tableView == self.filterTable2) {
        UITableViewCell *cell = [self.filterTable2 cellForRowAtIndexPath:indexPath];
        NSString *currentSelectedOption = self.optionsFilter;
        self.optionsFilter = [self.filterData2Compare objectAtIndex:indexPath.row];
        [self.filterButton2 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.filterTable2.hidden = YES;
        if (currentSelectedOption != self.optionsFilter) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            DataAccess *accessWord3 = [[DataAccess alloc]init];
            self.wordsCurrentPage = 1;
            [accessWord3 categoryId:@(self.categoryId)
                             option:self.optionsFilter
                               page:@(self.wordsCurrentPage)
                          authToken:self.authenticationToken
                           complete: ^ (NSDictionary *wordsReturn) {
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               if (wordsReturn != nil) {
                                   if ([wordsReturn objectForKey:@"words"] && [wordsReturn objectForKey:@"total_pages"]) {
                                       [self.resultData removeAllObjects];
                                       [self.resultData addObjectsFromArray:[wordsReturn objectForKey:@"words"]];
                                       self.wordsTotalPage = [[wordsReturn objectForKey:@"total_pages"] integerValue];
                                       [self.resultTable reloadData];
                                   }
                               } else {
                                   NSLog(@"///// Error Occured /////////////");
                                   [self.resultData removeAllObjects];
                                   [self.resultTable reloadData];
                               }
                           }];
        }
        if ((self.filterTable1.hidden == YES) && (self.filterTable2.hidden == YES)) {
            self.resultTable.hidden = NO;
        }
    }
}

- (IBAction)filterAction1:(id)sender {
    
    if (self.filterTable1.hidden == YES) {
        self.resultTable.hidden = YES;
        self.filterTable1.hidden = NO;
    } else {
       self.filterTable1.hidden = YES;
      if ((self.filterTable1.hidden == YES)&&(self.filterTable2.hidden == YES)) {
            self.resultTable.hidden = NO;
        }
    }
}

- (IBAction)filterAction2:(id)sender {
    
    if (self.filterTable2.hidden == YES) {
        self.resultTable.hidden = YES;
        self.filterTable2.hidden = NO;
    } else {
        self.filterTable2.hidden = YES;
        if ((self.filterTable1.hidden == YES)&&(self.filterTable2.hidden == YES)) {
            self.resultTable.hidden = NO;
        }
    }
}

- (IBAction)backToProfile:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.resultTable) {
        if(self.resultTable.contentOffset.y >= (self.resultTable.contentSize.height - self.resultTable.frame.size.height)) {
            //user has scrolled to the bottom
            [self scrollingFinish:self.resultTable];
        }
    } else if (scrollView == self.filterTable1) {
        if(self.filterTable1.contentOffset.y >= (self.filterTable1.contentSize.height - self.filterTable1.frame.size.height)) {
            //user has scrolled to the bottom
            [self scrollingFinish:self.filterTable1];
        }
        
        
    }
}

- (void)scrollingFinish:(UIScrollView *)scrollView {
    if(scrollView == self.resultTable) {
        if (self.wordsCurrentPage == self.wordsTotalPage) {
            NSLog(@"Reached page Limit");
        } else {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.wordsCurrentPage = self.wordsCurrentPage + 1;
            DataAccess *accessWord2 = [[DataAccess alloc] init];
            [accessWord2 categoryId:@(self.categoryId)
                             option:self.optionsFilter
                                 page:@(self.wordsCurrentPage)
                          authToken:self.authenticationToken
                           complete: ^ (NSDictionary *wordsReturn) {
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               if (wordsReturn != nil) {
                                  [self.resultData addObjectsFromArray:[wordsReturn objectForKey:@"words"]];
                                  [self.resultTable reloadData];
                               } else {
                                   NSLog(@"///// Error Occured /////////////");
                               }
                           }];
        }
    } else if (scrollView == self.filterTable1) {
        if (self.categoriesCurrentPage == self.categoriesTotalPage) {
            NSLog(@"Reached page Limit of Categories");
        } else {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.categoriesCurrentPage = self.categoriesCurrentPage + 1;
            DataAccess *accessCategories2 = [[DataAccess alloc] init];
            [accessCategories2     page:@(self.categoriesCurrentPage)
                               authToken:self.authenticationToken
                                complete: ^ (NSDictionary *categoriesReturn) {
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    if (categoriesReturn != nil) {
                                        [self.filterData1 addObjectsFromArray:[categoriesReturn objectForKey:@"categories"]];
                                        [self.filterTable1 reloadData];
                                    } else {
                                        NSLog(@"///// Error Occured /////////////");
                                    }
                                }];
        }
    }
}

@end
