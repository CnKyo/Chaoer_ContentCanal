//
//  DryCleanShopServerDetailVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanShopServerDetailVC.h"
#import "UIView+AutoSize.h"
#import "RatingBar.h"
#import "APIClient.h"
#import "UIImage+QUAdditons.h"
#import "UIImageView+AFNetworking.h"
#import "QUCustomDefine.h"

@interface DryCleanShopServerDetailVC ()
//@property(nonatomic,strong) UIScrollView*       scrollView;
//@property(nonatomic,strong) UIView*             scrollContentView;

@property(nonatomic,strong) UIImageView*        imgView;
@property(nonatomic,strong) UILabel*            nameLable;
@property(nonatomic,strong) TTTAttributedLabel* priceLable;
@property(nonatomic,strong) UILabel*            standardlable;
@property(nonatomic,strong) UILabel*            describeLable;
@end



@implementation DryCleanShopServerDetailVC


-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"详情页";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    
    [self.view bringSubviewToFront:self.scrollView];
    [self initView];
    
    [self reloadUIWithData];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[APIClient sharedClient] dryClearnShopServerInfoWithTag:self serverId:_item.iD call:^(DryClearnShopServerObject *item, APIObject *info) {
        if (info.state == RESP_STATUS_YES && item!=nil) {
            self.item = item;
            [self reloadUIWithData];

            [SVProgressHUD dismiss];
        } else {
            if (info.message.length > 0)
                [SVProgressHUD showErrorWithStatus:info.message];
        }
    }];
    
}

- (void)initView{
    
    UIView *contentView = self.scrollContentView;
    int padding = 10;
    
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    self.scrollContentView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    
    UIImageView *imgView = [contentView newUIImageViewWithImg:IMG(@"DefaultImg.png")];
    self.imgView = imgView;
    
    UIView *aView = ({
        UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
        UILabel *nameLable = [view newUILableWithText:@"衬衫" textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:15]];
        
        TTTAttributedLabel *attributedLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"干洗费：10元/件"
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor redColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:16],
                                                                                     NSKernAttributeName : [NSNull null],
                                                                                     (id)kTTTBackgroundFillColorAttributeName : (id)[UIColor greenColor].CGColor
                                                                                     }];
        attributedLabel.text = attString;
        [view addSubview:attributedLabel];
        self.nameLable = nameLable;
        self.priceLable = attributedLabel;
        [nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.bottom.equalTo(view);
        }];
        [attributedLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(nameLable.right).offset(padding/2);
            make.top.bottom.equalTo(view);
            make.right.equalTo(view.right).offset(-padding);
        }];
        view;
    });
    
    UIView *bView = ({
        UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [UIColor colorWithRed:0.894 green:0.898 blue:0.902 alpha:1.000].CGColor;
        view.layer.borderWidth = 1;
        UIView *infoView = ({
            UIView *vi = [view newUIViewWithBgColor:[UIColor colorWithRed:0.941 green:0.945 blue:0.949 alpha:1.000]];
            UILabel *lable = [view newUILableWithText:@"干洗标准" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
            [lable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(vi.left).offset(padding);
                make.right.equalTo(vi.right).offset(-padding);
                make.top.bottom.equalTo(vi);
            }];
            vi;
        });
        UILabel *notelable = [view newUILableWithText:@"" textColor:[UIColor colorWithRed:0.310 green:0.314 blue:0.318 alpha:1.000] font:[UIFont systemFontOfSize:13]];
        notelable.numberOfLines = 0;
        self.standardlable = notelable;
        [infoView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(infoView.mas_width).multipliedBy(0.1);
        }];
        [notelable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infoView.bottom).offset(padding);
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
        }];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(notelable.bottom).offset(padding);
        }];
        view;
    });
    
    UIView *cView = ({
        UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [UIColor colorWithRed:0.894 green:0.898 blue:0.902 alpha:1.000].CGColor;
        view.layer.borderWidth = 1;
        UIView *infoView = ({
            UIView *vi = [view newUIViewWithBgColor:[UIColor colorWithRed:0.941 green:0.945 blue:0.949 alpha:1.000]];
            UILabel *lable = [view newUILableWithText:@"购买须知" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
            [lable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(vi.left).offset(padding);
                make.right.equalTo(vi.right).offset(-padding);
                make.top.bottom.equalTo(vi);
            }];
            vi;
        });
        UILabel *notelable = [view newUILableWithText:@"" textColor:[UIColor colorWithRed:0.310 green:0.314 blue:0.318 alpha:1.000] font:[UIFont systemFontOfSize:13]];
        notelable.numberOfLines = 0;
        self.describeLable = notelable;
        [infoView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(infoView.mas_width).multipliedBy(0.1);
        }];
        [notelable makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infoView.bottom).offset(padding);
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
        }];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(notelable.bottom).offset(padding);
        }];
        view;
    });
    
    UIView *dView = ({
        UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [UIColor colorWithRed:0.894 green:0.898 blue:0.902 alpha:1.000].CGColor;
        view.layer.borderWidth = 1;
        UIView *infoView = ({
            UIView *vi = [view newUIViewWithBgColor:[UIColor colorWithRed:0.941 green:0.945 blue:0.949 alpha:1.000]];
            UILabel *lable = [view newUILableWithText:@"服务流程" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
            [lable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(vi.left).offset(padding);
                make.right.equalTo(vi.right).offset(-padding);
                make.top.bottom.equalTo(vi);
            }];
            vi;
        });
        UIImageView *imgView = [view newUIImageViewWithImg:IMG(@"dryClean_serverliucheng")];
        [infoView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(infoView.mas_width).multipliedBy(0.1);
        }];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infoView.bottom).offset(padding);
            make.left.right.equalTo(view);
            make.height.equalTo(imgView.mas_width).multipliedBy(0.76);
        }];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imgView.bottom).offset(padding);
        }];
        view;
    });
    
    
    [imgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.equalTo(imgView.mas_width).multipliedBy(0.6);
    }];
    [aView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.height.equalTo(aView.mas_width).multipliedBy(0.15);
        make.top.equalTo(imgView.mas_bottom);
    }];
    [bView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.bottom).offset(padding);
        make.left.equalTo(contentView.left).offset(padding);
        make.right.equalTo(contentView.right).offset(-padding);
    }];
    [cView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bView.bottom).offset(padding);
        make.left.equalTo(contentView.left).offset(padding);
        make.right.equalTo(contentView.right).offset(-padding);
    }];
    [dView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cView.bottom).offset(padding);
        make.left.equalTo(contentView.left).offset(padding);
        make.right.equalTo(contentView.right).offset(-padding);
    }];
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(dView.bottom).offset(padding+50);
    }];
    
    [self.scrollView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.top).offset(64);
    }];


    
//    if (self.scrollView == nil) {
//        self.scrollView = [self.view newUIScrollView];
//        self.scrollView.showsHorizontalScrollIndicator = NO;
//        self.scrollView.showsVerticalScrollIndicator = NO;
//        self.scrollView.scrollEnabled = YES;
//        self.scrollView.backgroundColor = [UIColor clearColor];
//        self.scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
//        
////        [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
////            make.top.equalTo(superView.top).offset(64);
////            make.left.right.bottom.equalTo(superView);
////        }];
//        
//        UIView *contentView = [self.scrollView newUIView];
//        contentView.tag = 101;
//        contentView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
//        contentView.translatesAutoresizingMaskIntoConstraints = NO;
//        self.scrollContentView = contentView;
//        [contentView makeConstraints:^(MASConstraintMaker *make) {
//            //            make.left.top.width.equalTo(self.scrollView);
//            //            make.height.equalTo(3000);
//            make.edges.equalTo(_scrollView);
//            make.width.equalTo(_scrollView);
//        }];
//        
//        
//            }
//    
//    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(superView);
//        make.top.equalTo(superView.top).offset(64);
//    }];

//    UIView *btnView = ({
//        UIView *view = [superView newUIViewWithBgColor:[UIColor whiteColor]];
//        UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(goYudingMethod:) title:@"预约" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:18]];
//        [btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
//        [btn makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view.left).offset(padding);
//            make.right.equalTo(view.right).offset(-padding);
//            make.top.equalTo(view.top).offset(padding/2);
//            make.bottom.equalTo(view.bottom).offset(-padding/2);
//        }];
//        view;
//    });
//    [btnView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(superView);
//        make.height.equalTo(btnView.mas_width).multipliedBy(0.14);
//    }];
//    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(superView);
//        make.top.equalTo(superView.top).offset(64);
//        make.bottom.equalTo(btnView.top);
//    }];

}

-(void)reloadUIWithData
{
    [self.imgView setImageWithURL:[NSURL imageurl:_item.image] placeholderImage:IMG(@"DefaultImg.png")];
    self.nameLable.text = _item.type.length > 0 ? _item.type : @"暂无";
    self.priceLable.text = [NSString stringWithFormat:@"￥%.2f", _item.price];
    self.standardlable.text = _item.standard.length > 0 ? _item.standard : @"暂无";
    self.describeLable.text = _item.describe.length > 0 ? _item.describe : @"暂无";
}



#pragma mark - BtnMethod

//预约
-(void)goYudingMethod:(UIButton *)sender
{

}

@end
