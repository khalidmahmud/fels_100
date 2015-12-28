//
//  RegisterController.h
//  fels_100
//
//  Created by Tahia Ata on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *infoRequireLabel;

- (BOOL)isValidEmailAddress;
- (BOOL)checkPassword;
- (IBAction)registerButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end
