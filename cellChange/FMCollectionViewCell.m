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

-(void)labelText:(NSIndexPath *)indexPath{
    
    _label.text = [NSString stringWithFormat:@"%@",indexPath];
}
-(void)bigLabelText{
    _label.text = @"我已经变大了，哈哈";
}
@end
