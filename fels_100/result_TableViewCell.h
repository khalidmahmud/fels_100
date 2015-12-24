//
//  result_TableViewCell.h
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/23/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface result_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *resultImage;
@property (weak, nonatomic) IBOutlet UILabel *questionLb;
@property (weak, nonatomic) IBOutlet UILabel *ansLb;

@end
