//
//  RegisterController.m
//  fels_100
//
//  Created by Tahia Ata on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "RegisterController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "DataAccess.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - Public

- (BOOL)isValidEmailAddress {
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat: @"SELF MATCHES %@",stricterFilterString];
    BOOL check = [emailTest evaluateWithObject:self.emailField.text];
    if (check) {
        return YES;
    }
    self.infoRequireLabel.text = @"Invalid Email";
    return NO;
}

- (BOOL)checkPassword {
    if (self.passwordField.text.length < 6) {
        self.infoRequireLabel.text = @"Password must contain atleast 6 characters";
        return NO;
    }
    if (![self.passwordConfirmField.text isEqualToString:self.passwordField.text]) {
        self.infoRequireLabel.text = @"Password Mismatch";
        return NO;
    }
    return YES;
}

#pragma mark - Private

- (void)clearTextFields {
    self.emailField.text = @"";
    self.passwordField.text = @"";
    self.passwordConfirmField.text = @"";
    self.nameField.text = @"";
    self.infoRequireLabel.text = @"";
}

- (void)showSuccessAlert:(NSString *)myMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message!"
                                                                   message:myMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - IBAction

- (IBAction)registerButton:(id)sender {
    [self.view endEditing:YES];
    if (self.emailField.text.length > 0 && self.passwordField.text.length > 0 && self.passwordConfirmField.text.length > 0 && self.nameField.text.length > 0) {
        BOOL email = [self isValidEmailAddress];
        BOOL password = [self checkPassword];
        if (email && password) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            DataAccess *access=[[DataAccess alloc]init];
            [access signUp:self.nameField.text
                     email:self.emailField.text
                  password:self.passwordField.text
                   confirm:self.passwordConfirmField.text
                  complete:^(BOOL check){
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      if(check){
                          [self showSuccessAlert:@"Success"];
                      } else {
                          [self showSuccessAlert:@"Error"];
                      }
                      [self clearTextFields];
                  }];
        }
    } else {
        self.infoRequireLabel.text = @"* Fields can not be empty";
    }
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
