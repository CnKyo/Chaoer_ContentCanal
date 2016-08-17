//
//  DryCleanTimeChooseView.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanTimeChooseView.h"

@interface DryCleanTimeChooseView ()
@property(strong,nonatomic) UIButton *chooseBtn;
@end


@implementation DryCleanTimeChooseView

- (id)initWithArr:(NSArray *)arr
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        int row = 3;
        
        
        UIView *lastView = nil;
        for (int i=0; i<arr.count; i++) {
            NSString *title = [arr objectAtIndex:i];
            UIButton *btn = [self newUIButtonWithTarget:self mehotd:@selector(chooseMethod:) title:title titleColor:[UIColor grayColor]];
            btn.tag = 100 + i;
            
            UIView *lineSView = [self newDefaultLineView]; //竖线右
            UIView *lineHView = [self newDefaultLineView]; //横线下
//
//            
//            
//            [lineSView makeConstraints:^(MASConstraintMaker *make) {
//                if (lastView == nil || i % row == 0) {
//                    make.left.equalTo(self.left);
//                } else
//                    make.left.equalTo(lastView.right);
//                make.top.bottom.equalTo(btn);
//                make.width.equalTo(OnePixNumber);
//            }];
//            
//            if (i < row) {
//                UIView *lineHView1 = [self newDefaultLineView]; //横线上
//                [lineHView1 makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.right.equalTo(btn);
//                    make.top.equalTo(self.top);
//                    make.height.equalTo(OnePixNumber);
//                }];
//                
//            } else {
//                
//            }
//            
            if (i % row == 0) {
                UIView *lineSView1 = [self newDefaultLineView]; //竖线左
                [lineSView1 makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(btn);
                    make.right.equalTo(btn.left);
                    make.width.equalTo(OnePixNumber);
                }];
            }
            
            if (i < row) {
                UIView *lineHView1 = [self newDefaultLineView]; //横线上
                [lineHView1 makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(btn);
                    make.bottom.equalTo(btn.top);
                    make.height.equalTo(OnePixNumber);
                }];
            }
            
            [lineSView makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(btn);
                make.left.equalTo(btn.right);
                make.width.equalTo(OnePixNumber);
            }];
            
            [lineHView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(btn);
                make.top.equalTo(btn.bottom);
                make.height.equalTo(OnePixNumber);
            }];
            
            
            [btn makeConstraints:^(MASConstraintMaker *make) {
                if (i % row == 0) {
                    make.left.equalTo(self.left).offset(OnePixNumber);
                    if (lastView == nil) {
                        make.top.equalTo(self.top).offset(OnePixNumber);
                        make.height.equalTo(btn.mas_width).multipliedBy(0.4);
                    } else
                        make.top.equalTo(lastView.bottom).offset(OnePixNumber);
                } else {
                    if (i % row == row - 1)
                        make.right.equalTo(self.right).offset(-OnePixNumber);
                    
                    make.left.equalTo(lastView.right).offset(OnePixNumber);
                    make.top.equalTo(lastView.top);
                }
                
                if (lastView != nil)
                    make.width.height.equalTo(lastView);
                
            }];

            lastView = btn;

        }
        
        
        
        if (lastView != nil) {
            [self makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(lastView.bottom);
            }];
        }
    }
    return self;
}


-(void)chooseMethod:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    NSLog(@"index:%li", (long)index);
    
    UIColor *colorChoose = [UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000];
    UIColor *colorNormal = [UIColor blackColor];
    
    if (_chooseBtn != nil) {
        self.chooseBtn.layer.borderWidth = 0;
        self.chooseBtn.layer.borderColor = colorNormal.CGColor;
        self.chooseBtn.layer.masksToBounds = YES;
        [self.chooseBtn setTitleColor:colorNormal forState:UIControlStateNormal];
    }
    
    self.chooseBtn = sender;
    
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = colorChoose.CGColor;
    sender.layer.masksToBounds = YES;
    [sender setTitleColor:colorChoose forState:UIControlStateNormal];
}



@end
