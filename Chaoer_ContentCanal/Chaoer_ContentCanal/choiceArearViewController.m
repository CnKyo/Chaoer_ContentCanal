//
//  choiceArearViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "choiceArearViewController.h"

@interface choiceArearViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *searchResult;
@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) NSMutableArray *result;
-(void)initSearchBar;//创建搜索
-(void)initTableView;//创建搜索结果的示意图
@end

@implementation choiceArearViewController
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

    self.nameArray = [@[@"闪闪发光",@"商量等产",@"小情人",@"小歌手",@"爱人",@"爱着你",@"王大妈",@"王阿姨",@"我爱你",@"我爱猪",@"你是猪",@"你是人吗",@"啦啦啦",@"爱我吗",@"爱吗",@"爱不爱",@"不爱",@"爱人他",@"爱人妈",@"小帅哥",@"小情人人",@"小帅哥小帅哥小帅哥小帅哥小帅哥",@"小帅哥小帅哥小帅哥小帅哥小帅",@"小帅哥小帅哥小帅哥小帅哥小",@"小帅哥小帅哥小帅哥小帅哥",@"小帅哥小帅哥小帅哥小帅",@"小帅哥小帅哥小帅哥小",@"小帅哥小帅哥小帅哥",@"小帅哥小帅哥小帅哥小",@"小帅哥小帅哥小帅哥",@"小帅哥小帅哥小帅",@"小帅哥小帅哥小",@"小帅哥小帅哥"] mutableCopy];
    
    [self initSearchBar];

    
//    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
//    self.tableView.allowsSelection = YES;
//    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    
    
}
-(void)initSearchBar{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, DEVICE_Width, 44)];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"请输入搜索关键字";
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor colorWithRed:0.82 green:0.84 blue:0.86 alpha:1.00];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
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
    self.searchResult = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.searchBar.frame), self.view.bounds.size.width, self.view.bounds.size.height-64-CGRectGetHeight(self.searchBar.frame))];
    _searchResult.dataSource = self;
    _searchResult.delegate =self;
    _searchResult.tableFooterView = [[UIView alloc]init];
    [_searchResult registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.searchResult];
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    [self initTableView];
    NSLog(@"heahtdyfgh");
    
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
    NSLog(@"我的");
}

/**
 *  搜框中输入关键字的事件响应
 *
 *  @param searchBar  UISearchBar
 *  @param searchText 输入的关键字
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
    self.result = nil;
    for (int i = 0; i < self.nameArray.count; i++) {
        NSString *string = self.nameArray[i];
        if (string.length >= searchText.length) {
            NSString *str = [self.nameArray[i] substringWithRange:NSMakeRange(0, searchText.length)];
            if ([str isEqualToString:searchText]) {
                [self.result addObject:self.nameArray[i]];
            }
        }
    }
    [self.searchResult reloadData];
    
}

/**
 *  取消的响应事件
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取消吗");
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
    NSLog(@"取");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}


/**
 *  UITableView的三个代理
 *
 *
 *  @return 行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.result.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.result[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.block(self.result[indexPath.row],@"what");
    
    [self popViewController];
    
}


@end
