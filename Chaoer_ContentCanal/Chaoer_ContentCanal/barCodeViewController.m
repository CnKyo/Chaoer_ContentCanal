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
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

@interface barCodeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@end

@implementation barCodeViewController
{

    mBarCodeView *mView;
    mBarCodeView *mShareView;
    
    BOOL isYes;
    
    NSString *mBarCodeURL;
    UIImage *mBarCodeImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的二维码名片";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"分享";
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
    
    NSMutableDictionary *params = [self shareParams];
    [ShareSDK share:SSDKPlatformTypeWechat
         parameters:params
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
                 
             case SSDKResponseStateBegin:
             {
                 //[theController showLoadingView:YES];
                 break;
             }
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             default:
                 break;
         }
         
         if (state != SSDKResponseStateBegin)
         {
             //[theController showLoadingView:NO];
             //[theController.tableView reloadData];
         }

     }];
}

- (void)mTencent:(UIButton *)sender{
    MLLog(@"qq");
}
- (void)mWebo:(UIButton *)sender{
    MLLog(@"微博");
    

}


-(NSMutableDictionary *)shareParams
{
    if (mBarCodeImg == nil) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:mBarCodeURL]];
        mBarCodeImg = [UIImage imageWithData:data];
    }
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    //[shareParams SSDKEnableUseClientShare];
    NSArray* imageArray = @[mBarCodeImg];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://www.mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeImage];
    return shareParams;
}
-(void)shareMethod
{
    NSMutableDictionary *params = [self shareParams];
    
    [ShareSDK showShareActionSheet:self.view
                             items:@[@(SSDKPlatformTypeWechat)]
                       shareParams:params
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //[theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeFacebookMessenger)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
                       //[theController showLoadingView:NO];
                       //[theController.tableView reloadData];
                   }
                   
               }];
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
    
    [self mWechat:nil];
    
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
    

//    UIActionSheet *acc = [[UIActionSheet alloc]initWithTitle:@"是否将图片保存到相册？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil];
//    
//    [acc showInView:self.view];
    
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
    
    [cell.mBarCode sd_setImageWithURL:[NSURL URLWithString:mBarCodeURL] placeholderImage:[UIImage imageNamed:@"DefaultImg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        mBarCodeImg = image;
    }];
    
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
