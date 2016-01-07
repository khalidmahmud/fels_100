//
//  User.h
//  fels_100
//
//  Created by Tahia Ata on 1/6/16.
//  Copyright © 2016 Abu Khalid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString *theToken;
    NSString *theId;
}
@property (strong, nonatomic) NSString *theToken;
@property (strong, nonatomic) NSString *theId;
+ (User *)sharedInstance;

@end
