//
//  UpdateController.m
//  fels_100
//
//  Created by Tahia Ata on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "UpdateController.h"
#import "DataAccess.h"
#import "MBProgressHUD.h"
#import "User.h"

@interface UpdateController ()

@end

@implementation UpdateController

- (void)viewDidLoad {
     [super viewDidLoad];
     self.updateEmailField.text = self.emailUpdate;
     self.updateNameField.text = self.nameUpdate;
     [self.theImageView sd_setImageWithURL:[NSURL URLWithString:self.theString]
                          placeholderImage:[UIImage imageNamed: @"profilePic.png"]];
     [self.theImageView setUserInteractionEnabled:YES];
     UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction:)];
     [self.theImageView addGestureRecognizer:tapImage];
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

#pragma mark - Private

- (void)tapImageAction:(UITapGestureRecognizer *)tapImage {
    [self showAlertForNewImage];
}

- (void)showAlertForNewImage {
    UIAlertController *alertNewImage = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takephoto = [UIAlertAction actionWithTitle: @"Take Photo"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          [self handleCamera];
                                                      }];
    UIAlertAction *imagegallery = [UIAlertAction actionWithTitle: @"Image Gallery"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [self handleImageGallery];
                                                         }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle: @"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                   }];
    [alertNewImage addAction:takephoto];
    [alertNewImage addAction:imagegallery];
    [alertNewImage addAction:cancel];
    [self presentViewController:alertNewImage animated:YES completion:nil];
}

- (void)handleImageGallery {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSData *data = UIImagePNGRepresentation([info objectForKey: @"UIImagePickerControllerOriginalImage"]);
    self.images = [[UIImage alloc] initWithData:data];
    [self.theImageView setImage:[[UIImage alloc] initWithData:data]];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleCamera {
#if TARGET_IPHONE_SIMULATOR
     UIAlertController *alertcamera = [UIAlertController alertControllerWithTitle: @"Error"
                                                                          message: @"Camera is not available on simulator"
                                                                   preferredStyle:UIAlertControllerStyleAlert];
     UIAlertAction *ok = [UIAlertAction actionWithTitle: @"OK"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * action) {
                                                }];
     [alertcamera addAction:ok];
     [self presentViewController:alertcamera animated:YES completion:nil];
#elif TARGET_OS_IPHONE
     self.imagePicker = [[UIImagePickerController alloc] init];
     self.imagePicker.delegate = self;
     imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
     [self presentViewController:self.imagePicker animated:YES completion:nil];
#endif
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImageJPEGRepresentation(image,0.4) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (BOOL)isValidEmailAddress {
     NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
     NSPredicate *emailTest = [NSPredicate predicateWithFormat: @"SELF MATCHES %@",stricterFilterString];
     BOOL check = [emailTest evaluateWithObject:self.updateEmailField.text];
     if (check) {
          return YES;
     }
     self.updateRequirementLabel.text = @"Invalid Email";
     return NO;
}

- (BOOL)checkPassword {
     if (self.newpasswordField.text.length < 6) {
          self.updateRequirementLabel.text = @"Password atleast 6 characters";
          return NO;
     }
     if (![self.retypePasswordField.text isEqualToString:self.newpasswordField.text]) {
          self.updateRequirementLabel.text = @"Password and Retype Mismatch";
          return NO;
     }
     return YES;
}

#pragma mark - IBAction

- (IBAction)updateButton:(id)sender {
     if (self.updateEmailField.text.length > 0 || self.updateNameField.text.length > 0 || self.newpasswordField.text.length > 0 || self.retypePasswordField.text.length > 0 || self.images) {
          BOOL emailOK = YES,passwordOK = YES;
          if (self.updateEmailField.text.length > 0) {
               emailOK = [self isValidEmailAddress];
          }
          if (self.newpasswordField.text.length > 0 || self.retypePasswordField.text.length > 0 ) {
               passwordOK = [self checkPassword];
          }
          if ( emailOK && passwordOK ) {
               NSString *the64String = @"";
               if (self.images) {
                    the64String = [self encodeToBase64String:self.images];
               }
               [MBProgressHUD showHUDAddedTo:self.view animated:YES];
               DataAccess *access = [[DataAccess alloc] init];
               [access updateData:self.updateNameField.text
                            email:self.updateEmailField.text
                         password:self.newpasswordField.text
                           retype:self.retypePasswordField.text
                           avatar:the64String
                       auth_token:[User sharedInstance].theToken
                            theID:[User sharedInstance].theId
                         complete:^(BOOL done){
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              if (done) {
                                   NSLog(@"updated");
                                   [self dismissViewControllerAnimated:YES completion:nil];
                              }
                              else NSLog(@"not updated");
                         }];
          }
     } else {
          self.updateRequirementLabel.text = @"Nothing to update";
     }
}

- (IBAction)dismissButton:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
