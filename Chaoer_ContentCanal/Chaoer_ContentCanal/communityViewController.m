//
//  communityViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityViewController.h"

#import "mAddressView.h"

#import "communityTableViewCell.h"


#import "mSuperMarketViewController.h"

#import "shopViewController.h"
#import "washAndSendViewController.h"
@interface communityViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation communityViewController
{
    mAddressView *mTopView;
    
    UITableView *mTableView;
    
    UIView *mHeaderView;
    

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"社区服务";
    [self initView];
}
- (void)initView{
    
    
    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor whiteColor];
    mTableView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    mTableView.delegate = self;
    mTableView.dataSource = self;
//    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    
    
    UINib   *nib = [UINib nibWithNibName:@"communityTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self initHeaderView];
    
}
- (void)initHeaderView{

    mHeaderView = [UIView new];
    mHeaderView.frame = CGRectZero;
    mHeaderView.backgroundColor = [UIColor whiteColor];
    
    
    mTopView = [mAddressView shareView];
    mTopView.frame  =CGRectMake(0, 0, DEVICE_Width, 50);
    [mHeaderView addSubview:mTopView];
    
    NSArray *marr = @[@"超市快递",@"水果生鲜",@"美食速递",@"招募合伙人",@"饮水配送",@"衣服洗涤"];
    
    float x = 0;
    float y = mTopView.mbottom;
    
    float btnWidth = DEVICE_Width/3;
    
    for (int i = 0; i<marr.count; i++) {
        
        UIButton    *btn = [UIButton new];
        btn.frame = CGRectMake(x, y, btnWidth, 110);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:@"79"] forState:0];
        [btn setTitle:marr[i] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1] forState:0];
        btn.imageEdgeInsets  = UIEdgeInsetsMake(-20, 24, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(90, -50, 20, 0);
        
        [btn setBackgroundColor:[UIColor whiteColor] forUIControlState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor] forUIControlState:UIControlStateSelected];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(mCusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [mHeaderView addSubview:btn];
        
        x += btnWidth;
        
        if (x >= DEVICE_Width) {
            x = 0;
            y += 110;
        }
        
        
    }
    
    CGRect  mRect = mHeaderView.frame;
    mRect.size.height = y;
    mHeaderView.frame = mRect;
    
    [mTableView setTableHeaderView:mHeaderView];


    
}
#pragma mark----按钮的点击事件
- (void)mCusBtnAction:(UIButton *)sender{
    NSLog(@"第%ld个",(long)sender.tag);
    
    switch (sender.tag) {
        case 0:
        {
            mSuperMarketViewController *mmm = [mSuperMarketViewController new];
            [self pushViewController:mmm];
        }
            break;
        case 4:
        {
            washAndSendViewController *www = [[washAndSendViewController alloc] initWithNibName:@"washAndSendViewController" bundle:nil];
            www.mTitle = @"送水";
            [self pushViewController:www];
        }
            break;
        case 5:
        {
            washAndSendViewController *www = [[washAndSendViewController alloc] initWithNibName:@"washAndSendViewController" bundle:nil];
            www.mTitle = @"洗衣";
            [self pushViewController:www];
        }
            break;
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vvv = [UIView new];
    vvv.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    vvv.frame = CGRectMake(0, 0, DEVICE_Width, 40);
    vvv.layer.masksToBounds = YES;
    vvv.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.88 alpha:1].CGColor;
    vvv.layer.borderWidth = 1;
    
    UILabel *lll = [UILabel new];
    lll.text = @"附近商家";
    lll.frame = CGRectMake(20,15, 200, 20);
    lll.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    lll.textAlignment = NSTextAlignmentLeft;
    lll.font = [UIFont systemFontOfSize:15];
    [vvv addSubview:lll];
    
    return vvv;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    shopViewController *sss = [[shopViewController alloc] initWithNibName:@"shopViewController" bundle:nil];
    sss.mTitle = @"沃尔玛";
    [self pushViewController:sss];
    
}

@end
