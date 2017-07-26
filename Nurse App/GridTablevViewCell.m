//
//  GridTablevViewCell.m
//  Nurse App
//
//  Created by Asmita on 05/08/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "GridTablevViewCell.h"

@implementation GridTablevViewCell

- (void)awakeFromNib {
    // Initialization code
    self.rhythmCollectionView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ra-backround"]];
    imageArray=[[NSMutableArray alloc]initWithObjects:@"ra7",@"ra6",@"ra5",@"ra4",@"ra2",@"ra3",@"ra1",@"ra18",@"ra17",@"ra16",@"ra15",@"ra14",@"ra13", nil];
     self.titleImageView.image=[UIImage imageNamed:@"ra0"];
     self.headerImageView.image=[UIImage imageNamed:@"ra11"];
     
     largeImageArray=[[NSMutableArray alloc]initWithObjects:@"row12",@"row11",@"row10",@"row9",@"row8",@"row7",@"row6",@"row5",@"row4",@"row3",@"row2",@"row1",@"row0", nil];
     [self.rhythmCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma GridView Methods


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    return imageArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CollectionViewCell";
    self.collectionViewCell = [self.rhythmCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    self.collectionViewCell.rhythmImageView.image=[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    return self.collectionViewCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row: %@",[NSString stringWithFormat:@"%ld",(long)indexPath.item]);
    if(indexPath.row!=9)
    {
        [self.delegate sendData:(UIImage *)[UIImage imageNamed:[largeImageArray objectAtIndex:indexPath.row]]];
      
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"item:%ld",(long)indexPath.row);
    CGSize calCulateSize=CGSizeMake(50,488);
    if(indexPath.row==0||indexPath.row==6||indexPath.row==8||indexPath.row==10||indexPath.row==11)
    {
        calCulateSize.width=30;
    }
    else if(indexPath.row==3||indexPath.row==5||indexPath.row==7)
    {
        calCulateSize.width=80;
    }
    else if(indexPath.row==9)
    {
        calCulateSize.width=60;
    }
    else if(indexPath.row==12)
    {
        calCulateSize.width=20;
    }

    
    return calCulateSize;
}


@end
