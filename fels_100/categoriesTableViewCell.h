//
//  categoriesTableViewCell.h
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/22/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface categoriesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *categoriesImage;
@property (weak, nonatomic) IBOutlet UILabel *categoriesTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *categoriesDetailsLb;
@property (weak, nonatomic) IBOutlet UILabel *lernedLb;

@end
