//
//  WKLabelView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewWithBgViewDidSelectedDelegate <NSObject>

@optional

- (void)viewDidSelectedIndex:(NSInteger)mIndex;

- (void)currentViewArray:(NSArray *)mArr;

@end
@interface WKLabelView : UIView
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)NSArray *array;//存放的集合
@property(nonatomic,strong)void(^block)(UIButton *button,NSString *string,NSInteger mIndex);//block传值

@property(strong,nonatomic) id <ViewWithBgViewDidSelectedDelegate> delegate;

@property (strong,nonatomic)NSMutableArray *mCureentArr;

@property (assign,nonatomic) CGFloat mHight;
@end
