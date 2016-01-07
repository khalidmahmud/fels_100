//
//  testViewController.m
//  fels_100
//
//  Created by Kazi Sharmin Dina on 12/22/15.
//  Copyright © 2015 Abu Khalid. All rights reserved.
//

#import "testViewController.h"
#import "DataAccess.h"
#import "resultViewController.h"
#import "User.h"
#import "categoriesViewController.h"
@import AVFoundation;

@interface testViewController () {
    NSDictionary *lesson;
    NSDictionary *allWords;
    NSArray *newarray;
    NSDictionary *checkAnswer;
}

@end

@implementation testViewController
@synthesize testRecordDictionary;
@synthesize btnFirstOption;
@synthesize lessonId;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testRecordDictionary = [[NSMutableArray alloc]init];
    self.lessonNavigationBar.topItem.title = self.categoryTypeName;
    self.authenticationToken = [User sharedInstance].theToken;
    self.currentQuestionNumber = 1;
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
                    self.lessonId = [[lesson objectForKey:@"id"] integerValue];
                    self.arrayOfWords = (NSArray *)[lesson objectForKey:@"words"];
                     self.totalNumberOfQuestion.text = [[NSNumber numberWithInteger:self.arrayOfWords.count] stringValue];
                     self.numberOfQuestion.text = [[NSNumber numberWithInteger:self.currentQuestionNumber] stringValue];
                     newarray = (NSArray *)[lesson objectForKey:@"words"];
                     NSDictionary *newQuestionDictionary = (NSDictionary *)[self.arrayOfWords objectAtIndex:1];
                    [self loadNewQuestion:self.currentQuestionNumber-1 ];
            }
        }];
}

-(void)loadNewQuestion:(int)numberOfNewQuestion {
    if(numberOfNewQuestion < self.arrayOfWords.count) {
        NSDictionary *newQuestionDictionary = (NSDictionary *)[self.arrayOfWords objectAtIndex:numberOfNewQuestion];
        self.questionContent.text = [newQuestionDictionary objectForKey:@"content"];
        NSArray *answer = [newQuestionDictionary objectForKey:@"answers"];
        for(int i = 0;i < answer.count;i++) {
            NSDictionary *newRow = (NSDictionary *)[answer objectAtIndex:i];
            if(i == 0) {
                [self.btnFirstOption setTitle:[newRow objectForKey:@"content"] forState:(UIControlStateNormal)];
            }
            else if(i == 1) {
                [self.btnSecondOption setTitle:[newRow objectForKey:@"content"] forState:(UIControlStateNormal)];
            }
            else if(i == 2) {
                [self.btnThiredOption setTitle:[newRow objectForKey:@"content"] forState:(UIControlStateNormal)];
            }
            else {
                [self.btnForthOption setTitle:[newRow objectForKey:@"content"] forState:(UIControlStateNormal)];
            }
        }
    }
}

- (IBAction)selectOptionAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    btn.selected = YES;
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Answer"
                              message:@"Are you sure to select this option?"
                              delegate:self cancelButtonTitle:@"NO"
                              otherButtonTitles:@"YES", nil];
    [alertView show];
}

- (IBAction)btnSpechAction:(id)sender {
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.questionContent.text];
    [utterance setRate:0.2f];
    [synthesizer speakUtterance:utterance];
}

- (IBAction)btnBackAction:(id)sender {
    for (UIViewController* controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[categoriesViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
}

-(void)updateLesson:(NSNumber *)result_id answer_id:(NSNumber *)answer_id {
    DataAccess *access = [[DataAccess alloc]init];
    [access updateLesson :self.lessonId
                result_id:result_id
                answer_id:answer_id
      authenticationToken: self.authenticationToken
                 complete:^(BOOL check ,NSDictionary* categoriesDictionary) {
                     if (check) {
                         NSLog(@"LEsson Update!");
                     }
    }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        return;
    }
    else  {
        if(self.btnFirstOption.isSelected) {
            checkAnswer = [self getDataForStorage:0];
            [testRecordDictionary  addObject:checkAnswer];
            self.btnFirstOption.selected = false;
        }
        else if(self.btnSecondOption.isSelected) {
            checkAnswer = [self getDataForStorage:1];
            [testRecordDictionary  addObject:checkAnswer];
            self.btnSecondOption.selected = false;
        }
        else if(self.btnThiredOption.isSelected) {
            checkAnswer = [self getDataForStorage:2];
            [testRecordDictionary  addObject:checkAnswer];
            self.btnThiredOption.selected = false;
        }
        else{
            checkAnswer = [self getDataForStorage:3];
            [testRecordDictionary  addObject:checkAnswer];
            self.btnForthOption.selected = false;
        }
        [self updateLesson:[checkAnswer objectForKey:@"id"]
                 answer_id:[checkAnswer objectForKey:@"answer_id"]];
        if(self.currentQuestionNumber+1 <= self.arrayOfWords.count ) {
            self.currentQuestionNumber += 1;
            self.numberOfQuestion.text = [[NSNumber numberWithInteger: self.currentQuestionNumber] stringValue];
            [self loadNewQuestion:self.currentQuestionNumber-1 ];
        }
        else{
            self.btnFirstOption.enabled = false;
            self.btnSecondOption.enabled = false;
            self.btnThiredOption.enabled = false;
            self.btnForthOption.enabled = false;
            
        }
    }
}

-(NSDictionary *)getDataForStorage: (int) selectedOption {
    NSDictionary *newQuestionDictionary = (NSDictionary *)[self.arrayOfWords objectAtIndex:self.currentQuestionNumber-1];
    NSMutableDictionary * newdata = [[NSMutableDictionary alloc]init];
    NSArray *answer = [newQuestionDictionary objectForKey:@"answers"];
    if(selectedOption < answer.count) {
        NSDictionary *newRow = (NSDictionary *)[answer objectAtIndex:selectedOption];
        [newdata setValue:[newQuestionDictionary objectForKey:@"content"] forKey:@"content"];
        [newdata setValue:[newQuestionDictionary objectForKey:@"id"] forKey:@"id"];
        [newdata setValue:[newRow objectForKey:@"is_correct"] forKey:@"is_correct"];
        if([[newRow objectForKey:@"is_correct"] integerValue] == 1) {
            [newdata setValue:[newRow objectForKey:@"content"] forKey:@"answer_content"];
            [newdata setValue:[newRow objectForKey:@"id"] forKey:@"answer_id"];
        }
        else {
            for(int i = 0;i < answer.count ;i++)
            {
                NSDictionary *anotherDic = (NSDictionary *)[answer objectAtIndex:i];
                if([[anotherDic objectForKey:@"is_correct"] integerValue] == 1)
                {
                    [newdata setValue:[anotherDic objectForKey:@"content"] forKey:@"answer_content"];
                    [newdata setValue:[anotherDic objectForKey:@"id"] forKey:@"answer_id"];
                    break;
                }
            }
        }
    }
    return newdata;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"results"]) {
        resultViewController *resViewController = segue.destinationViewController;
        resViewController.testResultDictionary = self.testRecordDictionary;
        resViewController.totalNumberOfQuestion = [self.totalNumberOfQuestion.text integerValue];
        resViewController.categoryTypeNameLeb = self.categoryTypeName;
    }
}

@end
