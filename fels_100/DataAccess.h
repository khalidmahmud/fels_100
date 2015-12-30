//
//  DataAccess.h
//  fels_100
//
//  Created by Tahia Ata on 12/24/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define BASEURL @"https://manh-nt.herokuapp.com/";

@interface DataAccess : NSObject

- (void)signUp:(NSString *)name email:(NSString *)email password:(NSString *)password confirm:(NSString *)confirmPassword complete:(void(^)(BOOL isLoggedIn))completionBlock;
- (void)signIn:(NSString *)email password:(NSString *)password remember:(NSNumber *)rememberMe complete:(void(^)(BOOL isLogged,NSDictionary *theDic))completionBlock;
@end
