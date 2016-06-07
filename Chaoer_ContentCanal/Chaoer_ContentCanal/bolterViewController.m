//
//  bolterViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "bolterViewController.h"
#import "UIView+Extnesion.h"
/** 当前设备屏幕的宽度 */
#define kScreenW [UIScreen mainScreen].bounds.size.width
@interface bolterViewController ()<AttributeViewDelegate>

/** 电商 */
@property (nonatomic ,weak) AttributeView *attributeViewDS;
/** 巨头 */
@property (nonatomic ,weak) AttributeView *attributeViewJT;
/** 国家 */
@property (nonatomic ,weak) AttributeView *attributeViewGJ;
@end

@implementation bolterViewController

{

    NSString *mReleaseTag;
    NSString *mTagId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"筛选";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    mReleaseTag = nil;
    mTagId = nil;
    [self loadData];
    

}

- (void)loadData{

    [self showWithStatus:@"正在加载中..."];
    
    if (self.mType == 1) {
        [[mUserInfo backNowUser] getReleaseTags:self.mSubType block:^(mBaseData *resb, NSArray *mArr) {
            
            if (resb.mSucess) {
                [SVProgressHUD dismiss];
                
                if (mArr.count<=0) {
                    [self showErrorStatus:@"没有标签"];
                }else{
                    [self.tempArray addObjectsFromArray:mArr];
                }
                [self initReleaseView];
                
            }else{
                
                [self showErrorStatus:resb.mMessage];
            }
        }];

    }else{
    
    }
    
    
    
}

- (void)initReleaseView{
    
    /**
     *  1是买东西 2是办事情 3是跑腿
     */
    NSString *mTT = @"类型";
//    if (self.mSubType == 1) {
//        mTT = @"商品买送";
//    }else if (self.mSubType == 2){
//        mTT = @"事情办理";
//    }else{
//        mTT = @"送东西";
//    }
    
    // 创建最底层的scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 1)];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    // 创建电商属性视图
    NSMutableArray *dsData = [NSMutableArray new];
    
    NSMutableArray *mTagArr = [NSMutableArray new];
    
    for (GReleaseTag *mTag in self.tempArray) {
        
        [dsData addObject:mTag.mTagName];
        [mTagArr addObject:[NSString stringWithFormat:@"%d",mTag.mId]];
    }
    
    AttributeView *attributeViewDS = [AttributeView attributeViewWithTitle:mTT titleFont:[UIFont boldSystemFontOfSize:15] attributeTexts:dsData viewWidth:kScreenW andTag:mTagArr];
    attributeViewDS.tag = 1001;
    self.attributeViewDS = attributeViewDS;
    
    
    CGRect AAR = attributeViewDS.frame;
    AAR = attributeViewDS.frame;
    AAR.origin.y =  15;
    attributeViewDS.frame = AAR;
    
    // 设置代理
    attributeViewDS.Attribute_delegate = self;
    // 添加到scrollview上
    [scrollView addSubview:attributeViewDS];

    
    scrollView.contentSize = (CGSize){0,[UIScreen mainScreen].bounds.size.height + 20};
    
    // 添加scrollview到当前view上
    [self.view addSubview:scrollView];
    // 通过动画设置scrollview的高度, 也可以一开始就设置好
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        scrollView.height += [UIScreen mainScreen].bounds.size.height - 30;
    } completion:nil];

    UIButton *okBtn = [UIButton new];
    okBtn.frame = CGRectMake(0, DEVICE_Height-40, DEVICE_Width, 40);
    [okBtn setTitle:@"确定" forState:0];
    [okBtn setTitleColor:[UIColor whiteColor] forState:0];
    okBtn.backgroundColor = M_CO;
    [okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
}
- (void)initView{

    // 创建最底层的scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 1)];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    // 创建电商属性视图
    NSArray *dsData = @[@"淘宝",@"京东",@"天猫",@"亚马逊",@"大众点评网算电商吗",@"有货"];
    AttributeView *attributeViewDS = [AttributeView attributeViewWithTitle:@"电商" titleFont:[UIFont boldSystemFontOfSize:15] attributeTexts:dsData viewWidth:kScreenW andTag:dsData];
    self.attributeViewDS = attributeViewDS;
    
    // 创建巨头属性视图
    NSArray *jtData = @[@"腾讯",@"阿里巴巴",@"百度",@"谷歌(google)",@"这是一句用来测试的文本"];
    AttributeView *attributeViewJT = [AttributeView attributeViewWithTitle:@"巨头" titleFont:[UIFont boldSystemFontOfSize:15] attributeTexts:jtData viewWidth:kScreenW andTag:dsData];
    self.attributeViewJT = attributeViewJT;
    
    // 创建国家属性视图
    NSArray *gjData = @[@"中国",@"美国",@"德国",@"韩国",@"英国",@"俄罗斯",@"越南",@"老挝",@"朝鲜",@"日本小岛"];
    AttributeView *attributeViewGJ = [AttributeView attributeViewWithTitle:@"国家" titleFont:[UIFont boldSystemFontOfSize:15] attributeTexts:gjData viewWidth:kScreenW andTag:dsData];
    self.attributeViewGJ = attributeViewGJ;
    
    // 这里不用设置attriButeView的frame, 只需要设置y值就可以了,而且Y值是必须设置的,高度是已经在内部计算好的.可以更改宽度.
    
    
    CGRect AAR = attributeViewDS.frame;
    AAR.origin.y = 0;
    attributeViewDS.frame = AAR;
    
    AAR = attributeViewJT.frame;
    AAR.origin.y = CGRectGetMaxY(attributeViewDS.frame) + 15;
    attributeViewJT.frame = AAR;
    
    
    AAR = attributeViewGJ.frame;
    AAR.origin.y = CGRectGetMaxY(attributeViewJT.frame) + 15;
    attributeViewGJ.frame = AAR;
    
    // 设置代理
    attributeViewDS.Attribute_delegate = self;
    attributeViewJT.Attribute_delegate = self;
    attributeViewGJ.Attribute_delegate = self;
    
    // 添加到scrollview上
    [scrollView addSubview:attributeViewDS];
    [scrollView addSubview:attributeViewJT];
    [scrollView addSubview:attributeViewGJ];

    scrollView.contentSize = (CGSize){0,[UIScreen mainScreen].bounds.size.height + 20};
    
    // 添加scrollview到当前view上
    [self.view addSubview:scrollView];
    // 通过动画设置scrollview的高度, 也可以一开始就设置好
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        scrollView.height += [UIScreen mainScreen].bounds.size.height - 30;
    } completion:nil];
}
#pragma mark - AttributeViewDelegate
- (void)Attribute_View:(AttributeView *)view didClickBtn:(UIButton *)btn andTag:(NSString *)mTag{
    // 判断, 根据点击不同的attributeView上的标签, 执行不同的代码
    NSString *title = btn.titleLabel.text;

    if (view.tag == 1001) {
        MLLog(@"tt%@",title);
        mReleaseTag = title;
        mTagId = mTag;
    }else{
        if (!btn.selected) {
            title = @"默认文字";
        }
        if ([view isEqual:self.attributeViewDS]) {
            
        }else if ([view isEqual:self.attributeViewJT]){
            
        }else{
            
        }
    }
    
    
    
}

- (void)okAction:(UIButton *)sender{
    
    self.block(mReleaseTag,mTagId);
    
    [self popViewController];
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
