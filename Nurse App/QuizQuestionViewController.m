//
//  QuizQuestionViewController.m
//  Nurse App
//
//  Created by ram mendhe on 01/06/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "QuizQuestionViewController.h"
#import "ChapterResultHeaderLabelCell.h"
#import "QuestionDisplayCell.h"
#import "DBFunctions.h"
#import "Questions.h"
#import "QuizButtonCell.h"
#import "AnswerCell.h"
#import "ChapterResultViewController.h"
#import "RevealCell.h"

static CGFloat questionMargin = 20.0f;
static CGFloat messageTextSize = 22.0;

static CGFloat ansMargin = 16.0f;
static CGFloat ansTextSize = 12.0;


@interface QuizQuestionViewController ()
{
    NSMutableArray* questionsArray;
    DBFunctions* dBFunctions;
    int currentQuestionIndex;
    
    NSString * currentAnswer;
    int cellCount;
    NSString * revealAns;
    
}
@end

@implementation QuizQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    
    self.navigationController.navigationBarHidden=NO;
    
    cellCount=7;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.questionsTableView.frame];
    self.questionsTableView.backgroundView = tempImageView;
    
    if(self.yearno.length==0)
    {
        self.yearno=@"0";
    }
    
    NSLog(@"year%@",self.yearno);
    dBFunctions=[[DBFunctions alloc] init];
    questionsArray=[dBFunctions getQuestionsClassesForm:self.chapterno year:self.yearno];
    
    //shuffling array
    NSUInteger count = [questionsArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        long nElements = count - i;
        long n = (random() % nElements) + i;
        [questionsArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    currentQuestionIndex=0;
    [self.questionsTableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //call code when replay
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"Replay"] isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Replay"];
        
        //shuffling array
        NSUInteger count = [questionsArray count];
        for (NSUInteger i = 0; i < count; ++i) {
            // Select a random element between i and end of array to swap with.
            long nElements = count - i;
            long n = (random() % nElements) + i;
            [questionsArray exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
        
        currentQuestionIndex=0;
        [self.questionsTableView reloadData];
    }
}


-(void)createNavigationBar
{
    //self.navigationItem.hidesBackButton=true;
    UIImageView *navigationTitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationTitle"]];
    self.navigationItem.titleView=navigationTitleImage;
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15.0f/255.0f green:15.0f/255.0f blue:15.0f/255.0f alpha:1.0f]];
}


//Table View Codding. ----- Start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([questionsArray count]==0) {
        return 0;
    }
    return cellCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Questions* question=[questionsArray objectAtIndex:currentQuestionIndex];
    if (indexPath.row==0) {
        static NSString *cellIdentifier = @"Cell";
        ChapterResultHeaderLabelCell *cell = (ChapterResultHeaderLabelCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterResultHeaderLabelCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        cell.chapterLabel.text=[NSString stringWithFormat:@"Chapter %@",self.chapterno];
        return cell;
    }else if(indexPath.row==1){
        static NSString *cellIdentifier = @"Cell";
        QuestionDisplayCell *cell = (QuestionDisplayCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"QuestionDisplayCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        cell.questionLabel.text=question.question;
        return cell;
    }else if(indexPath.row==2 || indexPath.row==3 || indexPath.row==4 || indexPath.row==5){
        static NSString *cellIdentifier = @"Cell";
        AnswerCell *cell = (AnswerCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.row==2) {
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            cell.ansLabel.text=question.optiona;
            currentAnswer=@"A";
        }else if (indexPath.row==3) {
            cell.ansLabel.text=question.optionb;
        }else if (indexPath.row==4) {
            cell.ansLabel.text=question.optionc;
        }else if (indexPath.row==5) {
            cell.ansLabel.text=question.optiond;
        }
        return cell;
    }
    else if (indexPath.row==6 && cellCount==8)
    {
        static NSString *cellIdentifier = @"Cell";
        RevealCell *cell = (RevealCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RevealCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        
        if([question.answer isEqualToString:@"A"])
        {
            revealAns=question.optiona;
        }
        else if([question.answer isEqualToString:@"B"])
        {
            revealAns=question.optionb;
        }
        else if([question.answer isEqualToString:@"C"])
        {
            revealAns=question.optionc;
        }
        else if([question.answer isEqualToString:@"D"])
        {
            revealAns=question.optiond;
        }
        
        cell.revealAnsLabel.text=revealAns;
        return cell;
        
    }
    
    static NSString *cellIdentifier = @"Cell";
    QuizButtonCell *cell = (QuizButtonCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QuizButtonCell" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.revealButton addTarget:self action:@selector(revealButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.nextButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Row selected %ld",(long)indexPath.row);
    if (indexPath.row==2) {
        
        currentAnswer=@"A";
        
    }else if (indexPath.row==3) {
        
        currentAnswer=@"B";
        
    }else if (indexPath.row==4) {
        
        currentAnswer=@"C";
        
    }else if (indexPath.row==5) {
        
        currentAnswer=@"D";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Questions* question=[questionsArray objectAtIndex:currentQuestionIndex];
    double height=0;
    if (indexPath.row==0) {
        height=92;
    }else if (indexPath.row==1) {
        CGSize messageSize=[self messageSize:question.question];
        height=messageSize.height + 2*questionMargin + 20.0f;
    }else if (indexPath.row==2) {
        CGSize messageSize=[self messageSizeAns:question.optiona];
        height=messageSize.height + 2*ansMargin + 20.0f;
    }else if (indexPath.row==3) {
        CGSize messageSize=[self messageSizeAns:question.optionb];
        height=messageSize.height + 2*ansMargin + 20.0f;
    }else if (indexPath.row==4) {
        CGSize messageSize=[self messageSizeAns:question.optionc];
        height=messageSize.height + 2*ansMargin + 20.0f;
    }else if (indexPath.row==5) {
        CGSize messageSize=[self messageSizeAns:question.optiond];
        height=messageSize.height + 2*ansMargin + 20.0f;
    }else if(indexPath.row==6 && cellCount==8){
        // CGSize messageSize=[self messageSizeAns:revealAns];
        // height=messageSize.height + 2*ansMargin + 20.0f;
        height=46;
    }
    else{
        height=80;
    }
    return height;
}

-(void)nextButtonClicked:(id)sender
{
    
    Questions* question=[questionsArray objectAtIndex:currentQuestionIndex];
    if(cellCount==7)
    {
        if([question.answer isEqualToString:currentAnswer])
        {
            NSLog(@"quetion%@",question.answer);
            question.iscorrect=@"1";
            NSLog(@"iscorrect%@",question.iscorrect);
            [self saveAnswerResult];
        }
        else
        {
            question.iscorrect=@"0";
            [self saveAnswerResult];
        }
    }
    else if (cellCount==8)
    {
        question.iscorrect=@"0";
        [self saveAnswerResult];
    }
    
    // NSLog(@"question id%@",question.questionid);
}

-(void)saveAnswerResult
{
    cellCount=7;
    
    Questions* question=[questionsArray objectAtIndex:currentQuestionIndex];
    [dBFunctions updateQuestionRecord:question.questionid iscorrect:question.iscorrect];
    
    if(questionsArray.count-1!=currentQuestionIndex)
    {
        currentQuestionIndex=currentQuestionIndex+1;
        [self.questionsTableView reloadData];
    }
    else
    {
        ChapterResultViewController* chapterResultViewController=[[ChapterResultViewController alloc] initWithNibName:@"ChapterResultViewController" bundle:nil];
        chapterResultViewController.chapterNo=self.chapterno;
        [self.navigationController pushViewController:chapterResultViewController animated:YES];
    }
}

-(void)revealButtonClicked:(id)sender
{
    cellCount=8;
    [self.questionsTableView reloadData];
}

-(CGSize)messageSize:(NSString*)message {
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:messageTextSize]}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){270.0f, CGFLOAT_MAX}  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size;
}

-(CGSize)messageSizeAns:(NSString*)message {
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:ansTextSize]}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){270.0f, CGFLOAT_MAX}  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size;
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
