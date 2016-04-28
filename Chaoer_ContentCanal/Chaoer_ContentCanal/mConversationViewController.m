//
//  mConversationViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mConversationViewController.h"

#import "mConversationCell.h"

@interface mConversationViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>


@end

@implementation mConversationViewController
{
    WKSegmentControl    *mSegmentView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"社区交流";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;

    [self initViuew];
}
- (void)initViuew{
    
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 64, DEVICE_Width, 40) andTitleWithBtn:@[@"居民", @"管理员", @"群聊", @"附近的人"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:70 delegate:self andIsHiddenLine:NO];
    
    [self.view addSubview:mSegmentView];
    
    
    [self loadTableView:CGRectMake(0,mSegmentView.mbottom, DEVICE_Width, DEVICE_Height-mSegmentView.mbottom) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

//    self.haveHeader = YES;
//    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"mConversationCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    NSLog(@"点击了%lu",(unsigned long)mIndex);

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
    
    return 10;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
        
    mConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    [cell.mHeaderImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    return cell;
    
}

@end
