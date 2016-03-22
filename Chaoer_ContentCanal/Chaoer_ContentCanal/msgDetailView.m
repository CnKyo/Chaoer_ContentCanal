//
//  msgDetailView.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/7/1.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "msgDetailView.h"
#import "messageView.h"
@interface msgDetailView ()

@end

@implementation msgDetailView{
    messageView *mDetailView;
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;

    [super viewDidLoad];
    self.hiddenlll = YES;
    self.Title = self.mPageName = _mTitleStr;
    [self initView];

    // Do any additional setup after loading the view from its nib.
}
- (void)initView{

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *sss = [UIScrollView new];
    sss.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];
    [self.view addSubview:sss];

    
    mDetailView = [messageView shareView];
    mDetailView.backgroundColor = [UIColor whiteColor];
//    mDetailView.mTitiel.text = _Smsg.mTitle;
//    mDetailView.mtime.text = _Smsg.mCreateTime;
//    mDetailView.mcontent.text = _Smsg.mContent;
    [sss addSubview:mDetailView];
    
    
    CGFloat contentH = [Util labelText:mDetailView.mcontent.text fontSize:15 labelWidth:mDetailView.mcontent.mwidth];
    CGFloat tH = 84+contentH-15;
    if (tH<= 84) {
        tH = 84;
    }
    
    
    [sss makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view).offset(0);
        make.width.offset(DEVICE_Width);

    }];
    [mDetailView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sss).offset(0);
        make.right.equalTo(sss.right).offset(0);
        make.top.equalTo(sss.top).offset(0);
        make.height.offset(tH);
        make.bottom.equalTo(sss.bottom).offset(0);
        make.width.offset(DEVICE_Width);
        
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

@end
