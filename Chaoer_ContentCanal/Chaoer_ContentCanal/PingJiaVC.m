//
//  PingJiaVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "PingJiaVC.h"
#import "PingJiaCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PingJiaHeadView.h"
#import "PingjiaSectionView.h"
#import "wkOrderDetailViewController.h"
#import "ReplyView.h"
#import "UIImage+RTTint.h"
#import "orderDetail.h"

@interface PingJiaVC ()<UITableViewDataSource,UITableViewDelegate>{

    PingjiaSectionView *sectionView;
    
    UIButton *tempBT;
    int       nowSelect;
    
    NSMutableDictionary *tempDic;
    
    PingJiaHeadView *headView;
    
    UIView *replyBgView;
    ReplyView *replyView;
    
    SOrderRateInfo *tempRate;
    
}

@end

@implementation PingJiaVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.Title = self.mPageName = @"评价管理";
    self.tableView = _mTableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = M_BGCO;
    
    self.tableView.tableFooterView.frame = CGRectZero;
    
    nowSelect = 1;
    tempDic = [[NSMutableDictionary alloc] init];
    UINib *nib = [UINib nibWithNibName:@"PingJiaCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"pjcell"];
    
    headView = [PingJiaHeadView shareView];
    [self.tableView setTableHeaderView:headView];
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    sectionView = [PingjiaSectionView shareView];
    tempBT = sectionView.mAllBT;
    [sectionView.mAllBT addTarget:self action:@selector(SectionClick:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView.mNoReplyBT addTarget:self action:@selector(SectionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView headerBeginRefreshing];
    
    
    replyBgView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height)];
    [self.view addSubview:replyBgView];
    replyBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    replyView = [ReplyView shareView];
    replyView.layer.masksToBounds = YES;
    replyView.layer.cornerRadius = 5;
    replyView.mReply.placeholder = @"请认真回复，250字之内";
    CGRect rect = replyView.frame;
    rect.origin.x = 15;
    rect.origin.y = DEVICE_Height;
    rect.size.width = DEVICE_Width-30;
    rect.size.height = DEVICE_Width/320*232;
    replyView.frame = rect;
    [self.view addSubview:replyView];
    
    
    [replyView.mCancel addTarget:self action:@selector(CancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [replyView.mOK addTarget:self action:@selector(OKClick:) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)SectionClick:(UIButton *)sender{

    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender setBackgroundColor:M_CO];
    
    [tempBT setTitleColor:M_CO forState:UIControlStateNormal];
    [tempBT setBackgroundColor:[UIColor whiteColor]];
    
    tempBT = sender;
    
    nowSelect = (int)sender.tag -10;
    
    [self.tableView headerBeginRefreshing];
}

- (void)setXingXing:(CGFloat)score{
    
    
    for (UIImageView *i in headView.mXing.subviews) {
        [i removeFromSuperview];
    }
    
    NSString *string =  [NSString stringWithFormat:@"%.1f",score];
    
    NSRange range = [string rangeOfString:@"."];
    NSRange range2 = {0,range.location};
    NSRange range3 = {range.location+1,1};
    int z = [[string substringWithRange:range2] intValue];
    int f = [[string substringWithRange:range3] intValue];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *igv = [[UIImageView alloc] initWithFrame:CGRectMake(i*25, 0, 21, 21)];
        if (i<z) {
            igv.image = [UIImage imageNamed:@"hongxing"];
        }else{
            igv.image = [UIImage imageNamed:@"huixing"];
        }
        
        if (f > 0) {
            if (i == z) {
                
                float ff = (float)f;
                UIImage *image = [UIImage imageNamed:@"hongxing"];
                float j = ff/10*21;
                UIEdgeInsets e = UIEdgeInsetsMake(0, j, 0, 0);
                UIImage *tinted = [image rt_tintedImageWithColor:COLOR(184, 184, 184) insets:e];
                [igv setImage:tinted];
            }
        }
        
        [headView.mXing addSubview:igv];
    }
    
    
}

#pragma 评价
-(void)headerBeganRefresh
{
    self.page = 1;
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
   
    [SSeller getEvaList:self.page type:nowSelect block:^(SResBase *info,SEvaPack* evapack) {
        
        
        [self.tableView headerEndRefreshing];
        if( info.msuccess )
        {
            [SVProgressHUD dismiss];
            NSString *key2 = [NSString stringWithFormat:@"nowselectdata%d",nowSelect];
            
            [tempDic setObject:evapack.mEva forKey:key2];
            
            if (evapack.mEva.count==0) {
                [self addEmptyViewWithImg:nil];
            }else
            {
                [self removeEmptyView];
            }
            
            headView.mFen.text = [NSString stringWithFormat:@"%.1f",evapack.mScore];
            [self setXingXing:evapack.mScore];
            [sectionView.mAllBT setTitle:[NSString stringWithFormat:@"未回复(%d)",evapack.mUnReply] forState:UIControlStateNormal];
            [sectionView.mNoReplyBT setTitle:[NSString stringWithFormat:@"已回复(%d)",evapack.mReply] forState:UIControlStateNormal];
            
            [self.tableView reloadData];
        }
        else
        {
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:info.mmsg];
        }
        
    }];
    
}
-(void)footetBeganRefresh
{
    self.page++;
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [SSeller getEvaList:self.page type:nowSelect block:^(SResBase *info,SEvaPack* evapack){
        
        
        [self.tableView footerEndRefreshing];
        if( info.msuccess )
        {
            [SVProgressHUD dismiss];
            NSString *key2 = [NSString stringWithFormat:@"nowselectdata%d",nowSelect];
            
            NSArray *arr2 = [tempDic objectForKey:key2];
            
            if (evapack.mEva.count!=0) {
                [self removeEmptyView];
                
                
                NSMutableArray *array = [NSMutableArray array];
                if (arr2) {
                    [array addObjectsFromArray:arr2];
                }
                [array addObjectsFromArray:evapack.mEva];
                [tempDic setObject:array forKey:key2];
            }else
            {
                if(!evapack.mEva||evapack.mEva.count==0)
                {
                    [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
                }
                else
                    [SVProgressHUD showSuccessWithStatus:@"暂无新数据"];
                //   [self addEmptyView:@"暂无数据"];
                
            }
            
            [self.tableView reloadData];
            headView.mFen.text = [NSString stringWithFormat:@"%.1f",evapack.mScore];
            [self setXingXing:evapack.mScore];
            [sectionView.mAllBT setTitle:[NSString stringWithFormat:@"未回复(%d)",evapack.mUnReply] forState:UIControlStateNormal];
            [sectionView.mNoReplyBT setTitle:[NSString stringWithFormat:@"已回复(%d)",evapack.mReply] forState:UIControlStateNormal];
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:info.mmsg];
        }
    }];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key2 = [NSString stringWithFormat:@"nowselectdata%d",nowSelect];
    
    NSArray *arr = [tempDic objectForKey:key2];
    
    return [arr count];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 65;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PingJiaCell *cell = (PingJiaCell *)[tableView dequeueReusableCellWithIdentifier:@"pjcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSString *key2 = [NSString stringWithFormat:@"nowselectdata%d",nowSelect];
    NSArray *arr = [tempDic objectForKey:key2];
    
    SOrderRateInfo *rate = [arr objectAtIndex:indexPath.row];
    
    [self initPingJiaCell:cell andRate:rate];
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

char* g_asskey = "g_asskey";
- (void)initPingJiaCell:(PingJiaCell *)cell andRate:(SOrderRateInfo *)rate{
    
    cell.mName.text = rate.mUserName;
    cell.mTime.text = rate.mCreateTime;
    cell.mStarImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"xing_%d",rate.mStar]];
    cell.mContent.text = rate.mContent;
    cell.mReply.text = [NSString stringWithFormat:@"回复：%@",rate.mReply];
    
    if (rate.mReply == nil || [rate.mReply isEqualToString:@""]) {
        cell.mReplyView.hidden = YES;
        cell.mReplyBT.hidden = NO;
    }else{
        cell.mReplyView.hidden = NO;
        cell.mReplyBT.hidden = YES;
    }
    cell.mOrderBT.rate = rate;
    cell.mReplyBT.rate = rate;
    [cell.mOrderBT addTarget:self action:@selector(goOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.mReplyBT addTarget:self action:@selector(goReplyClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if( rate.mImages.count > 0 )
    {
        cell.mImgBgView.hidden = NO;
        if (rate.mImages.count>4) {
            cell.mImgViewHeight.constant = 110;
        }else{
            cell.mImgViewHeight.constant = 40;
        }
        
        for ( int  j = 0 ; j < 8; j++) {
            
            UIImageView * oneimg = (UIImageView *)[cell.mImgBgView viewWithTag:j+1];
            oneimg.image = nil;
            
            if (j < rate.mImages.count) {
                
                NSString* oneurl = rate.mImages[j];
                
                [oneimg sd_setImageWithURL:[NSURL URLWithString:oneurl] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
                
                if( !oneimg.userInteractionEnabled )
                {
                    oneimg.userInteractionEnabled  = YES;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
                    [oneimg addGestureRecognizer:tap];
                }
                
                objc_setAssociatedObject(oneimg, g_asskey, nil, OBJC_ASSOCIATION_ASSIGN);
                objc_setAssociatedObject(oneimg, g_asskey, rate, OBJC_ASSOCIATION_ASSIGN);
            }
            
        }
        
    }else{
        
        cell.mImgViewHeight.constant = 0;
        cell.mImgBgView.hidden = YES;
    }
    
}

- (void)goOrderClick:(MyTempButton *)sender{

    orderDetail *order = [[orderDetail alloc] initWithNibName:@"orderDetail" bundle:nil];
    SOrder *s = [[SOrder alloc] init];
    s.mId = sender.rate.mOrderId;
    order.mtagOrder = s;
    [self pushViewController:order];
}

- (void)goReplyClick:(MyTempButton *)sender{
    
    replyBgView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    [UIView animateWithDuration:0.2 animations:^{
        
        replyView.center = replyBgView.center;
        CGRect rect2 = replyView.frame;
        replyView.frame = rect2;

        
    }];
    
    tempRate = sender.rate;
    
}

- (void)CancelClick:(UIButton *)sender{
    
    replyView.mReply.text = @"";
    replyBgView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height);
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect2 = replyView.frame;
        rect2.origin.y = DEVICE_Height;
        replyView.frame = rect2;
    
    }];
}

- (void)OKClick:(UIButton *)sender{
    
    if (replyView.mReply.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"回复内容不能为空"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
    
    [tempRate replayThis:replyView.mReply.text block:^(SResBase *resb) {
        
        if (resb.msuccess) {
            [SVProgressHUD showSuccessWithStatus:@"回复成功"];
            
            replyView.mReply.text = @"";
            replyBgView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height);
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect2 = replyView.frame;
                rect2.origin.y = DEVICE_Height;
                replyView.frame = rect2;
                
                [self.tableView headerBeginRefreshing];
            }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
    }];

}

-(void)imageClick:(UITapGestureRecognizer*)sender
{
    UIImageView* tagv = (UIImageView*)sender.view;
    
    SOrderRateInfo *rate = objc_getAssociatedObject(tagv, g_asskey);
    NSMutableArray* allimgs = NSMutableArray.new;
    for ( NSString* url in rate.mImages )
    {
        MJPhoto* onemj = [[MJPhoto alloc]init];
        onemj.url = [NSURL URLWithString:url ];
        onemj.srcImageView = tagv;
        [allimgs addObject: onemj];
    }
    
    MJPhotoBrowser* browser = [[MJPhotoBrowser alloc]init];
    browser.currentPhotoIndex = tagv.tag-1;
    browser.photos  = allimgs;
    [browser show];
    
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

@end
