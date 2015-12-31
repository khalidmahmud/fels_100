//
//  testViewController.m
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/22/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "testViewController.h"
#import "DataAccess.h"

@interface testViewController () {
    NSDictionary *lesson;
    NSDictionary *allWords;
}

@end

@implementation testViewController

@synthesize btnFirstOption;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lessonNavigationBar.topItem.title = self.categoryTypeName;
   // self.authenticationToken = @"nCVjGJZZQDx-uvenYiwQ0w";
    [self getLessonByCategoryTypeId];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getLessonByCategoryTypeId {
     DataAccess *access = [[DataAccess alloc]init];
    [access getCategorieTypeWiseLesson:self.categoryType
        authenticationToken: self.authenticationToken
        complete:^(BOOL check ,NSDictionary* categoriesDictionary) {
            if (check) {
                lesson = [categoriesDictionary objectForKey:@"lesson"];
                allWords = [lesson objectForKey:@"words"];
                //NSLog(@"Wrods   %@", allWords);
            }
    }];
}

@end
