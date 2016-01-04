//
//  categoriesViewController.m
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/22/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "categoriesViewController.h"
#import "categoriesTableViewCell.h"
#import "testViewController.h"
#import "DataAccess.h"
#import "UIScrollView+SVPullToRefresh.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

NSArray *categoriesName;
UIRefreshControl * refreshController;

@interface categoriesViewController ()

@end

@implementation categoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.authenticationToken=@"nCVjGJZZQDx-uvenYiwQ0w";
    self.currentPage = @1;
    self.totalPage = 0;
    [self.categoriesTableView registerNib:[UINib nibWithNibName:NSStringFromClass([categoriesTableViewCell class] ) bundle:nil] forCellReuseIdentifier:NSStringFromClass([categoriesTableViewCell class])];
    [self loadCategories];
    refreshController = [[UIRefreshControl alloc]init];
    [refreshController addTarget:self action: @selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    //[self.categoriesTableView addSubview:refreshController];
    //[self.categoriesTableView sendSubviewToBack:refreshController];
    self.categoriesTableView.bottomRefreshControl=refreshController;
}

- (void)handleRefresh:(UIRefreshControl *)refreshControl {
    [self loadCategories];
    [refreshControl endRefreshing];
}

-(void)loadCategories {
    DataAccess *access = [[DataAccess alloc]init];
    [access getCategories:self.currentPage
            authenticationToken:self.authenticationToken
            complete:^(BOOL check ,NSDictionary* categoriesDictionary) {
                if(check) {
                    categoriesName = [categoriesDictionary objectForKey:@"categories"];
                    if (self.totalPage == 0) {
                        self.totalPage = [[categoriesDictionary objectForKey:@"total_pages"] integerValue];
                        int k = [self.currentPage integerValue];
                        k = (k+1)% self.totalPage;
                        if(k == 0) {
                            k = self.totalPage;
                        }
                        self.currentPage = [NSNumber numberWithInt:k];
                    }
                    [self.categoriesTableView reloadData];
                }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return categoriesName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    categoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([categoriesTableViewCell class]) forIndexPath:indexPath];
    NSDictionary *theDic = [categoriesName objectAtIndex: indexPath.row ];
    cell.categoriesTypeLb.text = ([theDic objectForKey:@"name"]?[theDic objectForKey:@"name"]:@"");
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"categories" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"categories"]) {
        NSIndexPath *indexPath = [self.categoriesTableView indexPathForSelectedRow];
        testViewController *testViewController = segue.destinationViewController;
        NSDictionary *theDic=[categoriesName objectAtIndex: indexPath.row ];
        testViewController.categoryType = [ theDic objectForKey:@"id"];
        testViewController.categoryTypeName = [ theDic objectForKey:@"name"];
       // NSLog(@"%@",[ theDic objectForKey:@"id"]);
    }
}

@end
