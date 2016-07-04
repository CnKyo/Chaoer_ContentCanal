//
//  pptMyAddressViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptMyAddressViewController.h"
#import "pptMyAddressCell.h"

#import "pptAddAddressViewController.h"
@interface pptMyAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation pptMyAddressViewController
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self headerBeganRefresh];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"我的地址";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"添加";

    [self initView];
}
- (void)initView{
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"pptMyAddressCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
}
- (void)headerBeganRefresh{

    [[mUserInfo backNowUser] getPPTaddressList:^(mBaseData *resb, NSArray *mArr) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        if (resb.mSucess) {
            
            if (mArr.count<=0) {
                [self addEmptyView:nil];
            }else{
                [self.tempArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }
            
        
        }else{
            
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
         
            
        }
    }];
    
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
    
    return 70;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    GPPTaddress *mAddress = self.tempArray[indexPath.row];
    
    pptMyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    cell.mAddress.text = [NSString stringWithFormat:@"%@%@",mAddress.mAddress,mAddress.mDetailsAddr];
    cell.mContent.text = [NSString stringWithFormat:@"%@-%@",mAddress.mUserName,mAddress.mPhone];
    
    if (mAddress.mAddressName.length != 0) {
        cell.mTag.text = mAddress.mAddressName;
        cell.mTag.hidden = NO;
        cell.mDetailLeft.constant = 15;

    }else{
    
        cell.mTag.hidden = YES;
        cell.mDetailLeft.constant = -40;
    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GPPTaddress *mAddress = self.tempArray[indexPath.row];
    if (self.mType == 1) {
        self.block([NSString stringWithFormat:@"%@%@",mAddress.mAddress,mAddress.mDetailsAddr],[NSString stringWithFormat:@"%d",mAddress.mId]);
        [self popViewController];
    }else{
    
    }
    
    
}

- (void)rightBtnTouched:(id)sender{
    pptAddAddressViewController *ppp = [[pptAddAddressViewController alloc] initWithNibName:@"pptAddAddressViewController" bundle:nil];
    [self pushViewController:ppp];
    
}
@end
