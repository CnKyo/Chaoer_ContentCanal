//
//  pptOrderDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptOrderDetailViewController.h"
#import "pptDetailCell.h"
@interface pptOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation pptOrderDetailViewController
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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.Title = self.mPageName = @"跑单详情";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    self.rightBtnImage = [UIImage imageNamed:@"right_phone"];
    
    [self initView];

}
- (void)initView{
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"pptDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    nib = [UINib nibWithNibName:@"pptDetailCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    nib = [UINib nibWithNibName:@"pptDetailCell3" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    nib = [UINib nibWithNibName:@"pptDetailCell4" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell4"];
    nib = [UINib nibWithNibName:@"pptDetailCell5" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell5"];
}


- (void)headerBeganRefresh{

    
    if (self.mOrderType == 1) {
        [[mUserInfo backNowUser] getOrderDetail:self.mType andMorderID:[NSString stringWithFormat:@"%d",self.mOrder.mId] andOrderCode:self.mOrder.mOrderCode block:^(mBaseData *resb, GPPTOrder *mOrder) {
            
            [self headerEndRefresh];
            [self addEmptyView:nil];
            
            if (resb.mSucess) {
                
                self.mOrder = mOrder;
                [self.tableView reloadData];
                
            }else{
                [self showErrorStatus:resb.mMessage];
                [self addEmptyView:nil];
                [self popViewController];
            }
            
        }];
    }else{
        [[mUserInfo backNowUser] getOrderDetail:self.mType andMorderID:[NSString stringWithFormat:@"%d",self.mOrder.mId] andOrderCode:self.mOrder.mOrderCode block:^(mBaseData *resb, GPPTOrder *mOrder) {
            
            [self headerEndRefresh];
            [self addEmptyView:nil];
            
            if (resb.mSucess) {
                
                self.mOrder = mOrder;
                [self.tableView reloadData];
                
            }else{
                [self showErrorStatus:resb.mMessage];
                [self addEmptyView:nil];
                [self popViewController];
            }
            
        }];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.mOrderType == 1) {
        if (self.mType == 1) {
            return 700;
        }else{
            return 770;
        }
    }else{
        if (self.mType == 1) {
            return 770;
        }else if(self.mType == 3){
            return 333;
        }else{
            return 820;

        }
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;
    if (self.mOrderType == 1) {
        if (self.mType == 1) {
            reuseCellId = @"cell";
            
        }else{
            reuseCellId = @"cell2";
            
        }
    }else{
        if (self.mType == 1) {
            reuseCellId = @"cell3";
            
        }else if(self.mType == 3){
            reuseCellId = @"cell5";
            
        }else{
            reuseCellId = @"cell4";
        }

    }
    
    pptDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    
    
    return cell;
    
}

@end
