//
//  categoriesViewController.m
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/22/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "categoriesViewController.h"
#import "categoriesTableViewCell.h"


@interface categoriesViewController ()

@end

@implementation categoriesViewController
  
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.categoriesTableView registerNib:[UINib nibWithNibName:NSStringFromClass([categoriesTableViewCell class] ) bundle:nil] forCellReuseIdentifier:NSStringFromClass([categoriesTableViewCell class])];
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
    categoriesTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([categoriesTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"categories" sender:self];
}

@end
