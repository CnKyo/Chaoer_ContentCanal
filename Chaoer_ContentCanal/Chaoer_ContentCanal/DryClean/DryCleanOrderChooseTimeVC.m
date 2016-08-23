//
//  DryCleanOrderTimeVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanOrderChooseTimeVC.h"
#import "HMSegmentedControl.h"
#import "DateTools.h"
#import "DryCleanTimeChooseView.h"
#import "UIImage+QUAdditons.h"

@interface DryCleanOrderChooseTimeVC ()
@property(strong,nonatomic) NSMutableArray *dateArr; //seg的标题arr
@property(strong,nonatomic) HMSegmentedControl *segControl;

@property(strong,nonatomic) NSMutableDictionary *timeDic;
@property(strong,nonatomic) DryCleanTimeChooseView *chooseView;
@property(strong,nonatomic) NSMutableDictionary *chooseTimeDic;
@end

@implementation DryCleanOrderChooseTimeVC

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"选择服务时间";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.dateArr = [NSMutableArray array];
    self.timeDic = [NSMutableDictionary dictionary];
    self.chooseTimeDic = [NSMutableDictionary dictionary];
    
    [self loadDateArr];
    
    self.page = 1;
    
    [self.view bringSubviewToFront:self.scrollView];
    [self initView];
    
    
    [self.segControl setSelectedSegmentIndex:0 animated:YES];
    
    __weak DryCleanOrderChooseTimeVC *safeSelf = self;
    self.chooseView.chooseCallBack = ^(NSString* timeStr) {
        if (timeStr.length > 0) {
            [safeSelf.chooseTimeDic removeAllObjects];
            
            NSString *str = [safeSelf dateStrWithSegIndex:safeSelf.segControl.selectedSegmentIndex];
            [safeSelf.chooseTimeDic setObject:timeStr forKey:str];
        }
    };
}


- (void)initView{
    

    UIColor *selectColor = [UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000];
    UIView *superView = self.view;
    int padding = 10;
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:_dateArr];
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:16]};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : selectColor, NSFontAttributeName:[UIFont systemFontOfSize:18]};
    segmentedControl.selectionIndicatorColor = selectColor;
    segmentedControl.selectionIndicatorHeight = 1;
    segmentedControl.shouldAnimateUserSelection = YES;
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [superView addSubview:segmentedControl];
    self.segControl = segmentedControl;
    int headerViewHeight = 50;
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(superView.top).offset(64+10);
        make.height.equalTo(headerViewHeight);
    }];
    


    self.scrollView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    self.scrollContentView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    
    //NSArray *arr = [NSArray arrayWithObjects:@"111", @"111", @"111", @"111", @"111", @"111", @"111", @"111", @"111", @"111", @"111", nil];
    DryCleanTimeChooseView *chView = [[DryCleanTimeChooseView alloc] init];
    [self.scrollContentView addSubview:chView];
    self.chooseView = chView;
    UILabel *noteLable = [self.scrollContentView newUILableWithText:@"提示：最长可预约七天内的服务时间" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:14]];
    noteLable.numberOfLines = 0;
    [chView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollContentView.left).offset(padding);
        make.right.equalTo(self.scrollContentView.right).offset(-padding);
        make.top.equalTo(self.scrollContentView.top).offset(padding);
    }];
    [noteLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(chView);
        make.height.equalTo(30);
        make.top.equalTo(chView.bottom).offset(padding/2);
    }];
    

    UIView *btnView = ({
        UIView *view = [self.view newUIViewWithBgColor:[UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000]];
        UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(goSubmmitMethod:) title:@"确认选择" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:18]];
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
    
    [self.scrollView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentedControl.mas_bottom);
        make.left.right.equalTo(superView);
        make.bottom.equalTo(btnView.top);
    }];
    [self.scrollContentView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.bottom.equalTo(noteLable.bottom).offset(padding);
    }];
}


-(void)goSubmmitMethod:(id)sender
{
    if (_chooseTimeDic.count > 0) {
        NSArray *keys = [_chooseTimeDic allKeys];
        NSString *key = [keys objectAtIndex:0];
        NSString *val = [_chooseTimeDic objectForKey:key];
        if (self.chooseCallBack)
            self.chooseCallBack(key, val);
        
        [self popViewController];
    } else
        [SVProgressHUD showErrorWithStatus:@"请选择时间"];
}

-(NSString *)dateStrWithSegIndex:(NSInteger)index
{
    NSDate *date = [[NSDate date] dateByAddingDays:index];
    NSString *dateStr = [date formattedDateWithFormat:@"yyyyMMdd"];
    return dateStr;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
    NSDate *date = [[NSDate date] dateByAddingDays:segmentedControl.selectedSegmentIndex];
    NSString *dateStr = [date formattedDateWithFormat:@"yyyyMMdd"];
    
    NSString *dateTimeChooseStr = [self.chooseTimeDic objectForKey:dateStr];
    
    NSArray *arr = [self.timeDic objectForKey:dateStr];
    if (arr.count > 0) {
        [self.chooseView loadUIWithTitleArr:arr chooseTime:dateTimeChooseStr];
    } else {
        [SVProgressHUD showWithStatus:@"加载中..."];
        [[APIClient sharedClient] dryClearnShopOpeningTimeListWithTag:self shopId:_shopId dateStr:dateStr call:^(NSArray *tableArr, APIObject *info) {
            
            if (tableArr.count > 0) {
                [self.timeDic setObject:tableArr forKey:dateStr];
                
                [SVProgressHUD dismiss];
            } else
                [SVProgressHUD showErrorWithStatus:info.message];
            
            [self.chooseView loadUIWithTitleArr:tableArr chooseTime:dateTimeChooseStr];
        }];
    }
}


-(void)loadDateArr
{
    int dayShow = 2;
    NSDate *currentDate = [NSDate date];
    
    [self.dateArr removeAllObjects];
    NSCalendar *calendar =[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    for (int i=0; i<dayShow; i++) {
        NSDate *date = [currentDate dateByAddingDays:i];
        NSInteger weekday = [date weekdayWithCalendar:calendar];
        NSInteger month = [date monthWithCalendar:calendar];
        NSInteger day = [date dayWithCalendar:calendar];
        
        NSString *weekStr = @"";
        NSString *monthDayStr = [NSString stringWithFormat:@"%li月%li号", (long)month, (long)day];
        if (i == 0) {
            weekStr = @"今天";
        } else if (i == 1) {
            weekStr = @"明天";
        } else {
            weekStr = [self weekStr:weekday];
        }
        NSString *newStr = [NSString stringWithFormat:@"%@\n%@", weekStr, monthDayStr];
        [self.dateArr addObject:newStr];
    }
}

-(NSString *)weekStr:(NSInteger)week
{
    NSString *weekStr = @"";
    switch (week) {
        case 7:
            weekStr = @"周日";
            break;
        case 1:
            weekStr = @"周一";
            break;
        case 2:
            weekStr = @"周二";
            break;
        case 3:
            weekStr = @"周三";
            break;
        case 4:
            weekStr = @"周四";
            break;
        case 5:
            weekStr = @"周五";
            break;
        case 6:
            weekStr = @"周六";
            break;
        default:
            break;
    }
    return weekStr;
}



@end
