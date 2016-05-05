//
//  mConversationViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mConversationViewController.h"

#import "mConversationCell.h"
#import <RongIMKit/RongIMKit.h>

#import "RCChatViewController.h"

@interface mConversationViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate,RCIMClientReceiveMessageDelegate,RCIMUserInfoDataSource,RCIMReceiveMessageDelegate>


@end

@implementation mConversationViewController
{
    WKSegmentControl    *mSegmentView;

    
    int mType;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"社区交流";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;

    mType = 1;
    
    [self initViuew];
}
- (void)initViuew{
    
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 64, DEVICE_Width, 40) andTitleWithBtn:@[@"我的小区",  @"附近的人"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:70 delegate:self andIsHiddenLine:NO];
    
    [self.view addSubview:mSegmentView];
    
    
    [self loadTableView:CGRectMake(0,mSegmentView.mbottom, DEVICE_Width, DEVICE_Height-mSegmentView.mbottom) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveFooter = YES;
    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"mConversationCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    /**
     *  这里要将lib的代理方法替换为kit的代理方法
     */
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showMsg) name:@"showMsg" object:nil];
    
    [RCIM sharedRCIM].userInfoDataSource = self;//这个代理设置到这里,这个VC一直存在,,,,


    
}
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    RCUserInfo*  tt = [[RCUserInfo alloc]initWithUserId:userId  name:[RCCInfo backRCCInfo].mRCCUserName portrait:[mUserInfo backNowUser].mUserImgUrl];
    completion( tt );

}

/**
 *  收到融云的消息
 *
 *  @param message <#message description#>
 *  @param nLeft   <#nLeft description#>
 *  @param object  <#object description#>
 */
- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left{
    [self showMsg];
    
}
-(void)showMsg
{
    UITabBarItem* it = self.tabBarController.viewControllers[3].tabBarItem;
    //收到消息,,,
    int allunread = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    if( allunread > 0 )
    {//如果有 没有读的消息
        it.badgeValue = [NSString stringWithFormat:@"%d",allunread];
    }
    else
    {
        it.badgeValue = nil;
    }
}


- (void)headerBeganRefresh{

    self.page = 1;
    
    
    if (mType == 1) {
        
        [RCCInfo getArearWithRcc:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
            [self headerEndRefresh];
            [self removeEmptyView];
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                
                if (mArr) {
                    [self.tempArray addObjectsFromArray:mArr];

                }else{
                
                    [self addEmptyViewWithImg:nil];
                }
                
                
                [self.tableView reloadData];
                
            }else{
                
                [self addEmptyView:nil];
            }
            
        }];

    }else{
   
        if (self.mLat == nil || [self.mLat isEqualToString:@""]) {
            self.mLat = @"";
        }
        if (self.mLng == nil || [self.mLng isEqualToString:@""]) {
            self.mLng = @"";
        }
        
        [RCCInfo getDistanceWith:self.page andNum:10 andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb, NSArray *mArr) {
            
            [self headerEndRefresh];
            [self removeEmptyView];
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                if (mArr) {
                    [self.tempArray addObjectsFromArray:mArr];
                    
                }else{
                    
                    [self addEmptyViewWithImg:nil];
                }
                
                [self.tableView reloadData];
                
            }else{
                
                [self addEmptyView:nil];
            }
            
            
            
        }];
        
    }
    
    
}
- (void)footetBeganRefresh{
    
    self.page ++;
    
    
    if (mType == 1) {
        [RCCInfo getArearWithRcc:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
            [self footetEndRefresh];
            [self removeEmptyView];
            if (resb.mSucess) {
                
                
                if (mArr) {
                    [self.tempArray addObjectsFromArray:mArr];
                    
                }else{
                    
                    [self addEmptyViewWithImg:nil];
                }
                [self.tableView reloadData];
                
            }else{
                
                [self addEmptyView:nil];
            }
            
        }];

    }else{
        [RCCInfo getDistanceWith:self.page andNum:10 andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb, NSArray *mArr) {
            [self footetEndRefresh];
            [self removeEmptyView];
            if (resb.mSucess) {
                
                
                if (mArr) {
                    [self.tempArray addObjectsFromArray:mArr];
                    
                }else{
                    
                    [self addEmptyViewWithImg:nil];
                }
                [self.tableView reloadData];
                
            }else{
                
                [self addEmptyView:nil];
            }
        }];
    }
    
    
    
}



- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    NSLog(@"点击了%lu",(unsigned long)mIndex);
    
    if (mIndex == 0) {
        mType = 1;
        
        
        
    }else{
        if (self.mLat == nil || [self.mLat isEqualToString:@""]) {
            [LCProgressHUD showFailure:@"打开定位才能查看附近的人！"];
            return;
        }
        if (self.mLng == nil || [self.mLng isEqualToString:@""]) {
            [LCProgressHUD showFailure:@"打开定位才能查看附近的人！"];
            return;
        }
        mType = 2;
    }

    [self headerBeganRefresh];

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
    
    return self.tempArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
        
    mConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    RCCUserInfo *mRccUser = self.tempArray[indexPath.row];
    
    [cell.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:mRccUser.portraitUri] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    cell.mName.text = mRccUser.userName;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    RCCUserInfo *mRccUser = self.tempArray[indexPath.row];
    
    __weak typeof(&*self)  weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        RCChatViewController *rcc = [[RCChatViewController alloc] init];
        
        rcc.conversationType = ConversationType_PRIVATE;
        
        rcc.targetId = mRccUser.userId;
        rcc.title = mRccUser.userName;

        UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
        [tabbarVC.navigationController  pushViewController:rcc animated:YES];
    });

    
    
}

@end
