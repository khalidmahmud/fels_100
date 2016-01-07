//
//  ProfileController.m
//  fels_100
//
//  Created by Tahia Ata on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "ProfileController.h"
#import "DataAccess.h"
#import "MBProgressHUD.h"
#import "UpdateController.h"
#import "User.h"

@interface ProfileController ()

@end

@implementation ProfileController

#pragma mark -LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"flag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] boolForKey: @"flag"]) {
        [self loadData];
    } else {
        if ([[NSUserDefaults standardUserDefaults] boolForKey: @"data"]) {
            [User sharedInstance].theId = [[NSUserDefaults standardUserDefaults] objectForKey: @"id"];
            [User sharedInstance].theToken = [[NSUserDefaults standardUserDefaults] objectForKey: @"token"];
            [self loadData];
        } else {
            [self performSegueWithIdentifier: @"ToLogin" sender:self];
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"ToUpdate"]) {
        UpdateController *destination = segue.destinationViewController;
        destination.emailUpdate = self.profileEmail.text;
        destination.nameUpdate = self.profileName.text;
        destination.theString =  self.pictureString;
    }
}

#pragma mark - Private 

- (NSString *)getSubstring:(NSString *)mainString {
    NSArray *substrings = [mainString componentsSeparatedByString: @"T"];
    return (substrings.count > 0) ? [substrings objectAtIndex:0] : @"" ;
}

- (void)loadData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DataAccess *access = [[DataAccess alloc] init];
    [access fetchData:[User sharedInstance].theId Token:[User sharedInstance].theToken complete:^(BOOL isAccepted,NSDictionary *theDic) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isAccepted) {
            if (theDic) {
                self.profileName.text = ([theDic objectForKey: @"name"]) ? [theDic objectForKey: @"name"] : @"";
                self.profileEmail.text = ([theDic objectForKey: @"email"]) ? [theDic objectForKey: @"email"] : @"";
                self.learnedWords.text = ([theDic objectForKey: @"learned_words"])? [NSString stringWithFormat: @"Learned %@ words",[theDic objectForKey: @"learned_words"]]: @"";
                self.pictureString = ([theDic objectForKey: @"avatar"]) ? [theDic objectForKey: @"avatar"] : @"";
                self.activityArray = ([theDic objectForKey: @"activities"]) ? [theDic objectForKey: @"activities"] : @"";
                [self.tableView reloadData];
                [self.profilePicture sd_setImageWithURL:[NSURL URLWithString:self.pictureString]
                                       placeholderImage:[UIImage imageNamed: @"profilePic.png"]
                                                options:SDWebImageRefreshCached];
            } else {
                NSLog(@"Dictionary is nil");
            }
        } else {
            NSLog(@"Error");
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.activityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    NSDictionary *theDic = [self.activityArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"profilePic.png"];
    cell.textLabel.numberOfLines = 4;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.text = ([theDic objectForKey:@"content"]) ? [theDic objectForKey:@"content"] : @"";
    cell.detailTextLabel.text = ([theDic objectForKey:@"created_at"]) ? [self getSubstring:[theDic objectForKey: @"created_at"]] : @"";
    return  cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - IBAction

- (IBAction)logoutButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey: @"data"];
    [defaults setBool:NO forKey: @"flag"];
    [defaults setObject: @"" forKey: @"id"];
    [defaults setObject: @"" forKey: @"token"];
    [defaults synchronize];
    [self performSegueWithIdentifier: @"ToLogin" sender:self];
}

@end
