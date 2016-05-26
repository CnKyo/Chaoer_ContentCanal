//
//  NFPickerView.h
//  NFPickerView
//
//  Created by A_Dirt on 16/5/9.
//  Copyright © 2016年 A_Dirt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NFPickerViewDelegete <NSObject>

-(void)pickerDidSelectProvinceName:(NSString *)provinceName andProvinId:(int)ProvinceId cityName:(NSString *)cityName andArearId:(int)ArearId countrys:(NSString *)countrys andCityId:(int)CityId;

@end
@interface NFPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,retain)UIButton *cancelbtn;
@property(nonatomic,retain)UIButton *surebtn;
@property (nonatomic,retain) id<NFPickerViewDelegete> delegate;

@property (strong,nonatomic) NSArray *mProvinceArr;

@property (strong,nonatomic) NSArray *mArearArr;

@property (strong,nonatomic) NSArray *mCityArr;

- (id)initWithFrame:(CGRect)frame andArr:(NSArray *)mArr;


-(void)show;
//消失
-(void)dismmis;

@end
