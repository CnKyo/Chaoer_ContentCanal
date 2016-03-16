//
//  mPublicWalerViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mPublicWalerViewController.h"
#import "mPublicWlerTableViewCell.h"


#import "mJoinActivityViewController.h"
@interface mPublicWalerViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation mPublicWalerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"公益活动";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    UINib   *nib = [UINib nibWithNibName:@"mPublicWlerTableViewCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}
- (IBAction)mGoAction:(id)sender {
    
    mJoinActivityViewController *mmm = [[mJoinActivityViewController alloc] initWithNibName:@"mJoinActivityViewController" bundle:nil];
    [self pushViewController:mmm];
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
    NSString *reuseCellId = @"cell";

    mPublicWlerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];

    NSString *sss= @"dasdgasdhgsajhkd的撒空间很大缓解阿萨德就会撒娇扩大社会公德阿斯顿噶死的结果啊圣诞节阿萨德空间啊圣诞卡就是贷记卡时光";
    
    CGFloat mH = [Util labelText:sss fontSize:16 labelWidth:cell.mContent.mwidth];
    
    CGFloat mTTH = 44-21+mH;
    if (mTTH<= 44) {
        mTTH = 44;
    }
    
    return mTTH;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    mPublicWlerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mContent.text = @"dasdgasdhgsajhkd的撒空间很大缓解阿萨德就会撒娇扩大社会公德阿斯顿噶死的结果啊圣诞节阿萨德空间啊圣诞卡就是贷记卡时光";
    return cell;
    
}
@end
