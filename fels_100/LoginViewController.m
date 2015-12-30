//
//  LoginViewController.m
//  fels_100
//
//  Created by Tahia Ata on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "LoginViewController.h"
#import "ProfileController.h"
#import "MBProgressHUD.h"
#import "DataAccess.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.remeberMeBox setImage:[UIImage imageNamed: @"unchecked.png"] forState:UIControlStateNormal];
    [self.remeberMeBox setImage:[UIImage imageNamed: @"checked.png"] forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"ToProfile"]) {
        ProfileController *destination = segue.destinationViewController;
        destination.theID = self.theID;
        destination.auth_token = self.theAuthentication;
    }
}

#pragma mark - IBAction

- (IBAction)loginButton:(id)sender {
    if (self.emailLoginField.text.length > 0 && self.passwordLoginField.text.length > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        DataAccess *object = [[DataAccess alloc]init];
        [object signIn:self.emailLoginField.text
              password:self.passwordLoginField.text
              remember:[NSNumber numberWithBool:self.checkRemember] complete:^(BOOL isAccepted,NSDictionary *theDictionary){
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                  if (isAccepted){
                      NSLog(@"logged in");
                      self.theID = [theDictionary objectForKey: @"id"];
                      self.theAuthentication = [theDictionary objectForKey: @"authToken"];
                      if (self.checkRemember) {
                          [self saveIdToken];
                      }
                      [self clearFields];
                      [self performSegueWithIdentifier: @"ToProfile" sender:self];
                  } else {
                      NSLog(@"not logged in");
                      self.loginRequirementLabel.text = @"Email or password incorrect";
                  }
              }];
    } else {
        self.loginRequirementLabel.text = @"Fields can not be empty";
    }
}

- (IBAction)rememberMeBox:(id)sender {
    if ([self.remeberMeBox isSelected]) {
        self.checkRemember = NO;
        [self.remeberMeBox setSelected:NO];
    } else {
        self.checkRemember = YES;
        [self.remeberMeBox setSelected:YES];
    }
}

#pragma mark - Private

- (void)saveIdToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey: @"data"];
    [defaults setObject:self.theID forKey: @"id"];
    [defaults setObject:self.theAuthentication forKey: @"token"];
    [defaults synchronize];
    NSLog(@"Data saved");
}

- (void)clearFields {
    self.emailLoginField.text = @"";
    self.passwordLoginField.text = @"";
    self.loginRequirementLabel.text = @"";
}

#pragma mark - UIEvent

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
