//
//  resultViewController.h
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface resultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *numberLb;
@property (weak, nonatomic) IBOutlet UILabel *totalLb;
@property (weak, nonatomic) IBOutlet UITableView *resTblView;
@property (weak, nonatomic) NSMutableArray *testResultDictionary;
@property  int totalNumberOfQuestion;
@property  int numberOfCorrectanswer;
@property (weak, nonatomic) IBOutlet NSString *categoryTypeNameLeb;
- (IBAction)btnDoneAction:(id)sender;

@end
