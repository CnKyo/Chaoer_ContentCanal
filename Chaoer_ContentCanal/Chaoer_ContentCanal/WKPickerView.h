//
//  WKPickerView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKPickerViewDelegate <NSObject>

- (void)WKPickerViewSelectedView:(NSDictionary *)obj;

-(void)pickerDidSelectProvinceName:(NSString *)provinceName andProvinId:(int)ProvinceId cityName:(NSString *)cityName andArearId:(int)ArearId countrys:(NSString *)countrys andCityId:(int)CityId;


@end


@interface WKPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,retain)UIButton *cancelbtn;
@property(nonatomic,retain)UIButton *surebtn;

@property (nonatomic,retain) id<WKPickerViewDelegate> delegate;

@property (strong,nonatomic) NSArray *mProvinceArr;

@property (strong,nonatomic) NSArray *mArearArr;

@property (strong,nonatomic) NSArray *mCityArr;

@property (strong,nonatomic) NSArray *mArr1;

- (id)initWithFrame:(CGRect)frame andArr:(NSArray *)mArr;


-(void)show;
//消失
-(void)dismmis;
@end
