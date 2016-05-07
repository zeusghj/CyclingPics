//
//  ViewController.m
//  TestCollectionViewController
//
//  Created by 郭洪军 on 5/6/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "ViewController.h"
#import "PBCollectionCell.h"

//定义宏图片的个数
#define kPictureCount  3

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;


/**
 *  图片的索引
 */
@property(nonatomic, assign)NSInteger index;

@end

static NSString* ID = @"cell";

@implementation ViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kPictureCount;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PBCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    //图片索引只有下一张或者上一张，即+1，或者-1，为了切换图片
    //中间的cell的角标是1，滚动后角标是2或者0，凑成next值为+1 或者-1（让图片索引+1或者-1来完成切换图片），则
    NSInteger next = indexPath.item - 1;
    
    //为了不让next越界，进行取余运算 --------+next为了切换图片
    next = (self.index + kPictureCount + next) % kPictureCount;
    
    NSString* imgName = [NSString stringWithFormat:@"home_scroll_%ld", next + 1];
    UIImage* img = [UIImage imageNamed:imgName];
    
    cell.img = img;
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算偏移的整数倍,偏移了0或者是2, -1是让self.index图片索引+1 或者 -1以切换图片;
    NSInteger offset = scrollView.contentOffset.x / self.collectionView.bounds.size.width - 1 ;
    
    self.index = (self.index + offset + kPictureCount) % kPictureCount;
    
    //本质就是改变cell的索引,再根据self.index来切换图片,使用取余让图片索引不至于越界
    //异步主队列执行,为了不让连续滚动停止后,图片有闪动.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToSecondCell];
    });
}

//封装设置当前显示的cell为第二个cell的方法.
-(void)scrollToSecondCell{
    
    NSIndexPath * idxPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:idxPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PBCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];

    self.flowLayout.itemSize = self.collectionView.bounds.size;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self scrollToSecondCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
