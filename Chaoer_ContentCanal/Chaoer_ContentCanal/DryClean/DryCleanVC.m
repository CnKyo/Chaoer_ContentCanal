//
//  DryCleanVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanVC.h"
#import "APIClient.h"
#import "UIView+AutoSize.h"
#import "UIImageView+AFNetworking.h"
#import "RatingBarView.h"
#import "UIImage+QUAdditons.h"
#import "DryCleanOrderCommentTVC.h"
#import "DryCleanShopServerDetailVC.h"
#import "DryCleanOrderCommentSubmitVC.h"
#import "DryCleanServerTableViewCell.h"
#import "DryCleanOrderSubmitVC.h"
#import "RateView.h"
#import "mFoodHeaderView.h"
#import "mFoodClearView.h"
#import "mFoodShopCarCell.h"

@interface DryCleanVC ()<UITableViewDelegate,UITableViewDataSource, WKFoodHeaderViewDelegate, WKFoodShopCarCellDelegate>
{
    mFoodHeaderView *mBottomView;
    
    mFoodClearView *mClearView;
    int mNum;
    int mTTPrice;
}
@property(nonatomic,strong) UISegmentedControl *segControl;
@property(nonatomic,strong) UIScrollView*       scrollView;
@property(nonatomic,strong) UIView*             scrollContentView;

@property(nonatomic,strong) UIView*         segSelect1View; //当选择商家分类时，组装的总view
@property(nonatomic,strong) UITableView*    classTableView;
@property(nonatomic,strong) NSMutableArray* classArr;
@property(nonatomic,assign) NSInteger       classIndex; //选择哪一种类别

@property(nonatomic,strong) UITableView *   mShopCarListView;
@property(nonatomic,strong) UIView *        mShopCarBgkView;
@property(nonatomic,strong) NSMutableArray* mShopCartArr;


@property(nonatomic,strong) UIImageView*    shopImgView;
@property(nonatomic,strong) UILabel*        shopNameLable;
@property(nonatomic,strong) UILabel*        shopAddressLable;
@property(nonatomic,strong) UILabel*        shopDesLable;
@property(nonatomic,strong) UILabel*        shopCampaignLable;

@property(nonatomic,strong) DryClearnShopObject* shopItem;
@property(nonatomic,assign) int                 shopCoupon;
@property(nonatomic,assign) int                 shopFocus;

@end



@implementation DryCleanVC

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"家政服务";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = NO;
    self.rightBtnTitle = @"收藏";
    [self setRightBtnWidth:70];
    
    self.page = 1;
    
    [self initView];
    [self initShopCarView];
    
    //self.classArr = [NSMutableArray arrayWithObjects:@"分类1",@"分类2",@"分类3",@"分类4",@"分类5", nil];
    self.classArr = [NSMutableArray array];
    self.mShopCartArr = [NSMutableArray array];
    

    self.segControl.selectedSegmentIndex = 0;
    [self loadSegSelectIndex:0];
}


- (void)initView{
    
    
    UIView *superView = self.view;
    int padding = 10;
    UIFont *font1 = [UIFont systemFontOfSize:15];
    UIFont *font2 = [UIFont systemFontOfSize:13];

    UIView *segView = ({
        UIView *view = [superView newUIViewWithBgColor:[UIColor colorWithRed:0.490 green:0.745 blue:0.078 alpha:0.800]];
        self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"商家", @"分类"]];
        self.segControl.tintColor = [UIColor whiteColor];
        [self.segControl addTarget:self action:@selector(segControlChange:) forControlEvents:UIControlEventValueChanged];
        [superView addSubview:_segControl];
        
        [self.segControl makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(view);
            make.height.equalTo(35);
            make.width.equalTo(150);
        }];
        view;
    });
    [segView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView.top).offset(64);
        make.height.equalTo(45);
    }];

    
    
    
    if (self.scrollView == nil) {
        self.scrollView = [self.view newUIScrollView];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(segView.bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
        
        UIView *contentView = [self.scrollView newUIView];
        contentView.tag = 101;
        contentView.backgroundColor = [UIColor colorWithRed:0.898 green:0.902 blue:0.906 alpha:1.000];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.scrollContentView = contentView;
        [contentView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.width.equalTo(self.scrollView);
//            make.height.equalTo(3000);
            make.edges.equalTo(_scrollView);
            make.width.equalTo(_scrollView);
        }];
        
        UIImageView *imgView = [contentView newUIImageViewWithImg:IMG(@"DefaultImg.png")];
        self.shopImgView = imgView;
        
        UIView *aView = ({
            UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
            UILabel *nameLable = [view newUILableWithText:@"超尔干洗店" textColor:[UIColor blackColor] font:font1];
            //UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(goYudingMethod:) title:@"去预约" titleColor:[UIColor whiteColor] titleFont:font1];
            //[btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.518 green:0.745 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
            self.shopNameLable = nameLable;
            [nameLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.left).offset(padding);
                make.top.equalTo(view.top).offset(padding/2);
                make.bottom.equalTo(view.bottom).offset(-padding/2);
                make.right.equalTo(view.right).offset(-padding);
            }];
//            [btn makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(nameLable.mas_right).offset(padding/2);
//                make.centerY.equalTo(view.centerY);
//                make.right.equalTo(view.mas_right).offset(-padding);
//                make.width.equalTo(80);
//                make.height.equalTo(35);
//            }];
            view;
        });
//        UIView *aView = ({
//            UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
//            UILabel *nameLable = [view newUILableWithText:@"超尔干洗店" textColor:[UIColor blackColor] font:font1];
////            RateView *bar = [RateView rateViewWithRating:3.7f];
////            bar.backgroundColor = [UIColor redColor];
////            bar.rating = 4.0f;
//            RatingBarView *bar = [[RatingBarView alloc] initWithHight:20];
//            [view addSubview:bar];
//            UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(goYudingMethod:) title:@"去预约" titleColor:[UIColor whiteColor] titleFont:font1];
//            [btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.518 green:0.745 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
//            self.shopNameLable = nameLable;
//            [nameLable makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(view.left).offset(padding);
//                make.top.equalTo(view.top).offset(padding/2);
//                make.height.equalTo(25);
//            }];
//            [bar makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(nameLable.mas_left);
//                make.top.equalTo(nameLable.mas_bottom);
//                make.height.equalTo(40);
//                make.width.equalTo(200);
//            }];
//            [btn makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(nameLable.mas_right).offset(padding/2);
//                make.centerY.equalTo(nameLable.mas_bottom);
//                make.right.equalTo(view.mas_right).offset(-padding);
//                make.width.equalTo(80);
//                make.height.equalTo(35);
//            }];
//            [view makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(nameLable.bottom).offset(30);
//            }];
//            view;
//        });
        UIView *lineView1 = [contentView newDefaultLineView];
        UIView *bView = ({
            UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
            UIImageView *iconImgView = [view newUIImageViewWithImg:IMG(@"dryClean_address.png")];
            UILabel *addressLable = [view newUILableWithText:@"重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎" textColor:[UIColor colorWithRed:0.439 green:0.443 blue:0.447 alpha:1.000] font:font2];
            addressLable.numberOfLines = 0;
            self.shopAddressLable = addressLable;
            UIView *lineView11 = [view newDefaultLineView];
            
            UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(goCallTelMethod:) imgNormal:IMG(@"dryClean_calltel.png")];
            
            [iconImgView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(padding);
                make.width.height.equalTo(9);
                make.centerY.equalTo(view.mas_centerY);
            }];
            [addressLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(iconImgView.mas_right).offset(padding);
                make.top.equalTo(view.mas_top).offset(padding/2);
                make.bottom.equalTo(view.mas_bottom).offset(-padding/2);
                make.right.equalTo(lineView11.mas_left).offset(-padding/2);
            }];
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.bottom.equalTo(view);
                make.width.equalTo(btn.mas_height);
            }];
            [lineView11 makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn.mas_left);
                make.top.equalTo(view.mas_top).offset(padding/2);
                make.bottom.equalTo(view.mas_bottom).offset(-padding/2);
                make.width.equalTo(OnePixNumber);
            }];
            view;
        });
//        UIView *cView = ({
//            UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
//            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goCommentMethod:)];
//            [view addGestureRecognizer:tapGesture];
//            RatingBarView *bar = [[RatingBarView alloc] initWithHight:25];
//            [view addSubview:bar];
//            UILabel *countLable = [view newUILableWithText:@"100人评价" textColor:[UIColor grayColor] font:font2 textAlignment:QU_TextAlignmentRight];
//            UIImageView *iconImgView = [view newUIImageViewWithImg:IMG(@"jiantou1.png")];
//            [bar makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(view.mas_left).offset(padding);
//                make.top.equalTo(view.mas_top).offset(padding/2);
//            }];
//            [iconImgView makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(view.mas_right).offset(-padding);
//                make.centerY.equalTo(view.mas_centerY);
//                make.width.equalTo(7);
//                make.height.equalTo(13);
//            }];
//            [countLable makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(bar.mas_right).offset(padding/2);
//                make.right.equalTo(iconImgView.mas_left).offset(-padding/2);
//                make.top.bottom.equalTo(view);
//            }];
//            view;
//        });
        UIView *dView = ({
            UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
            UIImageView *iconImgView1 = [view newUIImageViewWithImg:IMG(@"dryClean_ad.png")];
            UILabel *iconLable1 = [view newUILableWithText:@"商家公告" textColor:[UIColor colorWithRed:0.404 green:0.408 blue:0.412 alpha:1.000] font:font1];
            UIView *lineView11 = [view newDefaultLineView];
            UILabel *noteLable = [view newUILableWithText:@"商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告" textColor:[UIColor colorWithRed:0.439 green:0.443 blue:0.447 alpha:1.000] font:font2];
            noteLable.numberOfLines = 0;
            UIImageView *iconImgView2 = [view newUIImageViewWithImg:IMG(@"dryClean_huodong.png")];
            UILabel *iconLable2 = [view newUILableWithText:@"活动说明" textColor:[UIColor colorWithRed:0.404 green:0.408 blue:0.412 alpha:1.000] font:font1];
            UILabel *huodongLable = [view newUILableWithText:@"商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告商家公告" textColor:[UIColor colorWithRed:0.439 green:0.443 blue:0.447 alpha:1.000] font:font2];
            huodongLable.numberOfLines = 0;
            self.shopDesLable = noteLable;
            self.shopCampaignLable = huodongLable;
            
            [iconImgView1 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(padding);
                make.centerY.equalTo(iconLable1.mas_centerY);
                make.width.height.equalTo(15);
            }];
            [iconLable1 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(iconImgView1.mas_right).offset(padding/2);
                make.top.equalTo(view.mas_top).offset(padding/2);
                make.height.equalTo(20);
            }];
            [lineView11 makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(view);
                make.top.equalTo(iconLable1.mas_bottom).offset(padding/2);
                make.height.equalTo(OnePixNumber);
            }];
            [noteLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(padding);
                make.right.equalTo(view.mas_right).offset(-padding);
                make.top.equalTo(lineView11.mas_bottom).offset(padding);
                make.height.greaterThanOrEqualTo(25);
            }];
            [iconImgView2 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(padding);
                make.centerY.equalTo(iconLable2.mas_centerY);
                make.width.height.equalTo(15);
            }];
            [iconLable2 makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(iconImgView2.mas_right).offset(padding/2);
                make.top.equalTo(noteLable.mas_bottom).offset(padding/2);
                make.height.equalTo(20);
            }];
            [huodongLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(padding);
                make.right.equalTo(view.mas_right).offset(-padding);
                make.top.equalTo(iconLable2.mas_bottom).offset(padding/2);
                make.height.greaterThanOrEqualTo(25);
            }];
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(huodongLable.mas_bottom).offset(padding/2);
            }];
            view;
        });
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(contentView);
            make.height.equalTo(imgView.mas_width).multipliedBy(0.6);
        }];
        [aView updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(imgView.mas_bottom).offset(padding);
            make.height.equalTo(aView.mas_width).multipliedBy(0.15);
        }];
        [lineView1 makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(aView.mas_bottom);
            make.height.equalTo(OnePixNumber);
        }];
        [bView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(lineView1.mas_bottom);
            make.height.equalTo(aView.mas_height);
        }];
//        [cView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(contentView);
//            make.top.equalTo(bView.mas_bottom).offset(padding);
//            make.height.equalTo(40);
//        }];
        [dView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(bView.mas_bottom).offset(padding);
        }];
        
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(dView.bottom).offset(padding+50);
        }];
    }
    
    
    
    float classTableViewWidth = 80;
    
    self.segSelect1View = [self.view newUIView];
    [self.segSelect1View makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segView.bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.classTableView = [[UITableView alloc] init];
    self.classTableView.delegate = self;
    self.classTableView.dataSource = self;
    self.classTableView.tableFooterView = UIView.new;
    self.classTableView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    [self.segSelect1View addSubview:_classTableView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.996 green:1.000 blue:1.000 alpha:1.000];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.segSelect1View addSubview:self.tableView];
    
    mBottomView = [mFoodHeaderView shareBottomView];
    mBottomView.delegate = self;
    mBottomView.mNum.hidden = YES;
    [self.segSelect1View addSubview:mBottomView];
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.segSelect1View);
        make.height.offset(@50);
    }];
    
//    UIView *cartView = ({
//        UIView *view = [self.segSelect1View newUIViewWithBgColor:[UIColor colorWithRed:0.910 green:0.918 blue:0.922 alpha:1.000]];
//        UIButton *cartBtn = [view newUIButtonWithTarget:self mehotd:@selector(showCartView:) bgImgNormal:IMG(@"dryClean_cart_gray.png")];
//        UILabel *priceLable = [view newUILableWithText:@"￥10" textColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000] font:[UIFont systemFontOfSize:18]];
//        UIView *lineView = [view newUIViewWithBgColor:[UIColor colorWithRed:0.808 green:0.812 blue:0.816 alpha:1.000]];
//        UILabel *noteLable = [view newUILableWithText:@"取衣费：2元" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13]];
//        UIButton *submmitBtn = [view newUIButtonWithTarget:self mehotd:@selector(goSubmmitMethod:) title:@"去结算" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:18]];
//        [submmitBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
//        [cartBtn makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view.left).offset(padding);
//            make.top.equalTo(view.top).offset(padding/2);
//            make.bottom.equalTo(view.bottom).offset(-padding/2);
//            make.width.equalTo(cartBtn.mas_height);
//        }];
//        [priceLable makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(cartBtn.right).offset(padding/2);
//            make.top.bottom.equalTo(cartBtn);
//        }];
//        [lineView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(priceLable.right).offset(padding);
//            make.height.equalTo(view.mas_height).multipliedBy(0.6);
//            make.width.equalTo(OnePixNumber);
//            make.centerY.equalTo(view.centerY);
//        }];
//        [noteLable makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(lineView.right).offset(padding);
//            make.top.bottom.equalTo(cartBtn);
//            make.right.lessThanOrEqualTo(submmitBtn.left).offset(-padding/2);
//        }];
//        [submmitBtn makeConstraints:^(MASConstraintMaker *make) {
//            make.right.top.bottom.equalTo(view);
//            make.width.equalTo(submmitBtn.mas_height).multipliedBy(1.5);
//        }];
//        view;
//    });
//    [cartView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.segSelect1View);
//        make.height.equalTo(cartView.mas_width).multipliedBy(0.15);
//    }];
    
    [self.classTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.segSelect1View);
        make.bottom.equalTo(mBottomView.top);
        make.width.equalTo(classTableViewWidth);
    }];
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_classTableView.mas_right);
        make.top.bottom.equalTo(_classTableView);
        make.right.equalTo(self.segSelect1View.right);
    }];
    
    self.haveHeader = YES;
}

-(void)loadSegSelectIndex:(NSInteger)index
{
    if (index == 0) {
        [self.view bringSubviewToFront:self.scrollView];
        self.scrollView.hidden = NO;
        self.segSelect1View.hidden = YES;
        
        if (_shopItem == nil) {
            [SVProgressHUD showWithStatus:@"加载中..."];
            [[APIClient sharedClient] dryClearnShopInfoWithTag:self shopId:9 call:^(DryClearnShopObject *item, int coupon, int focus, APIObject *info) {
                if (item != nil) {
                    self.shopItem = item;
                    self.shopCoupon = coupon;
                    self.shopFocus = focus;
                    [self reloadShopInfoUI];
                    [SVProgressHUD dismiss];
                } else
                    [SVProgressHUD showErrorWithStatus:info.message];
            }];
        }

    } else {
        [self.view bringSubviewToFront:self.segSelect1View];
        self.scrollView.hidden = YES;
        self.segSelect1View.hidden = NO;
        
        if (self.classArr.count == 0) {
            [SVProgressHUD showWithStatus:@"加载中..."];
            [[APIClient sharedClient] dryClearnShopClassListWithTag:self shopId:9 call:^(NSArray *tableArr, APIObject *info) {
                if (tableArr.count > 0) {
                    [self.classArr setArray:tableArr];
                    [self.classTableView reloadData];
                    [self selectClassIndex:0];
                    
                    [SVProgressHUD dismiss];
                } else
                    [SVProgressHUD showErrorWithStatus:info.message];
            }];
        }
    }
}


-(void)segControlChange:(id)sender
{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    [self loadSegSelectIndex:control.selectedSegmentIndex];
}



-(void)reloadShopInfoUI
{
    [self reloadShopFocusType];
    
    [self.shopImgView setImageWithURL:[NSURL imageurl:_shopItem.shopLogo] placeholderImage:IMG(@"DefaultImg.png")];
    self.shopNameLable.text = _shopItem.shopName.length > 0 ? _shopItem.shopName : @"暂无";
    self.shopAddressLable.text = _shopItem.address.length > 0 ? _shopItem.address : @"暂无";
    self.shopDesLable.text = _shopItem.shopDes.length > 0 ? _shopItem.shopDes : @"暂无";
    
    NSMutableString *str = [NSMutableString string];
    for (DryClearnShopCampaignObject *it in _shopItem.campaignList) {
        [str appendFormat:@"%@ %@ %@", it.name, it.condition, it.content];
    }
    self.shopCampaignLable.text = str.length > 0 ? str : @"暂无";
}
-(void)reloadShopFocusType
{
    self.rightBtnTitle = _shopFocus > 0 ? @"已收藏" : @"未收藏";
}


#pragma mark - TableView

-(void)selectClassIndex:(NSInteger)row
{
    if (_classArr.count > 0) {
        if (_classArr.count > row) {
            if (row != _classIndex) {
                self.classIndex = row;
                [self.classTableView reloadData];
                [self restartTableView];
            }
        }
    } else
        [SVProgressHUD showErrorWithStatus:@"暂无分类"];
}

-(void)restartTableView
{
    self.page = 1;
    [self.tempArray removeAllObjects];
    [self.tableView reloadData];
    [self headerBeganRefresh];
}



- (void)headerBeganRefresh{
    
    self.page = 1;
    
    //[SVProgressHUD showWithStatus:@"加载类别中..."];
    [[APIClient sharedClient] dryClearnShopServerListWithTag:self shopId:9 classId:1 call:^(NSArray *tableArr, APIObject *info) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        
        [self.tempArray setArray:tableArr];
        
        if (info.state == RESP_STATUS_YES) {
            if (tableArr == nil) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } else {
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:info.message];
        }
    }];
}


#pragma mark -- tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.mShopCarListView) {
        return 40;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.mShopCarListView) {
        mClearView = [mFoodClearView shareView];
        [mClearView.mClearnBtn addTarget:self action:@selector(mClearAction:) forControlEvents:UIControlEventTouchUpInside];
        return mClearView;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _classTableView) {
        if (_classArr.count > 0)
            return _classArr.count;
    } else if (tableView == self.tableView) {
        if (self.tempArray.count > 0)
            return self.tempArray.count;
    } else if (tableView == self.mShopCarListView) {
        return self.mShopCartArr.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView ) {
        return 80;
    } else if(tableView == self.mShopCarListView){
        return 40;
    }
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _classTableView) {
        static NSString *CellIdentifier = @"ClassGoodsTableViewCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            UIView *superView = cell.contentView;
//            UIImageView *imgView = [superView newUIImageViewWithImg:IMG(@"DefaultImg.png")];
//            imgView.tag = 10;
            UILabel *lable = [cell.contentView newUILableWithText:@"" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:14] textAlignment:QU_TextAlignmentCenter];
            lable.tag = 11;
            //int padding = 10;
            [lable makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(superView);
            }];
//            [imgView makeConstraints:^(MASConstraintMaker *make) {
//                make.width.height.equalTo(20);
//                make.top.equalTo(superView.top).offset(padding/2);
//                make.centerX.equalTo(superView.centerX);
//            }];
//            [lable makeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(superView);
//                make.top.equalTo(imgView.bottom);
//                make.bottom.equalTo(superView.bottom).offset(-padding/2);
//            }];
        }
        //UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:10];
        UILabel *lable = (UILabel *)[cell.contentView viewWithTag:11];
        if (_classIndex == indexPath.row) {
            lable.textColor = [UIColor colorWithRed:0.518 green:0.745 blue:0.129 alpha:1.000];
            lable.backgroundColor = [UIColor whiteColor];
//            lable.textColor = [UIColor whiteColor];
//            lable.backgroundColor = [UIColor colorWithRed:0.518 green:0.745 blue:0.129 alpha:1.000];
        } else {
            lable.textColor = [UIColor colorWithWhite:0.3 alpha:1];
            lable.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
        }
        
        DryClearnShopClassObject* item = [self.classArr objectAtIndex:indexPath.row];
        lable.text = item.name;
        
        return cell;
        
        
    } else if (tableView == self.mShopCarListView){
        static NSString *CellIdentifier = @"ClassGoodsTableViewCell3";
        
        mFoodShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mIndexPath = indexPath;
        cell.delegate = self;
        
        DryClearnShopServerObject* item = [self.mShopCartArr objectAtIndex:indexPath.row];
        cell.mName.text = item.type.length>0 ? item.type : @"暂无";
        cell.mNum.text =  StringWithInt(item.count);
        
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"ClassGoodsTableViewCell2";
        DryCleanServerTableViewCell *cell = (DryCleanServerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[DryCleanServerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            //cell.backgroundColor = [UIColor clearColor];
        }
        DryClearnShopServerObject* item = [self.tempArray objectAtIndex:indexPath.row];
        cell.nameLable.text = item.type.length>0 ? item.type : @"暂无";
        cell.priceLable.text = [NSString stringWithFormat:@"￥%.2f", item.price];
        [cell.thumbImgView setImageWithURL:[NSURL imageurl:item.image] placeholderImage:IMG(@"DefaultImg.png")];
        
        cell.count = [self countFromCartDicWithId:item.iD];

        cell.jianCallBack = ^(int count) {
            item.count = count;
            [self setCartArrWithItem:item];
        };
        cell.addCallBack = ^(int count) {
            item.count = count;
            [self setCartArrWithItem:item];
        };
        
        return cell;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_classTableView == tableView) {
        [self selectClassIndex:indexPath.row];
        
    } else if (self.tableView == tableView) {
        if (self.tempArray.count > indexPath.row) {
            DryClearnShopServerObject* item = [self.tempArray objectAtIndex:indexPath.row];
            
            DryCleanShopServerDetailVC *vc = [[DryCleanShopServerDetailVC alloc] init];
            vc.item = item;
            vc.hiddenTabBar = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark----购物车数据处理
-(void)setCartArrWithItem:(DryClearnShopServerObject *)item
{
    BOOL isNew = YES;
    for (int i=0; i<_mShopCartArr.count; i++) {
        DryClearnShopServerObject *it = [_mShopCartArr objectAtIndex:i];
        if (it.iD == item.iD) {
            isNew = NO;
            if (item.count > 0) {
                it.count = item.count;
                [self.mShopCartArr replaceObjectAtIndex:i withObject:it];
                
                [self.mShopCarListView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                [self.mShopCartArr removeObjectAtIndex:i];
                
                if (self.mShopCartArr.count > 0)
                    [self.mShopCarListView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                else
                    [self.mShopCarListView reloadData];
            }
            break;
        }
    }
    
    if (isNew == YES) {
        [self.mShopCartArr addObject:item];
        
        [self.mShopCarListView reloadData];
    }
    
    [self upDatePage];
}

-(int)countFromCartDicWithId:(int)iD
{
    int count = 0;
    for (DryClearnShopServerObject *it in _mShopCartArr) {
        if (it.iD == iD) {
            count = it.count;
            break;
        }
    }
    return count;
}

-(int)totalCountFromCartArr
{
    int count = 0;
    for (DryClearnShopServerObject *it in _mShopCartArr)
        count += it.count;
    return count;
}


//-(void)setCartDicWithCount:(int)count iD:(int)iD
//{
//    NSString *key = StringWithInt(iD);
//    NSString *value = StringWithInt(count);
//    [self.mShopCarCountDic setObject:value forKey:key];
//    
//    [self upDatePage];
//}
//
//-(int)countFromCartDicWithId:(int)iD
//{
//    NSString *key = StringWithInt(iD);
//    NSString *value = [self.mShopCarCountDic objectWithKey:key];
//    if (value != nil)
//        return [value intValue];
//    return 0;
//}
//
//-(int)totalCountFromCartDic
//{
//    int count = 0;
//    NSArray *values = [self.mShopCarCountDic allValues];
//    for (NSString *valueStr in values) {
//        count +=  [valueStr intValue];
//    }
//    return count;
//}



#pragma mark----headerview和bottomview的代理方法
- (void)upDatePage{
    int count = [self totalCountFromCartArr];
    
    if (count <= 0) {
        mBottomView.mNum.hidden = YES;
        mBottomView.mGoPayBrn.enabled = NO;
    }else{
        mBottomView.mNum.hidden = NO;
        mBottomView.mGoPayBrn.enabled = YES;
        mBottomView.mNum.text = [NSString stringWithFormat:@"%i",count];
    }
    
}

#pragma mark----去结算的代理方法
- (void)WKFoodViewBottomGoPayCilicked{

    
}
#pragma mark----购物车的代理方法
- (void)WKFoodViewBottomShopCarCilicked{
    [self showShopList];
}

#pragma mark----cell减按钮和加按钮的代理方法
- (void)WKFoodShopCarCellWithJianAction:(NSInteger)mIndex indexPath:(NSIndexPath *)mIndexPath
{
    DryClearnShopServerObject* item = [self.mShopCartArr objectAtIndex:mIndexPath.row];
    item.count --;
    [self setCartArrWithItem:item];
    
    [self.tableView reloadData];
}

- (void)WKFoodShopCarCellWithAddAction:(NSInteger)mIndex indexPath:(NSIndexPath *)mIndexPath
{
    DryClearnShopServerObject* item = [self.mShopCartArr objectAtIndex:mIndexPath.row];
    item.count ++;
    [self setCartArrWithItem:item];
    
    [self.tableView reloadData];
}

#pragma mark----展现购物车view
- (void)initShopCarView{
    
    self.mShopCarBgkView = [UIView new];
    self.mShopCarBgkView.frame = CGRectMake(0, -50, DEVICE_Width, DEVICE_Height-50);
    self.mShopCarBgkView.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.75];
    self.mShopCarBgkView.alpha = 0;
    [self.view addSubview:self.mShopCarBgkView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.mShopCarBgkView addGestureRecognizer:tap];
    
    
    self.mShopCarListView = [UITableView new];
    
    self.mShopCarListView.frame = CGRectMake(0, self.mShopCarBgkView.mheight, DEVICE_Width, DEVICE_Height/2);
    
    self.mShopCarListView.delegate = self;
    self.mShopCarListView.dataSource = self;
    self.mShopCarListView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.mShopCarListView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    self.mShopCarListView.showsVerticalScrollIndicator = NO;
    self.mShopCarListView.showsHorizontalScrollIndicator = NO;
    UINib   *nib = [UINib nibWithNibName:@"mFoodShopCarCell" bundle:nil];
    [self.mShopCarListView registerNib:nib forCellReuseIdentifier:@"ClassGoodsTableViewCell3"];
    self.mShopCarListView.alpha = 0;
    [self.mShopCarBgkView addSubview:self.mShopCarListView];
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    
    [self hiddenShopList];
}
- (void)showShopList{
    [self.view bringSubviewToFront:self.mShopCarBgkView];
    [self.mShopCarListView reloadData];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.mShopCarBgkView.alpha = 1;
        self.mShopCarListView.alpha = 1;
        
        CGRect mSR = self.mShopCarListView.frame;
        mSR.origin.y = DEVICE_Height/2;
        self.mShopCarListView.frame = mSR;
    }];
}

- (void)hiddenShopList{
    [UIView animateWithDuration:0.25 animations:^{
        self.mShopCarBgkView.alpha = 0;
        self.mShopCarListView.alpha = 01;
        
        CGRect mSR = self.mShopCarListView.frame;
        mSR.origin.y = self.mShopCarBgkView.mheight;
        self.mShopCarListView.frame = mSR;
    }];
}
- (void)mClearAction:(UIButton *)sender{
    
    [self.mShopCartArr removeAllObjects];
    [self.mShopCarListView reloadData];
    [self.tableView reloadData];
    [self upDatePage];
    MLLog(@"清空购物车");
}


#pragma mark - BtnMethod

//收藏
-(void)rightBtnTouched:(id)sender
{
    //todo
    BOOL actionNext = _shopFocus > 0 ? NO : YES;
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[APIClient sharedClient] dryClearnShopCollectWithTag:self shopId:9 actionType:actionNext call:^(APIObject *info) {
        if (info.state == RESP_STATUS_YES) {
            self.shopFocus = actionNext ? 1 : 0;
            [self reloadShopFocusType];
            
            if (info.message.length > 0)
                [SVProgressHUD showSuccessWithStatus:info.message];
        } else {
            if (info.message.length > 0)
                [SVProgressHUD showErrorWithStatus:info.message];
        }
    }];
}

//显示购物车列表
-(void)showCartView:(id)sender
{
    
}


//去结算
-(void)goSubmmitMethod:(id)sender
{
    DryCleanOrderSubmitVC *vc = [[DryCleanOrderSubmitVC alloc] init];
    vc.hiddenTabBar = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


//去预约
-(void)goYudingMethod:(UIButton *)sender
{
    DryCleanShopServerDetailVC *vc = [[DryCleanShopServerDetailVC alloc] init];
    vc.hiddenTabBar = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//打电话
-(void)goCallTelMethod:(UIButton *)sender
{
    if (_shopItem.shopTel.length > 0) {
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_shopItem.shopTel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    } else
        [SVProgressHUD showErrorWithStatus:@"暂无电话"];
   
//    DryCleanOrderCommentSubmitVC *vc = [[DryCleanOrderCommentSubmitVC alloc] init];
//    vc.hiddenTabBar = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)goCommentMethod:(id)sender
{
    DryCleanOrderCommentTVC *vc = [[DryCleanOrderCommentTVC alloc] init];
    vc.hiddenTabBar = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
