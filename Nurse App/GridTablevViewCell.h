//
//  GridTablevViewCell.h
//  Nurse App
//
//  Created by Asmita on 05/08/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"


@protocol cellProtocol <NSObject>
-(void)sendData:(UIImage *)img;
@end

@interface GridTablevViewCell : UITableViewCell
{
    NSMutableArray * imageArray;
    NSMutableArray * largeImageArray;
}
@property(nonatomic,strong)CollectionViewCell * collectionViewCell;
@property(nonatomic,strong)IBOutlet UICollectionView * rhythmCollectionView;
@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;

@property (nonatomic,weak) id <cellProtocol> delegate;
@end
