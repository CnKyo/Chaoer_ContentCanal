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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"筛选";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    

    
    [self initView];
    
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
    AttributeView *attributeViewDS = [AttributeView attributeViewWithTitle:@"电商" titleFont:[UIFont boldSystemFontOfSize:15] attributeTexts:dsData viewWidth:kScreenW];
    self.attributeViewDS = attributeViewDS;
    
    // 创建巨头属性视图
    NSArray *jtData = @[@"腾讯",@"阿里巴巴",@"百度",@"谷歌(google)",@"这是一句用来测试的文本"];
    AttributeView *attributeViewJT = [AttributeView attributeViewWithTitle:@"巨头" titleFont:[UIFont boldSystemFontOfSize:15] attributeTexts:jtData viewWidth:kScreenW];
    self.attributeViewJT = attributeViewJT;
    
    // 创建国家属性视图
    NSArray *gjData = @[@"中国",@"美国",@"德国",@"韩国",@"英国",@"俄罗斯",@"越南",@"老挝",@"朝鲜",@"日本小岛"];
    AttributeView *attributeViewGJ = [AttributeView attributeViewWithTitle:@"国家" titleFont:[UIFont boldSystemFontOfSize:15] attributeTexts:gjData viewWidth:kScreenW];
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
- (void)Attribute_View:(AttributeView *)view didClickBtn:(UIButton *)btn{
    // 判断, 根据点击不同的attributeView上的标签, 执行不同的代码
    
    
    NSString *title = btn.titleLabel.text;
    if (!btn.selected) {
        title = @"默认文字";
    }
    if ([view isEqual:self.attributeViewDS]) {
        
    }else if ([view isEqual:self.attributeViewJT]){
        
    }else{
        
    }
    
}

- (void)okAction:(UIButton *)sender{

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
