//
//  MyViewController.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/6/18.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "MyViewController.h"
#import "myMessageViewController.h"
#import "mMyDetailViewController.h"
#import "myMoneyViewController.h"
#import "WebVC.h"
#import "moreCell.h"
#import "footView.h"
#import "setupViewController.h"
#import "tongjiViewController.h"
#import "leaveViewController.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyViewController{

    
    
    UITableView *mTableView;
    
    footView    *mHeaderView;
    footView    *mFootView;

    BOOL    mHaveMsg;
    int     mMsgNum;
    NSMutableArray* _alldata;

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    [self makeData];
    
    [self.tableView reloadData];
    [self getData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = @"我的";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = YES;
    [self initView];

}
#pragma mark----构造主页面
- (void)initView{


    mTableView = [UITableView new];
    [self.view addSubview:mTableView];
    
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    
    
    self.tableView = mTableView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = M_BGCO;
    UINib *nib = [UINib nibWithNibName:@"moreCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 55)];
    UILabel *kf = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, DEVICE_Width, 20)];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"客户服务热线：%@",[GInfo shareClient].mServiceTel]];
    NSRange contentRange = {7, [content length]-7};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    kf.attributedText = content;
    
    kf.textColor = M_TCO;
    kf.textAlignment = NSTextAlignmentCenter;
    kf.font = [UIFont systemFontOfSize:13];
    [footView addSubview:kf];
    kf.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CallClick:)];
    [kf addGestureRecognizer:tap];
    
    [self.tableView setTableFooterView:footView];

}

- (void)getData{
    [SMessageInfo isHaveMessage:^(SResBase *resb) {
        if (resb.msuccess) {
            mMsgNum = [[resb.mdata objectForKey:@"newMsgCount"] intValue];

        }else{
            mMsgNum = 0;
        }
    }];

}
-(void)makeData
{
    [_alldata removeAllObjects];
    
    _alldata = NSMutableArray.new;
    

    if( [[SUser currentUser] isSender] || [[SUser currentUser] isServicer]  )
    {
        NSMutableArray*  t = NSMutableArray.new;
        
        [t addObject: @[@"我的佣金",@"money",@(1)] ];
        [t addObject: @[@"业务统计",@"totle",@(2)] ];
        [t addObject: @[@"请假",@"leave",@(3)] ];
        [_alldata addObject:t];
    }
    
    NSMutableArray*  tt = NSMutableArray.new;
    [tt addObject: @[@"消息通知",@"meassage",@(4)] ];
    [tt addObject: @[@"使用帮助",@"help",@(5)] ];
    [_alldata addObject: tt ];
    
    
    NSMutableArray*  ttt = NSMutableArray.new;
    [ttt addObject: @[@"设置",@"setup",@(6)] ];
    [_alldata addObject: ttt ];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return     _alldata.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* t = _alldata[section];
    return t.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = @"cell";
    
    moreCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    if (!cell)
    {
        cell = [[moreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSArray* t = _alldata[indexPath.section];
    t = t[indexPath.row];
    
    cell.mTitle.text = t[0];
    cell.mPoint.hidden = YES;
    cell.mImg.image = [UIImage imageNamed:t[1]];
    
    if( [cell.mTitle.text isEqualToString:@"消息通知"] )
    {
        if (mMsgNum<=0) {
            cell.mPoint.hidden = YES;
            
        }else{
            cell.mPoint.hidden = NO;
        }
    }
    else
    {
        cell.mTitle.text = t[0];
        cell.mImg.image = [UIImage imageNamed:t[1]];
        cell.mPoint.hidden = YES;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray* t = _alldata[indexPath.section];
    t = t[indexPath.row];
    
    int  i = [t[2] intValue];
    switch (i) {
        case 1:
        {
            UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            myMoneyViewController *ttt =[secondStroyBoard instantiateViewControllerWithIdentifier:@"money"];
            [self.navigationController pushViewController:ttt animated:YES];
        }
            break;
        case 2:
        {
            UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            tongjiViewController *ttt =[secondStroyBoard instantiateViewControllerWithIdentifier:@"tongji"];
            [self.navigationController pushViewController:ttt animated:YES];
        }
            break;
        case 3:
        {
            UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            leaveViewController *lll =[secondStroyBoard instantiateViewControllerWithIdentifier:@"leave"];
            [self.navigationController pushViewController:lll animated:YES];
        }
            break;
        case 4:
        {
            myMessageViewController *m = [myMessageViewController new];
            [self pushViewController:m];
        }
            break;
        case 5:
        {
            MLLog(@"帮助");
            WebVC *w = [WebVC new];
            w.mName = @"使用帮助";
            w.mUrl = [GInfo shareClient].mHelpUrl;
            MLLog(@"使用帮助：%@",[GInfo shareClient].mHelpUrl);
            [self pushViewController:w];

        }
            break;
        case 6:
        {
            
            UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            setupViewController *ttt =[secondStroyBoard instantiateViewControllerWithIdentifier:@"setup"];
            [self.navigationController pushViewController:ttt animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 240;

    }else{
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        mHeaderView = [footView shareHeaderView];
        mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 240);
        mHeaderView.mBigBgkImg.backgroundColor = M_CO;
        [mHeaderView.mEditBtn addTarget:self action:@selector(mEditAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([SUser isNeedLogin]) {
            mHeaderView.mUserName.text = nil;
            mHeaderView.mHeaderImg.image = [UIImage imageNamed:@"my_defaulimg"];
            
        }
        else{
            
            [mHeaderView.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:[SUser currentUser].mHeadImgURL] placeholderImage:[UIImage imageNamed:@"my_defaulimg"]];
            MLLog(@"头像地址：%@",[SUser currentUser].mHeadImgURL);
            mHeaderView.mUserName.text = [NSString stringWithFormat:@"%@ >",[SUser currentUser].mUserName];
            
        }
        
        return mHeaderView;
    }
    else{
        UIView *vvv = [UIView new];
        vvv.frame = CGRectMake(0, 0, 100, 20);
        vvv.backgroundColor = [UIColor clearColor];
        return vvv;
    }

}

- (void)mEditAction:(UIButton *)sender{
    mMyDetailViewController *m = [mMyDetailViewController new];
    [self pushViewController:m];
}
- (void)CallClick:(UITapGestureRecognizer *)sender{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[GInfo shareClient].mServiceTel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
