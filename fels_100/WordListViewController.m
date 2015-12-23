//
//  WordListViewController.m
//  fels_100
//
//  Created by Abu Khalid on 12/17/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "WordListViewController.h"

@interface WordListViewController ()

@end

@implementation WordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.filterData1 = [[NSArray alloc]init];
    self.filterData2 = [[NSArray alloc]init];
    self.resultData = [[NSArray alloc]init];
    self.filterTable1.hidden = YES;
    self.filterTable2.hidden = YES;
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
        cell.textLabel.text = [self.filterData1 objectAtIndex:indexPath.row];
    } else if (tableView == self.filterTable2) {
    cell.textLabel.text = [self.filterData2 objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.resultData objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.filterTable1) {
        UITableViewCell *cell = [self.filterTable1 cellForRowAtIndexPath:indexPath];
        [self.filterButton1 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.filterTable1.hidden = YES;
        if ((self.filterTable1.hidden == YES) && (self.filterTable2.hidden == YES)) {
            self.resultTable.hidden = NO;
        }
    } else if (tableView == self.filterTable2) {
        UITableViewCell *cell = [self.filterTable2 cellForRowAtIndexPath:indexPath];
        [self.filterButton2 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.filterTable2.hidden = YES;
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
@end
