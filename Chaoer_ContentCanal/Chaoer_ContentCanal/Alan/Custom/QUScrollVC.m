//
//  QUScrollVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "QUScrollVC.h"
#import "UIView+AutoSize.h"

@interface QUScrollVC ()

@end

@implementation QUScrollVC


-(void)loadView
{
    [super loadView];
    
    
    if (self.scrollView == nil) {
        self.scrollView = [self.view newUIScrollView];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
            //make.edges.equalTo(self.view);
            make.top.left.right.bottom.equalTo(self.view);
            //make.width.equalTo(self.view.width);
        }];
        
        UIView *contentView = [self.scrollView newUIView];
        contentView.tag = 101;
        contentView.backgroundColor = [UIColor clearColor];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.scrollContentView = contentView;
        [contentView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView);
            make.width.equalTo(_scrollView);
            //make.height.equalTo(_scrollView);
        }];
    }
    
//    self.scrollView.backgroundColor = [UIColor redColor];
//    self.scrollContentView.backgroundColor = [UIColor greenColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
