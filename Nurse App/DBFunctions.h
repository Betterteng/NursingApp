//
//  DBFunctions.h
//  Nurse App
//
//  Created by ram mendhe on 14/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DBFunctions : NSObject

@property (nonatomic,assign) int totalDuration;

-(void)addCPDEntryInDbWithTitle:(NSString*)title notes:(NSString*)notes date:(NSString*)date duration:(NSString*)duration;
-(void)updateCPDEntryWithTitle:(NSString*)title notes:(NSString*)notes date:(NSString*)date duration:(NSString*)duration timestamp:(NSString*)timestamp;

-(NSMutableArray*)getAllCPDEntries;
- (NSString *) timeStamp;
-(NSMutableArray*)getCPDEntryClassesForm;
-(void) deleteCPDEntryWithTimestamp:(NSString*)timestamp;

-(void)insertRecordsInQuestionsTable;
-(NSMutableArray*)getQuestionsClassesForm:(NSString*)chapterno year:(NSString*)year;
-(NSMutableArray*)getQuestionByChapterID:(NSString*)chapterno year:(NSString*)year;
-(int)isChapterUnlock:(NSString*)chapterno;
-(int)getCountOFTotalQuestionsChapter:(NSString*)chapterno;
-(int)getCountOFCorrectAnswerInChapter:(NSString*)chapterno;
-(void)updateQuestionRecord:(NSString*)questionid iscorrect:(NSString*)iscorrect;
-(int)insertInChapterLockTable:(NSString*)chapterno;
@end
