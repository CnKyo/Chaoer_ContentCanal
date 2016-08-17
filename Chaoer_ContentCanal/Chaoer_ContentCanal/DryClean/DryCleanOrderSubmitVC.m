//
//  DryCleanOrderSubmitVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanOrderSubmitVC.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DryCleanOrderSubmitTableViewCell.h"
#import "APIClient.h"
#import "UIImage+QUAdditons.h"
#import "DryCleanOrderTimeVC.h"


@interface DryCleanOrderSubmitVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DryCleanOrderSubmitVC

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"确认订单";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    
    [self initView];
}


- (void)initView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    int padding = 10;
    UIView *btnView = ({
        UIView *view = [self.view newUIViewWithBgColor:[UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000]];
        UIButton *btn = [self.view newUIButtonWithTarget:self mehotd:@selector(goSubmmitOrderMethod:) title:@"确认订单" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:18]];
        [btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(view.top).offset(padding/2);
            make.bottom.equalTo(view.bottom).offset(-padding/2);
        }];
        view;
    });
    [btnView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(btnView.mas_width).multipliedBy(0.14);
    }];
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.top).offset(64);
        make.bottom.equalTo(btnView.top);
    }];
    
}


-(void)goSubmmitOrderMethod:(id)sender
{
    
}



#pragma mark -- tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
        return 90;
    return 60;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2)
        return 50;
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [view newUIImageViewWithImg:IMG(@"DefaultImg.png")];
        imgView.frame = CGRectMake(10, 10, 30, 30);
        UILabel *lable = [view newUILableWithText:@"重庆超尔科技超市" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        lable.frame = CGRectMake(50, 10, view.bounds.size.width - 60, 30);
        UIView *lineView = [view newDefaultLineView];
        lineView.frame = CGRectMake(0, view.bounds.size.height-1, view.bounds.size.width, 1);
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
        return 30;
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [view newDefaultLineView];
        lineView.frame = CGRectMake(0, 0, view.bounds.size.width, 1);
        UILabel *lable = [view newUILableWithText:@"应支付:10元" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:QU_TextAlignmentRight];
        lable.frame = CGRectMake(10, 0, view.bounds.size.width - 20, 30);
        return view;
    }
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        static NSString *cellIndentifier = @"DryCleanOrderSubmitVCTableViewCell2";
        DryCleanOrderSubmitTableViewCell *cell = (DryCleanOrderSubmitTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell= [[DryCleanOrderSubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.nameLable.text = @"衬衫";
        cell.countLable.text = @"共1件";
        cell.priceLable.text = @"￥10元";
        
        return cell;
        
    } else {
        static NSString *cellIndentifier = @"DryCleanOrderSubmitVCTableViewCell1";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.section == 0) {
            cell.imageView.image = IMG(@"m_local.png");
            cell.textLabel.text = @"请选择服务地址";
        } else if (indexPath.section == 1) {
            cell.imageView.image = IMG(@"m_local.png");
            cell.textLabel.text = @"请选择服务时间";
        }
        
        return cell;
    }
    
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        DryCleanOrderTimeVC *vc = [[DryCleanOrderTimeVC alloc] init];
        vc.hiddenTabBar = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
