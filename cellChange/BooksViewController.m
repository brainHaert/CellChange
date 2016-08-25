//
//  BooksViewController.m
//  cellChange
//
//  Created by admin on 15/12/19.
//  Copyright (c) 2015年 zilong. All rights reserved.
//
#define seletedCellHeight 180
#define CellHeight 60

#import "BooksViewController.h"
#import "FMBooksViewController.h"
#import "FMTableViewCell.h"

@interface BooksViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    BOOL _isOpen;
    NSIndexPath *_selectedIndexPath;
}

@property(nonatomic,strong)NSDictionary *dataArr;

@end

@implementation BooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"table";
    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(trunToOtherView)];
//    
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self setUpTableView];
}

-(void)setUpTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _isOpen = YES;
    [self.view addSubview:_tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[FMTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if ([self isSameIndex:indexPath] && _isOpen) {//变大
        [cell bigLabelText:indexPath];
    } else {//正常
        [cell labelText:indexPath];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self isSameIndex:indexPath]) {
        
        if (_isOpen == YES) {
            
            return seletedCellHeight;
            
        } else {
           
            return CellHeight;
            
        }
        
    } else {
        
        return CellHeight;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    
    [_tableView reloadRowsAtIndexPaths:indexPathsArr withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

-(void)trunToOtherView{
    FMBooksViewController *otherBook = [[FMBooksViewController alloc]init];
    [self.navigationController pushViewController:otherBook animated:YES];
}
-(BOOL)isSameIndex:(NSIndexPath *)indexPath{
    return (_selectedIndexPath.section == indexPath.section && _selectedIndexPath.row == indexPath.row);
}
@end
