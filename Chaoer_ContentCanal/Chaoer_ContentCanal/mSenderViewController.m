//
//  mSenderViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mSenderViewController.h"
#import "mAddressView.h"
#import "senderTableViewCell.h"


#import "senderDetailViewController.h"

#import "evolutionViewController.h"
@interface mSenderViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate>

@end

@implementation mSenderViewController
{
    mAddressView *mTopView;

    AMapLocationManager *mLocation;
    
    int     mType;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"跑跑腿";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    mType =0;
    
    [self initView];
    [self initHeaderView];
}

- (void)initView{

    [self loadTableView:CGRectMake(0, 144, DEVICE_Width, DEVICE_Height-144) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"senderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"mySenderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];

    nib = [UINib nibWithNibName:@"senderStausCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
}
- (void)initHeaderView{
    
    mTopView = [mAddressView shareView];
    [self.view addSubview:mTopView];
    [mTopView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.height.offset(@50);
    }];
    
    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [SVProgressHUD showWithStatus:@"正在定位中..." maskType:SVProgressHUDMaskTypeClear];
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请检查网络和定位设置！";
            [SVProgressHUD showErrorWithStatus:eee];
            mTopView.mAddress.text = eee;
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            [SVProgressHUD showErrorWithStatus:@"定位成功！"];
            
            NSLog(@"reGeocode:%@", regeocode);
            mTopView.mAddress.text = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
            
        }
    }];
    
    DVSwitch *secondSwitch = [DVSwitch switchWithStringsArray:@[@"我来跑腿", @"我的跑单"]];
    secondSwitch.frame = CGRectMake(0, 114, DEVICE_Width, 30);
    
    secondSwitch.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    secondSwitch.sliderColor = [UIColor colorWithRed:0.91 green:0.54 blue:0.16 alpha:1];
    secondSwitch.labelTextColorInsideSlider = [UIColor whiteColor];
    secondSwitch.labelTextColorOutsideSlider = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    secondSwitch.cornerRadius = 0;
    secondSwitch.font = [UIFont systemFontOfSize:14];
    [secondSwitch setPressedHandler:^(NSUInteger index) {
        NSLog(@"点击了%lu",(unsigned long)index);
        if (index == 0) {
            mType = 0;
        }else{
            mType = 1;
        }
        [self.tableView reloadData];

    }];
    
    [self.view addSubview:secondSwitch];

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
    
    if (mType == 0) {
        return 1;
        
    }
   else if (mType == 2) {
        return 1;
        
    }else{
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (mType == 0) {
        return 400;

    }
   else if (mType == 2) {
        return 480;
        
    }else{
        return 60;
    }
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = nil;
    
    if (mType == 0) {
        reuseCellId = @"cell";
    }else if (mType == 2) {
        reuseCellId = @"cell2";
    }else{
        reuseCellId = @"cell1";
    }
    
    senderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    [cell.mComfirBtn addTarget:self action:@selector(mComfirAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.mFinishBtn addTarget:self action:@selector(mfinishAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (mType == 0) {

    }else if (mType == 2) {
        
    }else{
        senderDetailViewController *sss = [[senderDetailViewController alloc] initWithNibName:@"senderDetailViewController" bundle:nil];
        [self pushViewController:sss];
    }
    
}


- (void)mComfirAction:(UIButton *)sender{

    mType = 2;
    [self.tableView reloadData];
}

- (void)mfinishAction:(UIButton *)sender{
    
    evolutionViewController *eee = [[evolutionViewController alloc] initWithNibName:@"evolutionViewController" bundle:nil];
    [self pushViewController:eee];
    

}
@end
