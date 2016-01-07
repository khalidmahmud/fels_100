//
//  categoriesViewController.h
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/22/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface categoriesViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *categoriesTableView;
@property NSDictionary * dictionary;
@property int totalPage;
@property(strong, nonatomic)  NSNumber *currentPage;
@property(strong, nonatomic)  NSString *authenticationToken;
- (IBAction)btnBackAction:(id)sender;

@end
