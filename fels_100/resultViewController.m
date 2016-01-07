//
//  resultViewController.m
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "resultViewController.h"
#import "resultTableViewCell.h"
#import "categoriesTableViewCell.h"
#import "categoriesViewController.h"

@interface resultViewController ()

@end

@implementation resultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberOfCorrectanswer = [self getQurrectNumberOfAnswer];
    self.titleLb.text = self.categoryTypeNameLeb;
    [self.resTblView registerNib:[UINib nibWithNibName:NSStringFromClass([resultTableViewCell class] ) bundle:nil] forCellReuseIdentifier:NSStringFromClass([resultTableViewCell class])];
    self.totalLb.text = [NSString stringWithFormat:@"%d", self.totalNumberOfQuestion] ;
    self.numberLb.text = [NSString stringWithFormat:@"%d", self.numberOfCorrectanswer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(int )getQurrectNumberOfAnswer {
    int count = 0;
    for(int  i = 0;i < self.testResultDictionary.count;i++) {
        NSDictionary *dic = [self.testResultDictionary objectAtIndex:i ];
        if([[dic objectForKey:@"is_correct"] integerValue] == 1) {
            count++;
        }
    }
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testResultDictionary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    resultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([resultTableViewCell class]) forIndexPath:indexPath];
    NSDictionary *dic = [self.testResultDictionary objectAtIndex:indexPath.row ];
    if([[dic objectForKey:@"is_correct"] integerValue] == 1) {
        cell.resultImage.image = [UIImage imageNamed:@"check_sign_icon_light_green.png"];
    }
    else {
        cell.resultImage.image = [UIImage imageNamed:@"images.png"];
    }
    cell.questionLb.text = ([dic objectForKey:@"content"]?[dic objectForKey:@"content"]:@"");
    cell.ansLb.text = ([dic objectForKey:@"answer_content"]?[dic objectForKey:@"answer_content"]:@"");
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  60.0f;
}

- (IBAction)btnDoneAction:(id)sender {
    for (UIViewController* controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[categoriesViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
}

@end
