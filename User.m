//
//  User.m
//  fels_100
//
//  Created by Tahia Ata on 1/6/16.
//  Copyright © 2016 Abu Khalid. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize theToken,theId;
static User *singletonInstance = nil;

+ (User *)sharedInstance {
    static dispatch_once_t safer;
    dispatch_once(&safer,^(void) {
        singletonInstance = [[User alloc] init];
    });
    return  singletonInstance;
}

@end
