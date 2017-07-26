//
//  QuizViewController.m
//  Nurse App
//
//  Created by ram mendhe on 06/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "QuizViewController.h"
#import "QuizImagesViewController.h"
#import "DBFunctions.h"
#import "ChapterSelectionViewController.h"
@interface QuizViewController ()

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    DBFunctions* dbf=[[DBFunctions alloc] init];
    [dbf insertRecordsInQuestionsTable];
    
}

-(void)createNavigationBar
{
    
    //hide back button
    self.navigationItem.hidesBackButton=true;
    //Nativation title
    UIImageView *navigationTitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationTitle"]];
    self.navigationItem.titleView=navigationTitleImage;
    
    // set navigation bar background color
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15.0f/255.0f green:15.0f/255.0f blue:15.0f/255.0f alpha:1.0f]];
    
    UITapGestureRecognizer *newTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked)];
    [self.quizBackgroundImage setUserInteractionEnabled:YES];
    [self.quizBackgroundImage addGestureRecognizer:newTap];
}

-(void)imageClicked{
    NSLog(@"Image has been clicked");
    QuizImagesViewController* quizImagesViewController=[[QuizImagesViewController alloc] initWithNibName:@"QuizImagesViewController" bundle:nil];
    quizImagesViewController.chapterNumber=1;
    [self.navigationController pushViewController:quizImagesViewController animated:YES];
    
    /*ChapterSelectionViewController* chapterSelectionViewController=[[ChapterSelectionViewController alloc] initWithNibName:@"ChapterSelectionViewController" bundle:nil];
    [self.navigationController pushViewController:chapterSelectionViewController animated:YES];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
