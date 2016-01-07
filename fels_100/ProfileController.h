//
//  ProfileController.h
//  fels_100
//
//  Created by Tahia Ata on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSString *pictureString;
@property (strong, nonatomic) NSArray *activityArray;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileEmail;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *learnedWords;

- (IBAction)logoutButton:(id)sender;

@end
