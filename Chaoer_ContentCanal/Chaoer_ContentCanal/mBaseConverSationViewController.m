//
//  mBaseConverSationViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mBaseConverSationViewController.h"
#import "mConversationCell.h"
#import <RongIMKit/RongIMKit.h>

#import "RCChatViewController.h"

#import "mConversationViewController.h"
#import "mListViewController.h"
#import "homeNavView.h"

@interface mBaseConverSationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation mBaseConverSationViewController
{

    NSArray *mTT;
    NSArray *mImg;

    homeNavView *mNavView;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //设置聊天界面的颜色,风格
    UIFont *font = [UIFont systemFontOfSize:19.f];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : font,
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:M_CO];
    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavImg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:M_CO];
    
    self.navigationController.navigationBarHidden = YES;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"邻里圈";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.navBar.hidden = NO;
    [self initViuew];
}
- (void)initViuew{
    mNavView = [homeNavView shareChatNav];
    //    mNavView.frame = CGRectMake(0, 0, DEVICE_Width, 64);
    [mNavView.mBackBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mNavView];
    [mNavView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).offset(0);
        make.height.offset(@64);
    }];
    mTT = @[@"聊天室",@"邻里圈"];
    mImg = @[[UIImage imageNamed:@"chat_room"],[UIImage imageNamed:@"near_room"]];
    [self loadTableView:CGRectMake(0,64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    
    UINib   *nib = [UINib nibWithNibName:@"mChatCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
 
}
- (void)leftAction:(UIButton *)sender{
    [self popViewController];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return mTT.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    mConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    cell.mHeaderImg.image = mImg[indexPath.row];
    cell.mName.text = mTT[indexPath.row];
    
    cell.mDistance.hidden = YES;
    cell.mBage.hidden = YES;

    if (indexPath.row == 0) {
        int allunread = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
        if( allunread > 0 )
        {//如果有 没有读的消息
            cell.mBage.hidden = NO;

            cell.mBage.text = [NSString stringWithFormat:@"%d",allunread];
        }
        else
        {
            cell.mBage.hidden = YES;

        }

    }
 
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.row) {
        case 0:
        {
        
            __weak typeof(&*self)  weakSelf = self;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                mListViewController *rcc = [[mListViewController alloc] init];
                
                
                UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
                [tabbarVC.navigationController  pushViewController:rcc animated:YES];
            });

        }
            break;
        case 1:{
        
            mConversationViewController *ccc = [[mConversationViewController alloc] initWithNibName:@"mConversationViewController" bundle:nil];
            ccc.mLat = self.mLat;
            ccc.mLng = self.mLng;
            [self pushViewController:ccc];

        }
            
            break;

            
        default:
            break;
    }
    
    
}

@end
