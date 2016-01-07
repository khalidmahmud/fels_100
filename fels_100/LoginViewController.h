//
//  LoginViewController.h
//  fels_100
//
//  Created by Tahia Ata on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailLoginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordLoginField;
@property (weak, nonatomic) IBOutlet UILabel *loginRequirementLabel;
@property (weak, nonatomic) IBOutlet UIButton *remeberMeBox;
@property (assign, nonatomic) BOOL checkRemember;

- (IBAction)loginButton:(id)sender;
- (IBAction)rememberMeBox:(id)sender;

@end
