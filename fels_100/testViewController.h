//
//  testViewController.h
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/22/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface testViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnFirstOption;
@property (weak, nonatomic) IBOutlet UIButton *btnSecondOption;
@property (weak, nonatomic) IBOutlet UIButton *btnThiredOption;
@property (weak, nonatomic) IBOutlet UIButton *btnForthOption;
@property (weak, nonatomic) IBOutlet NSString *categoryType;
@property (weak, nonatomic) IBOutlet NSString *categoryTypeName;
@property(strong, nonatomic)  NSString *authenticationToken;
@property (weak, nonatomic) IBOutlet UINavigationBar *lessonNavigationBar;
@property (strong, nonatomic) NSArray *arrayOfWords;
@property int currentQuestionNumber;
@property (strong, nonatomic) NSMutableArray *testRecordDictionary;
@property (weak, nonatomic) IBOutlet UILabel *questionContent;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberOfQuestion;
@property (weak, nonatomic) IBOutlet UILabel *numberOfQuestion;
- (IBAction)selectOptionAction:(id)sender;
@end



