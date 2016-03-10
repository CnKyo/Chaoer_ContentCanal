//
//  homeViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "homeViewController.h"


#import "DCPicScrollView.h"
#import "DCWebImageManager.h"

#import "homeTableViewCell.h"

#import "mCustomHomeView.h"
@interface homeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation homeViewController
{
    UITableView *mTableView;
    
    UIView  *mHeaderView;
    
    DCPicScrollView  *mScrollerView;
    
    NSMutableArray  *mTempArr;
    
    
    
    mCustomHomeView *mCustomBtn;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = @"新订单";
    self.navBar.hidden = YES;
    self.hiddenBackBtn = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    
    mTempArr = [NSMutableArray new];
    
    
    [self initview];
}

- (void)initview{
    
    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-50);
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    
    
    UINib   *nib = [UINib nibWithNibName:@"homeTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self loadHeaderView];

    
}
- (void)loadHeaderView{

    mHeaderView = [UIView new];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 500);
    mHeaderView.backgroundColor = [UIColor whiteColor];

    [self loadScrollerView];

    UIView  *bgkView = [UIView new];
    bgkView.frame = CGRectMake(0, mScrollerView.mbottom, DEVICE_Width, 15);
    bgkView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    [mHeaderView addSubview:bgkView];
    
    
    float x = 0;
    float y = bgkView.mbottom;

    float btnWidth = DEVICE_Width/3;
    
    for (int i = 0; i<5; i++) {
        
        UIButton    *btn = [UIButton new];
        btn.frame = CGRectMake(x, y, btnWidth, 110);
        [btn setImage:[UIImage imageNamed:@"79"] forState:0];
        [btn setTitle:@"what" forState:0];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1] forState:0];
        btn.imageEdgeInsets  = UIEdgeInsetsMake(-20, 24, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(90, -50, 20, 0);

        [btn setBackgroundColor:[UIColor whiteColor] forUIControlState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor] forUIControlState:UIControlStateSelected];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(mCusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [mHeaderView addSubview:btn];
        
        x += btnWidth;
        
        if (x >= DEVICE_Width) {
            x = 0;
            y += 110;
        }
        
        
    }
    
    CGRect  mRect = mHeaderView.frame;
    mRect.size.height = y+110;
    mHeaderView.frame = mRect;
    
    [mTableView setTableHeaderView:mHeaderView];
    
}
- (void)mCusBtnAction:(UIButton *)sender{
    NSLog(@"第%ld个",(long)sender.tag);
}
- (void)loadScrollerView{
    
    for ( UIButton * btn in mHeaderView.subviews) {
        [btn removeFromSuperview];
    }
    
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    
    
    for (int i = 1; i < 6; i++) {
        [arr2 addObject:[NSString stringWithFormat:@"%d.jpg",i*111]];
    };
    
    
    //网络加载
    
    NSArray *UrlStringArray = @[@"http://p1.qqyou.com/pic/UploadPic/2013-3/19/2013031923222781617.jpg",
                                @"http://cdn.duitang.com/uploads/item/201409/27/20140927192649_NxVKT.thumb.700_0.png",
                                @"http://img4.duitang.com/uploads/item/201409/27/20140927192458_GcRxV.jpeg",
                                @"http://cdn.duitang.com/uploads/item/201304/20/20130420192413_TeRRP.thumb.700_0.jpeg"];
    
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置
    mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, DEVICE_Width, 150) WithImageUrls:UrlStringArray];
    
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    
    //占位图片,你可以在下载图片失败处修改占位图片
    mScrollerView.placeImage = [UIImage imageNamed:@"place.png"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    
    [mScrollerView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
    }];
    
    //default is 2.0f,如果小于0.5不自动播放
    mScrollerView.AutoScrollDelay = 2.5f;
    //    picView.textColor = [UIColor redColor];
    
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
    
    [mHeaderView addSubview:mScrollerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";

    homeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];


    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
