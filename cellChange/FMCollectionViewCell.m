//
//  FMCollectionViewCell.m
//  cellChange
//
//  Created by admin on 15/12/19.
//  Copyright (c) 2015年 zilong. All rights reserved.
//

#import "FMCollectionViewCell.h"

@implementation FMCollectionViewCell
{
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height)];
        
        _label.textColor = [UIColor redColor];
        
        _label.font = [UIFont systemFontOfSize:12];
        
        _label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_label];
    }
    return self;
}

- (void)labelText:(NSIndexPath *)indexPath {
    _label.text = [NSString stringWithFormat:@"small %zd",indexPath.row];
}

- (void)bigLabelText:(NSIndexPath *)indexPath {
    _label.text = [NSString stringWithFormat:@"grow up %zd",indexPath.row];
}

@end
