//
//  PBCollectionCell.m
//  TestCollectionViewController
//
//  Created by 郭洪军 on 5/7/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "PBCollectionCell.h"

@interface PBCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end


@implementation PBCollectionCell

- (void)setImg:(UIImage *)img
{
    _img = img;
    
    self.imgView.image = img;
}

@end
