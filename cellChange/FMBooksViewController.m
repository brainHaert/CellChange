//
//  FMBooksViewController.m
//  cellChange
//
//  Created by admin on 15/12/19.
//  Copyright (c) 2015年 zilong. All rights reserved.
//
#define kCellHeight 60
#define kSeletedCellHeight 180

#import "FMBooksViewController.h"
#import "BooksViewController.h"
#import "FMCollectionViewCell.h"

@interface FMBooksViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    
    BOOL _isOpen;
    NSIndexPath *_selectedIndexPath;
}

@end

@implementation FMBooksViewController

static NSString *const CELLID = @"cellID";
static NSString *const BigCELLID = @"BigcellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"collect";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(trunToOtherView)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self setUpCollectionView];
    
    NSString *newBillDateStr = @"2015-12-24";
    NSString *billDateStr = @"2015-12-23";
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* oldDate = [inputFormatter dateFromString:billDateStr];
    NSDate* newDate = [inputFormatter dateFromString:newBillDateStr];
    
    NSTimeInterval secondsInterval= [newDate timeIntervalSinceDate:oldDate];
    NSLog(@"%f",secondsInterval);
}
-(void)setUpCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 6;
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[FMCollectionViewCell class] forCellWithReuseIdentifier:CELLID];
    [_collectionView registerClass:[FMCollectionViewCell class] forCellWithReuseIdentifier:BigCELLID];
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    _isOpen = YES;
    [self.view addSubview:_collectionView];
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self isSameIndex:indexPath] && _isOpen) {//变大
        FMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BigCELLID forIndexPath:indexPath];
        
        [cell bigLabelText:indexPath];
        
        return cell;
    } else {//正常
        FMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
        
        [cell labelText:indexPath];
        
        return cell;
    }
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isSameIndex:indexPath]) {
        
        if (_isOpen == YES) {
            
            return CGSizeMake(self.view.frame.size.width, kSeletedCellHeight);
            
        } else {
            
            return CGSizeMake(self.view.frame.size.width, kCellHeight);
            
        }
        
    } else {
        
        return CGSizeMake(self.view.frame.size.width, kCellHeight);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //将索引加到数组中
    NSArray *indexPathsArr = [NSArray arrayWithObject:indexPath];
    //判断选中不同row状态时候
    if ([self isSameIndex:indexPath]) {//将选中的和所有索引都加进数组中
        
        indexPathsArr = [NSArray arrayWithObjects:indexPath, nil];
        
        _isOpen = !_isOpen;
        
    }else if (![self isSameIndex:indexPath]) {
        
        indexPathsArr = [NSArray arrayWithObjects:indexPath,_selectedIndexPath, nil];
        
        _isOpen = YES;
    }
    
    _selectedIndexPath = indexPath;
    
    
    [_collectionView reloadItemsAtIndexPaths:indexPathsArr];
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}



- (void)trunToOtherView{
    BooksViewController *VVV = [[BooksViewController alloc]init];
    [self.navigationController pushViewController:VVV animated:YES];
}
-(BOOL)isSameIndex:(NSIndexPath *)indexPath{
    return (_selectedIndexPath.section == indexPath.section && _selectedIndexPath.item == indexPath.item);
}
@end
