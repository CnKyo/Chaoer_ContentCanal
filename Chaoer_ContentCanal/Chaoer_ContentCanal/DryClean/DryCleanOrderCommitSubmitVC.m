//
//  DryCleanOrderCommitSubmitVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanOrderCommitSubmitVC.h"
#import "UIView+AutoSize.h"
#import "RateView.h"
#import "APIClient.h"
#import "UIImage+QUAdditons.h"

@interface DryCleanOrderCommitSubmitVC ()

@end

@implementation DryCleanOrderCommitSubmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"评价";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    
    [self.view bringSubviewToFront:self.scrollView];
    [self initView];
    
}

- (void)initView{

    self.scrollContentView.backgroundColor = [UIColor whiteColor];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    UIView *superView = self.scrollContentView;
    int padding = 10;
    
    UIView *btnView = ({
        UIView *view = [self.view newUIViewWithBgColor:[UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000]];
        UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(goSubmmitMethod:) title:@"确认选择" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:18]];
        [btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(view.top).offset(padding/2);
            make.bottom.equalTo(view.bottom).offset(-padding/2);
        }];
        view;
    });
    [btnView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(btnView.mas_width).multipliedBy(0.14);
    }];
    
    
    [self.scrollView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(btnView.top);
    }];
    
//    [self.scrollContentView remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.width.equalTo(self.scrollView);
//    }];
    
    
    UIView *aView = ({
        UIView *view = [superView newUIView];
        UIImageView *iconImgView = [view newUIImageViewWithImg:IMG(@"icon_headerdefault.png")];
        UILabel *titleLable = [view newUILableWithText:@"干洗店干洗店干洗店" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        titleLable.numberOfLines = 0;
        [iconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.height.equalTo(view.mas_height).multipliedBy(0.7);
            make.centerY.equalTo(view.centerY);
            make.width.equalTo(iconImgView.mas_height);
        }];
        [titleLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImgView.right).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(view.top).offset(padding/2);
            make.bottom.equalTo(view.bottom).offset(-padding/2);
        }];
        view;
    });
    UIView *lineView1 = [superView newDefaultLineView];
    UIView *bView = ({
        UIView *view = [superView newUIView];
        view.frame = CGRectMake(0, 0, DEVICE_Width, 70);
        UILabel *noteLable = [view newUILableWithText:@"满意" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] textAlignment:QU_TextAlignmentCenter];
        noteLable.frame = CGRectMake(0, 0, view.bounds.size.width, 30);
        
        RateView *barView = [RateView rateViewWithRating:3.7f];
        //bar.rating = 4.0f;
        barView.starNormalColor = [UIColor colorWithRed:0.804 green:0.808 blue:0.812 alpha:1.000];
        barView.starFillColor = [UIColor colorWithRed:0.976 green:0.675 blue:0.165 alpha:1.000];
        //barView.starSize = 30;
        barView.padding = 30/4;
        barView.frame = CGRectMake((view.bounds.size.width-200)/2, 30, 200, 30);
        //RatingBar *barView = [[RatingBar alloc] initWithFrame:CGRectMake((view.bounds.size.width-250)/2, 30, 250, 30)];
        [view addSubview:barView];
        view;
    });
    UIView *lineView2 = [superView newDefaultLineView];
    UIView *cView = ({
        UIView *view = [superView newUIView];
        UIView *lastView = nil;
        for (int i=0; i<4; i++) {
            UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(editPicMethod:)];
            [btn setBackgroundImage:IMG(@"dryClean_addPic.png") forState:UIControlStateNormal];
            [btn makeConstraints:^(MASConstraintMaker *make) {
                if (lastView == nil) {
                    make.left.equalTo(view.left);
                    make.height.equalTo(btn.mas_width);
                } else {
                    if (i == 3)
                        make.right.equalTo(view.right);
                    make.left.equalTo(lastView.right).offset(padding);
                    make.width.height.equalTo(lastView);
                }
                make.top.equalTo(view.top).offset(padding);
            }];
            lastView = btn;
        }
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.bottom).offset(padding);
        }];
        view;
    });
    UILabel *noteLable = [superView newUILableWithText:@"传几张真实图片，让更多人看到" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] textAlignment:QU_TextAlignmentCenter];
    UITextView *textView = [superView newUITextView];
    textView.text = @"写下您对商家的评价或者发布你自己的看法吧～";
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = [UIColor colorWithRed:0.827 green:0.831 blue:0.835 alpha:1.000].CGColor;
    textView.layer.borderWidth = 1;
    textView.layer.cornerRadius = 5;
    
    [aView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(aView.mas_width).multipliedBy(0.2);
    }];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(aView.bottom);
        make.height.equalTo(OnePixNumber);
    }];
    [bView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(lineView1.bottom);
        make.height.equalTo(70);
    }];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(bView.bottom);
        make.height.equalTo(OnePixNumber);
    }];
    [cView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(lineView2.bottom);
    }];
    [noteLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cView.bottom);
        make.left.right.equalTo(cView);
        make.height.equalTo(30);
    }];
    [textView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteLable.bottom);
        make.left.right.equalTo(cView);
        make.height.equalTo(textView.mas_width).multipliedBy(0.3);
    }];
    

    [self.scrollContentView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textView.bottom).offset(padding);
    }];

}

-(void)editPicMethod:(UIButton *)sender
{
    
}


-(void)goSubmmitMethod:(id)sender
{
    
}


@end
