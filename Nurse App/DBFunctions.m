//
//  DBFunctions.m
//  Nurse App
//
//  Created by ram mendhe on 14/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "DBFunctions.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "CPDEntryData.h"
#import "QuizResult.h"
#import "Questions.h"
#import "NSObject+JSONSerializableSupport.h"

@implementation DBFunctions

-(int)isChapterUnlock:(NSString*)chapterno{
   /* int countOfTotalQuestion=[self getCountOFTotalQuestionsChapter:chapterno];
    int countOfCorrectQuestion = [self getCountOFCorrectAnswerInChapter:chapterno];
    if (countOfCorrectQuestion==countOfTotalQuestion) {
        return YES;
    }else{
        return NO;
    }*/
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ChapterLockEntry"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chapterno==%@",chapterno];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSInteger countOfChapter = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    NSLog(@"countOfTotalQuestion %lu",(long)countOfChapter);
    return (int)countOfChapter;
}


-(int)insertInChapterLockTable:(NSString*)chapterno{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ChapterLockEntry"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chapterno==%@",chapterno ];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSInteger count = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    if(count==0)//check chapter
    {
            NSManagedObject * chapterLockEntry = [NSEntityDescription insertNewObjectForEntityForName:@"ChapterLockEntry" inManagedObjectContext:managedObjectContext];
            
            [chapterLockEntry setValue:chapterno forKey:@"chapterno"];
            [chapterLockEntry setValue:@"0" forKey:@"islock"];
            
            NSError *error = nil;
            if (![managedObjectContext save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            else
            {
                NSLog(@"Data save properly");
                return 1;
            }
        
    }
    return 0;
}


-(int)getCountOFTotalQuestionsChapter:(NSString*)chapterno{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Questions"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chapterno==%@",chapterno];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSInteger countOfTotalQuestion = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    NSLog(@"countOfTotalQuestion %lu",(long)countOfTotalQuestion);
    return (int)countOfTotalQuestion;
}

-(int)getCountOFCorrectAnswerInChapter:(NSString*)chapterno{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"Questions"];
    [fetchRequest1 setReturnsObjectsAsFaults:NO];
    [fetchRequest1 setResultType:NSDictionaryResultType];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"chapterno==%@ and iscorrect==1",chapterno];
    [fetchRequest1 setPredicate:predicate1];
    NSError *error = nil;
    NSInteger countOfCorrectQuestion = [managedObjectContext countForFetchRequest:fetchRequest1 error:&error];
    NSLog(@"countOfCorrectQuestion %lu",(long)countOfCorrectQuestion);
    return (int)countOfCorrectQuestion;
}

-(NSMutableArray*)getQuestionsClassesForm:(NSString*)chapterno year:(NSString*)year{
    NSMutableArray* questionsClassArray=[[NSMutableArray alloc] init];
    NSMutableArray* dbQuestionArray=[self getQuestionByChapterID:chapterno year:year];
    if ([dbQuestionArray count]>0) {
        for( NSDictionary* obj in dbQuestionArray ) {
            
            NSLog(@"question id: %@",(NSString*) [obj objectForKey:@"questionid"]);
            Questions* questions=[[Questions alloc] init];
            
            questions.questionid=[obj objectForKey:@"questionid"];
            questions.chapterno=[obj objectForKey:@"chapterno"];
            questions.question=[obj objectForKey:@"question"];
            questions.answer=[obj objectForKey:@"answer"];
            
            questions.optiona=[obj objectForKey:@"optiona"];
            questions.optionb=[obj objectForKey:@"optionb"];
            questions.optionc=[obj objectForKey:@"optionc"];
            questions.optiond=[obj objectForKey:@"optiond"];
            
            questions.iscorrect=[obj objectForKey:@"iscorrect"];
            questions.idl =[obj objectForKey:@"idl"];
            
            [questionsClassArray addObject:questions];
        }
    }
    NSLog(@"Count of Question Arra %lu",(unsigned long)[questionsClassArray count]);
    return questionsClassArray;
}

-(NSMutableArray*)getQuestionByChapterID:(NSString*)chapterno year:(NSString*)year{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Questions"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chapterno==%@ and idl==%@",chapterno,year];
    [fetchRequest setPredicate:predicate];
    NSArray * itemArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"Count of Question Array %lu",(unsigned long)[itemArray count]);
    return [[NSMutableArray alloc] initWithArray:itemArray];
}

-(void)insertRecordsInQuestionsTable{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Questions"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setResultType:NSDictionaryResultType];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"groupid==%@",groupid ];
    [fetchRequest setPredicate:nil];
    NSError *error = nil;
    NSInteger count = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    NSLog(@"Count of all messages %lu",(long)count);
    
    if(count==0)//check user is already logged in or not
    {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"quizJson" ofType:@"txt"];
        NSString* content = [NSString stringWithContentsOfFile:path  encoding:NSUTF8StringEncoding  error:NULL];
        NSLog(@"File content %@", content);
        QuizResult* quizResult=[QuizResult fromJSONData:[content dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Number of question count %lu",(unsigned long)[quizResult.Chapters count]);
        for (int i=0; i<[quizResult.Chapters count]; i++) {
            Questions* questions=[quizResult.Chapters objectAtIndex:i];
            
            NSManagedObject * dbQuestions = [NSEntityDescription insertNewObjectForEntityForName:@"Questions" inManagedObjectContext:managedObjectContext];
            
            [dbQuestions setValue:questions.questionid forKey:@"questionid"];
            [dbQuestions setValue:questions.chapterno  forKey:@"chapterno"];
            [dbQuestions setValue:questions.question  forKey:@"question"];
            [dbQuestions setValue:questions.answer  forKey:@"answer"];
            
            [dbQuestions setValue:questions.optiona forKey:@"optiona"];
            [dbQuestions setValue:questions.optionb  forKey:@"optionb"];
            [dbQuestions setValue:questions.optionc  forKey:@"optionc"];
            [dbQuestions setValue:questions.optiond  forKey:@"optiond"];
            
            [dbQuestions setValue:questions.iscorrect forKey:@"iscorrect"];
            [dbQuestions setValue:questions.idl  forKey:@"idl"];
            
            NSError *error = nil;
            if (![managedObjectContext save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            else
            {
                NSLog(@"Data save properly with question id %@", questions.questionid);
            }
        }
    }
}


-(void)updateQuestionRecord:(NSString*)questionid iscorrect:(NSString*)iscorrect
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Questions"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionid==%@",questionid];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSLog(@"number of objects %lu",(unsigned long)[fetchedObjects count]);
    for (NSManagedObject *object in fetchedObjects)
    {
        [object setValue:iscorrect  forKey:@"iscorrect"];
    }
    
    error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else
    {
        NSLog(@"Data save properly");
    }
}



-(void) deleteCPDEntryWithTimestamp:(NSString*)timestamp{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CPDEntry"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"entryTimestamp==%@",timestamp];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSLog(@"number of objects %lu",(unsigned long)[fetchedObjects count]);
    for (NSManagedObject *object in fetchedObjects)
    {
        [managedObjectContext deleteObject:object];
    }
    
    error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else
    {
        NSLog(@"Data deleted properly");
    }
}

-(NSMutableArray*)getCPDEntryClassesForm{
    self.totalDuration=0;
    NSMutableArray* cpdEntryClassArray=[[NSMutableArray alloc] init];
    NSMutableArray* entryArray=[self getAllCPDEntries];
    if ([entryArray count]>0) {
        for( NSDictionary* obj in entryArray ) {
            NSLog(@"Group Entry Timestamp: %@",(NSString*) [obj objectForKey:@"entryTimestamp"]);
            CPDEntryData* cpdEntry=[[CPDEntryData alloc] init];
            cpdEntry.entryTimestamp=[obj objectForKey:@"entryTimestamp"];
            cpdEntry.entrytitle=[obj objectForKey:@"entrytitle"];
            cpdEntry.entrynotes=[obj objectForKey:@"entrynotes"];
            cpdEntry.entrydate=[obj objectForKey:@"entrydate"];
            cpdEntry.entryduration=[obj objectForKey:@"entryduration"];
            self.totalDuration=self.totalDuration+[cpdEntry.entryduration intValue];
            [cpdEntryClassArray addObject:cpdEntry];
        }
    }
    NSLog(@"Total Duration: %d",self.totalDuration);
    return cpdEntryClassArray;
}


-(NSMutableArray*)getAllCPDEntries{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CPDEntry"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPredicate:nil];
    NSArray * itemArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"Count of Array %lu",(unsigned long)[itemArray count]);
    return [[NSMutableArray alloc] initWithArray:itemArray];
}
-(void)updateCPDEntryWithTitle:(NSString*)title notes:(NSString*)notes date:(NSString*)date duration:(NSString*)duration timestamp:(NSString*)timestamp{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CPDEntry"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"entryTimestamp==%@",timestamp];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSLog(@"number of objects %lu",(unsigned long)[fetchedObjects count]);
    for (NSManagedObject *object in fetchedObjects)
    {
        [object setValue:title forKey:@"entrytitle"];
        [object setValue:notes  forKey:@"entrynotes"];
        [object setValue:date  forKey:@"entrydate"];
        [object setValue:duration  forKey:@"entryduration"];
    }
    
    error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else
    {
        NSLog(@"Data save properly");
    }
}

-(void)addCPDEntryInDbWithTitle:(NSString*)title notes:(NSString*)notes date:(NSString*)date duration:(NSString*)duration{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSManagedObject * cpdEntry = [NSEntityDescription insertNewObjectForEntityForName:@"CPDEntry" inManagedObjectContext:managedObjectContext];
    [cpdEntry setValue:[self timeStamp] forKey:@"entryTimestamp"];
    [cpdEntry setValue:title forKey:@"entrytitle"];
    [cpdEntry setValue:notes  forKey:@"entrynotes"];
    [cpdEntry setValue:date  forKey:@"entrydate"];
    [cpdEntry setValue:duration  forKey:@"entryduration"];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else
    {
        NSLog(@"Data save properly");
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSString *) timeStamp {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}
@end
