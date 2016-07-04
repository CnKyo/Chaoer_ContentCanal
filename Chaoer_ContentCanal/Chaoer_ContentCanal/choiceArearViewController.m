//
//  choiceArearViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "choiceArearViewController.h"

@interface choiceArearViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,AMapLocationManagerDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *searchResult;
@property (nonatomic,strong) NSMutableArray *result;
-(void)initSearchBar;//创建搜索
-(void)initTableView;//创建搜索结果的示意图
@end

@implementation choiceArearViewController
{

    AMapLocationManager *mLocation;
    /**
     *  纬度
     */
    NSString *mLat;
    /**
     *  经度
     */
    NSString *mLng;
}

-(NSMutableArray *)result{
    if (!_result) {
        self.result = [NSMutableArray array];
    }
    return _result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"选择小区";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
   
    mLat = nil;
    mLng = nil;
    
    [self loadAddress];

    [self initSearchBar];
    [self initTableView];


    
    
    
//    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
//    self.tableView.allowsSelection = YES;
//    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    
    
}
- (void)loadAddress{
    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    //    [WJStatusBarHUD showLoading:@"正在定位中..."];
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请检查网络和定位设置！";
            [WJStatusBarHUD showErrorImageName:nil text:eee];
            
            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        
        MLLog(@"location:%f", location.coordinate.latitude);
        
        mLat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        mLng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];

        if (regeocode)
        {
            
            [WJStatusBarHUD showSuccessImageName:nil text:@"定位成功"];
            
            MLLog(@"reGeocode:%@", regeocode);
        }
    }];
    
}





- (void)headerBeganRefresh{
    
    if ([Util isHaveIllegalChar:self.searchBar.text]) {
        [self showErrorStatus:@"搜索内容不能包含非法字符！"];
        return;
    }
    
    if (mLat.length == 0 || mLng.length == 0) {
        
        
        mLat = mLng = @"";
        
    }
    if (self.mProvinceId == nil || self.mProvinceId.length == 0 ||[self.mProvinceId isEqualToString:@""]) {
        [self showErrorStatus:@"地区输入有误，请重新输入！"];
        [self popViewController];
        return;
    }
    
    [self showWithStatus:@"正在加载中..."];
    
    
    [[mUserInfo backNowUser] getCodeArear:self.mProvinceId andArearId:self.mArearId andCityId:self.mCityId andName:self.searchBar.text andLat:mLat andLng:mLng block:^(mBaseData *resb, NSArray *mArr) {
        [self headerEndRefresh];
        [self.tempArray removeAllObjects];
        [self.result removeAllObjects];
        [self removeEmptyView];
        if (resb.mSucess) {
            [self showSuccessStatus:resb.mMessage];
            [self.tempArray addObjectsFromArray:mArr];
            [self.result addObject:mArr];
            [self.searchResult reloadData];
        }else{
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
        }
        
    }];

}




-(void)initSearchBar{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, DEVICE_Width, 44)];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"请输入搜索关键字";
    _searchBar.delegate = self;
    _searchBar.barTintColor = M_CO;
    _searchBar.searchBarStyle = UIBarStyleBlackTranslucent;
    _searchBar.barStyle = UIBarStyleDefault;
    [self.view addSubview:_searchBar];
    
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
- (void)initTableView{
    self.searchResult = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.searchBar.frame), DEVICE_Width, DEVICE_Height-108)];
    _searchResult.dataSource = self;
    _searchResult.delegate =self;
    _searchResult.tableFooterView = [[UIView alloc]init];
    [_searchResult registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.searchResult];
    
    self.tableView = _searchResult;
    self.haveHeader = YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    MLLog(@"heahtdyfgh");
    
    //改变取消的文本
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:M_CO forState:UIControlStateNormal];
        }
    }
}



-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    MLLog(@"我的");
}

/**
 *  搜框中输入关键字的事件响应
 *
 *  @param searchBar  UISearchBar
 *  @param searchText 输入的关键字
 */
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    
//    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
//    self.tempArray = nil;
//    for (int i = 0; i < self.result.count; i++) {
//        
//        GGetArear *mArear = self.result[i];
//
//        
//        if (mArear.mName.length >= searchText.length) {
//            NSString *str = [self.result[i] substringWithRange:NSMakeRange(0, searchText.length)];
//            if ([str isEqualToString:searchText]) {
//                [self.tempArray addObject:self.result[i]];
//            }
//        }
//    }
//    [self.searchResult reloadData];
//    
//}

/**
 *  取消的响应事件
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    MLLog(@"取消吗");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

/**
 *  键盘上搜索事件的响应
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MLLog(@"取");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self headerBeganRefresh];
    
}


/**
 *  UITableView的三个代理
 *
 *
 *  @return 行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    GGetArear *mArear = self.tempArray[indexPath.row];
    
    cell.textLabel.text = mArear.mName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GGetArear *mArear = self.tempArray[indexPath.row];

    self.block(mArear.mName,[NSString stringWithFormat:@"%d",mArear.mId]);
    
    [self popViewController];
    
}

- (void)leftBtnTouched:(id)sender{

    if ([Util isHaveIllegalChar:self.searchBar.text]) {
        [self showErrorStatus:@"搜索内容不能包含非法字符！"];
        return;
    }else{

        
        self.block(self.searchBar.text,nil);
        
        
        [self popViewController];
        
    }
    
    
}

@end
