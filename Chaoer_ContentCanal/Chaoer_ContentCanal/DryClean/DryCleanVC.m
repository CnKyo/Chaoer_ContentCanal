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
#import "ShopCommentTVC.h"
#import "DryCleanShopServerDetailVC.h"
#import "DryCleanOrderCommitSubmitVC.h"
#import "DryCleanServerTableViewCell.h"
#import "DryCleanOrderSubmitVC.h"
#import "RateView.h"


@interface DryCleanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UISegmentedControl *segControl;
@property(nonatomic,strong) UIScrollView*       scrollView;
@property(nonatomic,strong) UIView*             scrollContentView;

@property(nonatomic,strong) UIView*         segSelect1View; //当选择商家分类时，组装的总view
@property(nonatomic,strong) UITableView*    classTableView;
@property(nonatomic,strong) NSMutableArray* classArr;
@property(nonatomic,assign) NSInteger       classIndex; //选择哪一种类别
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
    
    
    self.page = 1;
    
    [self initView];
    
    self.segControl.selectedSegmentIndex = 0;
    [self loadSegSelectIndex:0];
    

    self.classArr = [NSMutableArray arrayWithObjects:@"分类1",@"分类2",@"分类3",@"分类4",@"分类5", nil];
    
    [self selectClassIndex:0];
    
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
        
        UIView *aView = ({
            UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
            UILabel *nameLable = [view newUILableWithText:@"超尔干洗店" textColor:[UIColor blackColor] font:font1];
//            RateView *bar = [RateView rateViewWithRating:3.7f];
//            bar.backgroundColor = [UIColor redColor];
//            bar.rating = 4.0f;
            RatingBarView *bar = [[RatingBarView alloc] initWithHight:20];
            [view addSubview:bar];
            UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(goYudingMethod:) title:@"去预约" titleColor:[UIColor whiteColor] titleFont:font1];
            [btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.518 green:0.745 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
            [nameLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.left).offset(padding);
                make.top.equalTo(view.top).offset(padding/2);
                make.height.equalTo(25);
            }];
            [bar makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(nameLable.mas_left);
                make.top.equalTo(nameLable.mas_bottom);
                make.height.equalTo(40);
                make.width.equalTo(200);
            }];
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(nameLable.mas_right).offset(padding/2);
                make.centerY.equalTo(nameLable.mas_bottom);
                make.right.equalTo(view.mas_right).offset(-padding);
                make.width.equalTo(80);
                make.height.equalTo(35);
            }];
            [view makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(nameLable.bottom).offset(30);
            }];
            view;
        });
        UIView *lineView1 = [contentView newDefaultLineView];
        UIView *bView = ({
            UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
            UIImageView *iconImgView = [view newUIImageViewWithImg:IMG(@"dryClean_address.png")];
            UILabel *addressLable = [view newUILableWithText:@"重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎重庆龙虎" textColor:[UIColor colorWithRed:0.439 green:0.443 blue:0.447 alpha:1.000] font:font2];
            addressLable.numberOfLines = 0;
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
        UIView *cView = ({
            UIView *view = [contentView newUIViewWithBgColor:[UIColor whiteColor]];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goCommentMethod:)];
            [view addGestureRecognizer:tapGesture];
            RatingBarView *bar = [[RatingBarView alloc] initWithHight:25];
            [view addSubview:bar];
            UILabel *countLable = [view newUILableWithText:@"100人评价" textColor:[UIColor grayColor] font:font2 textAlignment:QU_TextAlignmentRight];
            UIImageView *iconImgView = [view newUIImageViewWithImg:IMG(@"jiantou1.png")];
            [bar makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(padding);
                make.top.equalTo(view.mas_top).offset(padding/2);
            }];
            [iconImgView makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view.mas_right).offset(-padding);
                make.centerY.equalTo(view.mas_centerY);
                make.width.equalTo(7);
                make.height.equalTo(13);
            }];
            [countLable makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bar.mas_right).offset(padding/2);
                make.right.equalTo(iconImgView.mas_left).offset(-padding/2);
                make.top.bottom.equalTo(view);
            }];
            view;
        });
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
        [cView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(bView.mas_bottom).offset(padding);
            make.height.equalTo(40);
        }];
        [dView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(cView.mas_bottom).offset(padding);
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
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.segSelect1View addSubview:self.tableView];
    

    
    UIView *cartView = ({
        UIView *view = [self.segSelect1View newUIViewWithBgColor:[UIColor colorWithRed:0.910 green:0.918 blue:0.922 alpha:1.000]];
        UIButton *cartBtn = [view newUIButtonWithTarget:self mehotd:@selector(showCartView:) bgImgNormal:IMG(@"dryClean_cart_gray.png")];
        UILabel *priceLable = [view newUILableWithText:@"￥10" textColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000] font:[UIFont systemFontOfSize:18]];
        UIView *lineView = [view newUIViewWithBgColor:[UIColor colorWithRed:0.808 green:0.812 blue:0.816 alpha:1.000]];
        UILabel *noteLable = [view newUILableWithText:@"取衣费：2元" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13]];
        UIButton *submmitBtn = [view newUIButtonWithTarget:self mehotd:@selector(goSubmmitMethod:) title:@"去结算" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:18]];
        [submmitBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
        [cartBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.top.equalTo(view.top).offset(padding/2);
            make.bottom.equalTo(view.bottom).offset(-padding/2);
            make.width.equalTo(cartBtn.mas_height);
        }];
        [priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cartBtn.right).offset(padding/2);
            make.top.bottom.equalTo(cartBtn);
        }];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceLable.right).offset(padding);
            make.height.equalTo(view.mas_height).multipliedBy(0.6);
            make.width.equalTo(OnePixNumber);
            make.centerY.equalTo(view.centerY);
        }];
        [noteLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView.right).offset(padding);
            make.top.bottom.equalTo(cartBtn);
            make.right.lessThanOrEqualTo(submmitBtn.left).offset(-padding/2);
        }];
        [submmitBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(view);
            make.width.equalTo(submmitBtn.mas_height).multipliedBy(1.5);
        }];
        view;
    });
    [cartView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.segSelect1View);
        make.height.equalTo(cartView.mas_width).multipliedBy(0.15);
    }];
    
    [self.classTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.segSelect1View);
        make.bottom.equalTo(cartView.top);
        make.width.equalTo(classTableViewWidth);
    }];
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_classTableView.mas_right);
        make.top.bottom.equalTo(_classTableView);
        make.right.equalTo(self.segSelect1View.right);
    }];
    
    self.haveHeader = YES;
    self.haveFooter = YES;
}

-(void)loadSegSelectIndex:(NSInteger)index
{
    if (index == 0) {
        [self.view bringSubviewToFront:self.scrollView];
        self.scrollView.hidden = NO;
        self.segSelect1View.hidden = YES;
    } else {
        [self.view bringSubviewToFront:self.segSelect1View];
        self.scrollView.hidden = YES;
        self.segSelect1View.hidden = NO;
    }
}

-(void)segControlChange:(id)sender
{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    [self loadSegSelectIndex:control.selectedSegmentIndex];
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
    [[APIClient sharedClient] cookCategoryQueryWithTag:self call:^(CookCategoryObject *item, APIObject *info) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        
        for (int i=0; i<10; i++) {
            [self.tempArray addObject:@"111"];
        }
        
        if (info.retCode == RETCODE_SUCCESS) {
            if (item == nil) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } else {
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:info.msg];
        }
    }];
}


#pragma mark -- tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _classTableView) {
        if (_classArr.count > 0)
            return _classArr.count;
    } else if (tableView == self.tableView) {
        if (self.tempArray.count > 0)
            return self.tempArray.count;
    }
    return 0;
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
            int padding = 10;
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
        UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:10];
        UILabel *lable = (UILabel *)[cell.contentView viewWithTag:11];
        if (_classIndex == indexPath.row) {
            lable.textColor = [UIColor colorWithRed:0.518 green:0.745 blue:0.129 alpha:1.000];
            lable.backgroundColor = COLOR_NavBar;
        } else {
            lable.textColor = [UIColor grayColor];
            lable.backgroundColor = [UIColor whiteColor];
        }
        
        id obj = [self.classArr objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[NSString class]]) {
            lable.text = obj;
        }
        
        return cell;
        
        
    } else {
        static NSString *CellIdentifier = @"ClassGoodsTableViewCell2";
        DryCleanServerTableViewCell *cell = (DryCleanServerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell= [[DryCleanServerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            //cell.backgroundColor = [UIColor clearColor];
        }
        cell.nameLable.text = @"标题11111";
        cell.priceLable.text = @"￥100";
        cell.countLable.text = @"1";
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView ) {
        return 80;
    }
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_classTableView == tableView) {
        [self selectClassIndex:indexPath.row];
        
    } else {

    }
}




#pragma mark - BtnMethod

//收藏
-(void)rightBtnTouched:(id)sender
{
    //todo
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
    DryCleanOrderCommitSubmitVC *vc = [[DryCleanOrderCommitSubmitVC alloc] init];
    vc.hiddenTabBar = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)goCommentMethod:(id)sender
{
    ShopCommentTVC *vc = [[ShopCommentTVC alloc] init];
    vc.hiddenTabBar = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
