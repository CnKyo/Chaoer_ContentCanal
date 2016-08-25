//
//  barCodeViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "barCodeViewController.h"
#import "mBarCodeView.h"
#import "barCodeCell.h"

@interface barCodeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@end

@implementation barCodeViewController
{

    mBarCodeView *mView;
    mBarCodeView *mShareView;
    
    BOOL isYes;
    
    NSString *mBarCodeURL;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的二维码名片";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"保存";
//    self.hiddenRightBtn = YES;
//    self.rightBtnImage = [UIImage imageNamed:@"share_bgk"];
    mBarCodeURL = nil;
    [SVProgressHUD dismiss];
    [self initView];

    [self loadShareView];
    
    UITapGestureRecognizer *ttt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:ttt];
    

}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    UINib   *nib = [UINib nibWithNibName:@"barCodeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

- (void)headerBeganRefresh{

    [self showWithStatus:@"正在验证..."];
    [[mUserInfo backNowUser] getMyBarCode:^(mBaseData *resb,NSString *mBarCodeUrl) {
        [self headerEndRefresh];
        if (resb.mSucess) {
            [self showSuccessStatus:resb.mMessage];
            mBarCodeURL = mBarCodeUrl;
            [self.tableView reloadData];
                    
        }else{
        
            [self showErrorStatus:resb.mMessage];
        }
    }];
}

- (void)loadShareView{
 
    
    mShareView = [mBarCodeView shareBottomView];
    
    [mShareView.mShareWechat addTarget:self action:@selector(mWechat:) forControlEvents:UIControlEventTouchUpInside];
    [mShareView.mShareTencent addTarget:self action:@selector(mTencent:) forControlEvents:UIControlEventTouchUpInside];
    [mShareView.mShareWebo addTarget:self action:@selector(mWebo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mShareView];
    [mShareView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(DEVICE_Height);
        make.height.offset(@80);
    }];
}


- (void)mWechat:(UIButton *)sender{
    MLLog(@"微信");
}

- (void)mTencent:(UIButton *)sender{
    MLLog(@"qq");
}
- (void)mWebo:(UIButton *)sender{
    MLLog(@"微博");
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

- (void)rightBtnTouched:(id)sender{
    
//    UIButton *btn = sender;
//    btn.selected = !btn.selected;
//    btn.selected = !isYes;
//    if (btn.selected) {
//        [self shaowShareView];
//        isYes = YES;
//    }else{
//        [self hiddenSahreView];
//        isYes = NO;
//    }
//    

    UIActionSheet *acc = [[UIActionSheet alloc]initWithTitle:@"是否将图片保存到相册？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil];
    
    [acc showInView:self.view];
    
}

- (void)tap{

    [self hiddenSahreView];
    isYes = NO;
}

- (void)shaowShareView{

    [UIView animateWithDuration:0.35 animations:^{
        
        CGRect rrr = mShareView.frame;
        rrr.origin.y = DEVICE_Height-80;
        mShareView.frame = rrr;
        
    }];
    
}

- (void)hiddenSahreView{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rrr = mShareView.frame;
        rrr.origin.y = DEVICE_Height;
        mShareView.frame = rrr;
        
    }];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 609;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSString *reuseCellId = @"cell";
    
    
    barCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];
    
    [cell.mHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    
    [cell.mBarCode sd_setImageWithURL:[NSURL URLWithString:mBarCodeURL] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    
    cell.mNickName.text = [mUserInfo backNowUser].mNickName;
    cell.mIdentify.text = [mUserInfo backNowUser].mIdentity;
    cell.mPhone.text = [mUserInfo backNowUser].mPhone;

    
    
    return cell;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

 
    
}

#pragma mark - IBActionSheet/UIActionSheet Delegate Method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:mBarCodeURL]];
        
        
        UIImage *savedImage = [UIImage imageWithData:data];
        
        [self saveImageToPhotos:savedImage];
    }
    
}
//实现该方法
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
}
//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        [self showErrorStatus:msg];
        
    }else{
        msg = @"保存图片成功" ;
        [self showSuccessStatus:msg];
        
    }
    
    
}


@end
