//
//  mFixViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixViewController.h"

#import "mFixView.h"


#import "takeFixViewController.h"

#import "fixTableViewCell.h"
@interface mFixViewController ()<ZJAlertListViewDelegate,ZJAlertListViewDatasource,HZQDatePickerViewDelegate>{
    HZQDatePickerView *_pikerView;

}
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation mFixViewController
{
    UIScrollView *mScrollerView;
    mFixView *mView;
    
    
    ZJAlertListView *mHomeA;
    ZJAlertListView *mCleanA;
    ZJAlertListView *mPipeA;
    
    NSMutableArray  *mArr;
    
    NSString    *mType;

    
}
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
    
    mArr = [NSMutableArray new];
    
    self.Title = self.mPageName = @"物业报修";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initView];
    
}
- (void)initView{
    
    
    UIImageView *mbgk = [UIImageView new];
    CGRect  mrr = self.view.bounds;
    mrr.origin.y = 64;
    mbgk.frame = mrr;
    mbgk.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:mbgk];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    
    mView = [mFixView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);

    [mView.mHomeBtn addTarget:self action:@selector(mHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mCleanBtn addTarget:self action:@selector(mCleanAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mPipeBtn addTarget:self action:@selector(mPipeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mResultBtn addTarget:self action:@selector(mResetAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mTimeBtn addTarget:self action:@selector(mTimeAction:) forControlEvents:UIControlEventTouchUpInside];


    mView.mHiddenView.alpha = 0;
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 620);
    
    
    
}
#pragma mark----时间选择
- (void)mTimeAction:(UIButton *)sender{
    [self setupDateView:DateTypeOfStart];

}
- (void)setupDateView:(DateType)type {
    
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    [self.view addSubview:_pikerView];
    
}
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);
    
    switch (type) {
        case DateTypeOfStart:
            [mView.mTimeBtn setTitle:[NSString stringWithFormat:@"选择时间:%@", date] forState:0];
            
            break;

            
        default:
            break;
    }
}
#pragma mark----重新选择
- (void)mResetAction:(UIButton *)sender{
    mView.mHiddenView.alpha = 0;
    mView.mSelectedView.alpha = 1;
}
#pragma mark----家电
- (void)mHomeAction:(UIButton *)sender{
    mType = sender.titleLabel.text;
    mHomeA = [[ZJAlertListView alloc] initWithFrame:CGRectMake(0, 0, 180, 300)];
    mHomeA.titleLabel.text = [NSString stringWithFormat:@"-%@-",sender.titleLabel.text];
    mHomeA.datasource = self;
    mHomeA.delegate = self;
    //点击确定的时候，调用它去做点事情
    [mHomeA setDoneButtonWithBlock:^{
        
        NSLog(@"结果是：%@",mArr);
        mView.mHiddenView.alpha = 1;
        mView.mSelectedView.alpha = 0;
        
        [mView.mResultBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        mView.mResultContent.text = [NSString stringWithFormat:@"%@",mArr[0]];
        [mHomeA dismiss];
        
    }];
    [mHomeA show];
}
#pragma mark----清洁
- (void)mCleanAction:(UIButton *)sender{
        mType = sender.titleLabel.text;
    mCleanA = [[ZJAlertListView alloc] initWithFrame:CGRectMake(0, 0, 180, 300)];

    mCleanA.titleLabel.text = [NSString stringWithFormat:@"-%@-",sender.titleLabel.text];
    mCleanA.datasource = self;
    mCleanA.delegate = self;
    //点击确定的时候，调用它去做点事情
    [mCleanA setDoneButtonWithBlock:^{
        
        NSLog(@"结果是：%@",mArr);

        mView.mHiddenView.alpha = 1;
        mView.mSelectedView.alpha = 0;
        
        [mView.mResultBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        mView.mResultContent.text = [NSString stringWithFormat:@"%@",mArr[0]];
        [mCleanA dismiss];
        
    }];
    [mCleanA show];
}
#pragma mark----管道
- (void)mPipeAction:(UIButton *)sender{
        mType = sender.titleLabel.text;
    mPipeA = [[ZJAlertListView alloc] initWithFrame:CGRectMake(0, 0, 180, 300)];
    mPipeA.titleLabel.text = [NSString stringWithFormat:@"-%@-",sender.titleLabel.text];
    mPipeA.datasource = self;
    mPipeA.delegate = self;
    //点击确定的时候，调用它去做点事情
    [mPipeA setDoneButtonWithBlock:^{
        
        NSLog(@"结果是：%@",mArr);
        mView.mHiddenView.alpha = 1;
        mView.mSelectedView.alpha = 0;
        
        [mView.mResultBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        mView.mResultContent.text = [NSString stringWithFormat:@"%@",mArr[0]];
        
        [mPipeA dismiss];
        
    }];
    [mPipeA show];
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
#pragma mark -设置行数
- (NSInteger)alertListTableView:(ZJAlertListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == mHomeA) {
        return 15;

    }if (tableView == mCleanA) {
        return 10;

    }else{
        return 5;
    }

}

- (UITableViewCell *)alertListTableView:(ZJAlertListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableAlertListCellWithIdentifier:identifier];
    cell.tintColor = M_CO;
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        /**
         *  cell选择样式为无
         */
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        /**
         *  自定义cell背景
         */
        UIImageView *iii = [UIImageView new];
        iii.frame = CGRectMake(0,5, 180, 45);
        iii.image = [UIImage imageNamed:@"fixcell_bgk"];
        [cell.contentView addSubview:iii];
        
    }
    if ( self.selectedIndexPath && NSOrderedSame == [self.selectedIndexPath compare:indexPath])
    {
        /**
         *  自定义cell选择样式－选中
         */
        UIImageView *iii = [UIImageView new];
        iii.frame = CGRectMake(230, 25, 10, 10);
        iii.image = [UIImage imageNamed:@"fixcell_selected"];
        [cell.contentView addSubview:iii];
        cell.accessoryView = iii;
    }
    else
    {
        /**
         *  自定义cell选择样式－未选中
         */
        UIImageView *iii = [UIImageView new];
        iii.frame = CGRectMake(230, 25, 10, 10);
        iii.image = [UIImage imageNamed:@"fixcell_unselecte"];
        [cell.contentView addSubview:iii];
        cell.accessoryView = iii;

    }
    cell.textLabel.text = [NSString stringWithFormat:@"-%@---%ld---", mType,(long)indexPath.row];
    return cell;
}

- (void)alertListTableView:(ZJAlertListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView alertListCellForRowAtIndexPath:indexPath];
    cell.tintColor = M_CO;
    UIImageView *iii = [UIImageView new];
    iii.frame = CGRectMake(230, 25, 10, 10);
    iii.image = [UIImage imageNamed:@"fixcell_unselecte"];
    [cell.contentView addSubview:iii];
    cell.accessoryView = iii;
//    cell.accessoryType = UITableViewCellAccessoryNone;
    NSLog(@"didDeselectRowAtIndexPath:%ld", (long)indexPath.row);
}

- (void)alertListTableView:(ZJAlertListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [mArr removeAllObjects];
    self.selectedIndexPath = indexPath;
    UITableViewCell *cell = [tableView alertListCellForRowAtIndexPath:indexPath];
    cell.tintColor = M_CO;
    cell.selected = !cell.selected;
    if (cell.selected) {
        cell.backgroundColor = [UIColor whiteColor];
        UIImageView *iii = [UIImageView new];
        iii.frame = CGRectMake(230, 25, 10, 10);
        iii.image = [UIImage imageNamed:@"fixcell_selected"];
        [cell.contentView addSubview:iii];
        cell.accessoryView = iii;
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [mArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        NSLog(@"选择了第:%ld行", (long)indexPath.row);
        NSLog(@"一共有%@",mArr);
    }else{
        NSLog(@"dasda");
    }

}
@end
