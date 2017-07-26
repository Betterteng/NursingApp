//
//  QuizImagesViewController.m
//  Nurse App
//
//  Created by ram mendhe on 29/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "QuizImagesViewController.h"
#import "ChapterSelectionViewController.h"
#import "QuizQuestionViewController.h"
#import "ChapterYearSelectionViewController.h"

@interface QuizImagesViewController ()
{
    //NSArray* chapter1ImageArray;
    NSArray* currentArray;
    int arryIndexCounter;
    NSString * title;
    
}
@end

@implementation QuizImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    
    if (self.chapterNumber==1) {
        currentArray=[[NSArray alloc] initWithObjects:@"frame_1.jpg",@"frame_2.jpg",@"frame_3.jpg",@"frame_4.jpg",@"frame_5.jpg",@"frame_6.jpg",@"frame_7.jpg",@"frame_8.jpg",@"frame_9.jpg",@"frame_10.jpg",@"frame_11.jpg",@"frame_12.jpg",@"frame_13.jpg",@"frame_14.jpg",@"frame_15.jpg",@"frame_16.jpg",@"frame_17.jpg",@"frame_18.jpg",@"frame_19.jpg",@"frame_20.jpg",@"frame_21.jpg",@"frame_22.jpg",@"frame_23.jpg",@"frame_24.jpg",@"frame_25.jpg",@"frame_26.jpg",@"frame_27.jpg",@"frame_28.jpg",@"frame_29.jpg", nil];
    }
    else if (self.chapterNumber==2) {
        currentArray=[[NSArray alloc] initWithObjects:@"chp2_frame1.jpg",@"chp2_frame2.jpg",@"chp2_frame3.jpg",@"chp2_frame4.jpg",@"chp2_frame5.jpg",@"chp2_frame6.jpg",@"chp2_frame7.jpg", nil];
        title=@"chp2_frame";
    }
    else if (self.chapterNumber==3) {
        currentArray=[[NSArray alloc] initWithObjects:@"chp3_frame1.jpg",@"chp3_frame2.jpg",@"chp3_frame3.jpg",@"chp3_frame4.jpg",@"chp3_frame5.jpg",@"chp3_frame6.jpg",@"chp3_frame7.jpg",@"chp3_frame1.jpg", nil];
        title=@"chp3_frame";
    }
    else if (self.chapterNumber==4) {
        currentArray=[[NSArray alloc] initWithObjects:@"chp4_frame1.jpg",@"chp4_frame2.jpg",@"chp4_frame3.jpg",@"chp4_frame4.jpg",@"chp4_frame5.jpg", nil];
        title=@"chp4_frame";
    }
    else if (self.chapterNumber==5) {
        currentArray=[[NSArray alloc] initWithObjects:@"chp5_frame1.jpg",@"chp5_frame2.jpg",@"chp5_frame3.jpg",@"chp5_frame4.jpg",@"chp5_frame5.jpg", nil];
        title=@"chp5_frame";
    }
    
    UITapGestureRecognizer *newTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImage)];
    [self.quizeStoryImageView setUserInteractionEnabled:YES];
    [self.quizeStoryImageView addGestureRecognizer:newTap];
    
    [self changeImage];
}

-(void)changeImage{
    
    arryIndexCounter+=1;
    NSLog(@"changeImage %d",arryIndexCounter);
    if (arryIndexCounter>(int)[currentArray count]) {
        NSLog(@"End of the array");
        NSLog(@"Image has been clicked");
        if(self.chapterNumber==1)
        {
            ChapterSelectionViewController* chapterSelectionViewController=[[ChapterSelectionViewController alloc] initWithNibName:@"ChapterSelectionViewController" bundle:nil];
            //chapterSelectionViewController.chapterNumber=self.chapterNumber;
            [self.navigationController pushViewController:chapterSelectionViewController animated:YES];
        }
        else if (self.chapterNumber==5)
        {
            //chapter 5th year page
            ChapterYearSelectionViewController* chapterYearSelectionViewController=[[ChapterYearSelectionViewController alloc] initWithNibName:@"ChapterYearSelectionViewController" bundle:nil];
            [self.navigationController pushViewController:chapterYearSelectionViewController animated:YES];

        }
        else
        {
            QuizQuestionViewController* quizQuestionViewController=[[QuizQuestionViewController alloc] initWithNibName:@"QuizQuestionViewController" bundle:nil];
            quizQuestionViewController.chapterno=[NSString stringWithFormat:@"%d",self.chapterNumber];
            [self.navigationController pushViewController:quizQuestionViewController animated:YES];
        }
    }else
    {
        if (self.chapterNumber==1) {
            self.quizeStoryImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"frame_%d.jpg",arryIndexCounter]];
        }
        else
        {
            self.quizeStoryImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@%d.jpg",title,arryIndexCounter]];
        }
        
    }
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
