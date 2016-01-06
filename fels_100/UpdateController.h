//
//  UpdateController.h
//  fels_100
//
//  Created by Tahia Ata on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) NSString *emailUpdate;
@property (strong, nonatomic) NSString *nameUpdate;
@property (strong, nonatomic) NSString *theString;
@property (strong, nonatomic) NSString *tokenUpdate;
@property (strong, nonatomic) NSString *theID;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIImage *images;
@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property (weak, nonatomic) IBOutlet UITextField *updateEmailField;
@property (weak, nonatomic) IBOutlet UITextField *updateNameField;
@property (weak, nonatomic) IBOutlet UITextField *newpasswordField;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordField;
@property (weak, nonatomic) IBOutlet UILabel *updateRequirementLabel;

- (IBAction)updateButton:(id)sender;
- (IBAction)dismissButton:(id)sender;

@end
