//
//  AddServiceTypeVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "AddServiceTypeVC.h"

@interface AddServiceTypeVC ()<UITableViewDataSource,UITableViewDelegate>{

    BOOL open;
//    STrade *selectTrade;
}

@end

@implementation AddServiceTypeVC

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
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.mPageName = @"添加分类";
    
    self.Title = self.mPageName;
    
    self.rightBtnTitle = @"完成";
    
    open = NO;
    
    
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    
    [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeClear];
    
//    [SSeller getTradeList:^(SResBase *resb, NSArray *all) {
//        
//        if (resb.msuccess) {
//            [SVProgressHUD dismiss];
//            [self.tempArray removeAllObjects];
//            
//            [self.tempArray addObjectsFromArray:all];
//            
//            if (open) {
//                _mTableViewHeight.constant = 45*all.count;
//                _mTableView.contentSize = CGSizeMake(DEVICE_Width, 45*all.count);
//            }else{
//                _mTableViewHeight.constant = 0;
//            }
//            
//            
//            if (all.count>0) {
//                
//                
//                if (!_mCate) {
//                    STrade *tarde = [all objectAtIndex:0];
//                    selectTrade = tarde;
//                    _mType.text = tarde.mName;
//                }
//                
//            }
//            
//            [_mTableView reloadData];
//            
//        }else{
//            _mTableViewHeight.constant = 0;
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//    }];
//    
//    
//    if (_mCate) {
//        _mType.text = _mCate.mTrade.mName;
//        _mTypeName.text = _mCate.mName;
//       
//        selectTrade = _mCate.mTrade;
//    }
//    
//    
    
}

- (void)rightBtnTouched:(id)sender{

    
    if (_mTypeName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入分类名称"];
        return;
    }
    [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
    
//    if (_mCate) {
//        [_mCate changeName:_mTypeName.text tradeId:selectTrade.mId type:_type block:^(SResBase *resb) {
//            if (resb.msuccess) {
//                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//                
//                if (_block) {
//                    _block(YES);
//                }
//                
//                [self popViewController];
//            }else{
//                [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            }
//        }];
//        return;
//
//    }
//    [SGoodsCate addOne:_mTypeName.text tradeid:selectTrade.mId type:_type block:^(SResBase *resb) {
//        if (resb.msuccess) {
//            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//            
//            if (_block) {
//                _block(YES);
//            }
//            [self popViewController];
//        }else{
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//    }];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tempArray count];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    
//    STrade *tarde = [self.tempArray objectAtIndex:indexPath.row];
//    cell.textLabel.text = tarde.mName;
//    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    cell.textLabel.textColor = COLOR(71, 72, 73);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    STrade *tarde = [self.tempArray objectAtIndex:indexPath.row];
//    _mType.text = tarde.mName;
//    selectTrade = tarde;
    _mTableViewHeight.constant = 0;
    open = NO;
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

- (IBAction)OpenTypeClick:(id)sender {
    
    if (open) {
        _mTableViewHeight.constant = 0;
    }else{
        _mTableViewHeight.constant = self.tempArray.count*45;
    }
    open = !open;
   
}
@end
