//
//  resultViewController.m
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "resultViewController.h"
#import "result_TableViewCell.h"
#import "categoriesTableViewCell.h"

@interface resultViewController ()

@end

@implementation resultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.resTblView registerNib:[UINib nibWithNibName:NSStringFromClass([result_TableViewCell class] ) bundle:nil] forCellReuseIdentifier:NSStringFromClass([result_TableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    result_TableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([result_TableViewCell class]) forIndexPath:indexPath];
    cell.questionLb.text=@"こんにちは";
    cell.ansLb.text=@"Xin chào";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  80.0f;
}

@end
