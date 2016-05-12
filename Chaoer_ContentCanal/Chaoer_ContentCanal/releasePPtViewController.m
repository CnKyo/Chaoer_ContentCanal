
//
//  releasePPtViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "releasePPtViewController.h"

#import "releaseCell.h"
#import "BlockButton.h"
@interface releasePPtViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation releasePPtViewController

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
    self.Title = self.mPageName = @"发布跑腿";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    
    [self initView];
    
    UIView *mBottomView = [UIView new];
    mBottomView.frame = CGRectMake(0, DEVICE_Height-60, DEVICE_Width, 60);
    mBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mBottomView];
    
    BlockButton *mBtn = [BlockButton new];
    mBtn.frame = CGRectMake(15, 10, DEVICE_Width-30, 40);
    mBtn.layer.masksToBounds = YES;
    mBtn.layer.cornerRadius = 3;
    mBtn.backgroundColor = M_CO;
    [mBtn setTitle:@"发布" forState:0];
    [mBtn setTitleColor:[UIColor whiteColor] forState:0];
    [mBtn btnClick:^{
        
        NSLog(@"发布");
        
    }];
    [mBottomView addSubview:mBtn];
}

- (void)initView{
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.haveHeader = YES;
//    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"releaseCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    nib = [UINib nibWithNibName:@"releaseCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    nib = [UINib nibWithNibName:@"releaseCell3" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    nib = [UINib nibWithNibName:@"releaseCell4" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell4"];
    
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
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.mType == 1) {
        
        if (indexPath.row == 0) {
            
            
            return 210;
        }else if (indexPath.row == 1){
            
            
            return 110;
        }else{
            
            
            return 215;
        }
        
        
    }else if (self.mType == 2)
    {
        
        if (indexPath.row == 0) {
            
            
            return 210;
        }else if (indexPath.row == 1){
            
            
            return 50;
        }else{
            
            
            return 215;
        }
        
    }else{
        
        if (indexPath.row == 0) {
            
            
            return 210;
        }else if (indexPath.row == 1){
            
            
            return 110;
        }else{
            
            
            return 215;
        }
        
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;

    if (self.mType == 1) {
        
        if (indexPath.row == 0) {
            
            reuseCellId = @"cell";

            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else if (indexPath.row == 1){
            reuseCellId = @"cell2";

            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else{
            reuseCellId = @"cell4";

            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
        
        
    }else if (self.mType == 2)
    {
        if (indexPath.row == 0) {
            reuseCellId = @"cell";

            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else if (indexPath.row == 1){
            reuseCellId = @"cell3";

            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else{
            reuseCellId = @"cell4";

            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }

    }else{
        if (indexPath.row == 0) {
            
            reuseCellId = @"cell";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else if (indexPath.row == 1){
            reuseCellId = @"cell2";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else{
            reuseCellId = @"cell4";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }

    }
    
    
    

    
}

@end
