//
//  WKLabelView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "WKLabelView.h"

@implementation WKLabelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setArray:(NSArray *)array{
    static UIButton *beforeBtn=nil;

    if (array.count!= 0 || array!= nil) {

        for (int i=0; i<array.count; i++)
        {
            NSString *name=array[i];
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            CGRect rect=[name boundingRectWithSize:CGSizeMake(DEVICE_Width, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:button.titleLabel.font} context:nil];
            if (i==0)
            {
                button.frame=CGRectMake(10, 10, rect.size.width+15, 30);
            }
            else
            {
                CGFloat leaveWidth=DEVICE_Width-beforeBtn.frame.size.width-beforeBtn.frame.origin.x-20;
                if (leaveWidth>=rect.size.width)
                {
                    button.frame=CGRectMake(CGRectGetMaxX(beforeBtn.frame)+10, beforeBtn.frame.origin.y, rect.size.width+15, 30);
                }
                else
                {
                    
                    button.frame=CGRectMake(10, CGRectGetMaxY(beforeBtn.frame)+10, rect.size.width+15, 30);
                }
                
            }
            
            
            button.titleLabel.font = [UIFont systemFontOfSize:15];
     
            [button setBackgroundImage:[UIImage imageNamed:@"mNote_unselected"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"mNote_select"] forState:UIControlStateSelected];
            
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:M_CO forState:UIControlStateSelected];
            
            button.tag=i;
            button.clipsToBounds=YES;
            [button setTitle:name forState:UIControlStateNormal];
            beforeBtn=button;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
        }
        
        self.mHight = beforeBtn.frame.origin.y+40;
        
    }else{
        array=@[@"曾经最美",@"隐形的翅膀",@"让爱重来",@"爱的天国",@"后悔了吧",@"怎样",@"让我忘了",@"怎么知道你爱我",@"你到底爱",@"你到底爱",@"知道不知",@"赤道和北",@"再见中国",@"爱是怎么回",@"幸福的天堂",@"呐喊",@"遗失的美好",@"划地为牢"];
        for (int i=0; i<array.count; i++)
        {
            NSString *name=array[i];
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            CGRect rect=[name boundingRectWithSize:CGSizeMake(DEVICE_Width, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:button.titleLabel.font} context:nil];
            if (i==0)
            {
                button.frame=CGRectMake(10, 10, rect.size.width+15, 30);
            }
            else
            {
                CGFloat leaveWidth=DEVICE_Width-beforeBtn.frame.size.width-beforeBtn.frame.origin.x-20;
                if (leaveWidth>=rect.size.width)
                {
                    button.frame=CGRectMake(CGRectGetMaxX(beforeBtn.frame)+10, beforeBtn.frame.origin.y, rect.size.width+15, 30);
                }
                else
                {
                    
                    button.frame=CGRectMake(10, CGRectGetMaxY(beforeBtn.frame)+10, rect.size.width+15,30);
                }
                
            }
            
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            
            [button setBackgroundImage:[UIImage imageNamed:@"mNote_unselected"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"mNote_select"] forState:UIControlStateSelected];
            
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:M_CO forState:UIControlStateSelected];
     
            button.tag=i;
            button.clipsToBounds=YES;
            [button setTitle:name forState:UIControlStateNormal];
            beforeBtn=button;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        self.mHight = beforeBtn.frame.origin.y+40;
    }
    
    
    
}


-(void)btnClick:(UIButton *)sender
{

    if (self.mCureentArr == nil) {
        self.mCureentArr = [NSMutableArray new];
        [self.mCureentArr removeAllObjects];
    }
    
    [self.delegate viewDidSelectedIndex:sender.tag];
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.mCureentArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }else{
        [self.mCureentArr removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
    [self.delegate currentViewArray:self.mCureentArr];
}

@end
