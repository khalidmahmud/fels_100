//
//  DataAccess.h
//  fels_100
//
//  Created by Tahia Ata on 12/24/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define BASEURL @"https://manh-nt.herokuapp.com/";

@interface DataAccess : NSObject

- (void)signUp:(NSString *)name email:(NSString *)email password:(NSString *)password confirm:(NSString *)confirmPassword complete:(void(^)(BOOL isLoggedIn))completionBlock;
- (void)signIn:(NSString *)email password:(NSString *)password remember:(NSNumber *)rememberMe complete:(void(^)(BOOL isLogged,NSDictionary *theDic))completionBlock;
- (void )getCategories:(NSNumber*)page authenticationToken:(NSString*)authenticationToken complete:(void (^)(BOOL check ,NSDictionary* categoriesDictionary))completionBlock;
- (void)fetchData:(NSString *)theID Token:(NSString *)authToken complete:(void(^)(BOOL check,NSDictionary *dictionary))completionBlock;
- (void )getCategorieTypeWiseLesson:(NSString *) CategoryTypeId authenticationToken:(NSString*)authenticationToken complete:(void (^)(bool check,NSDictionary* lessonDictionary))completionBlock;
- (void)categoryId:(NSNumber *)categoryId option:(NSString *)option page:(NSNumber *)page authToken:(NSString *)authToken complete:(void(^)(NSDictionary *wordsReturn))completionBlock;
- (void)page:(NSNumber *)page authToken:(NSString *)authToken complete:(void(^)(NSDictionary *categoriesReturn))completionBlock;
- (void)updateLesson:(int)lessonId   result_id:(NSNumber *)resultId answer_id: (NSNumber *)answerId authenticationToken:(NSString*)authenticationToken complete:(void (^)(bool check ,NSDictionary* lessonDictionary ))completionBlock ;
- (void)updateData:(NSString *)theName email:(NSString *)theEmail password:(NSString *)theNewPassword retype:(NSString *)theRetype avatar:(NSString *)avatarString auth_token:(NSString *)theToken theID:(NSString *)theID complete:(void(^)(BOOL done))completionBlock;

@end
