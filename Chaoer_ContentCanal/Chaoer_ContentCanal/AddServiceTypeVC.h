//
//  AddServiceTypeVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddServiceTypeVC : BaseVC

@property (nonatomic,strong) SGoodsCate *mCate;
@property (weak, nonatomic) IBOutlet UILabel *mType;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTableViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *mTypeName;
@property (nonatomic,assign) int type;

@property (nonatomic,strong) void(^block)(BOOL flag);

- (IBAction)OpenTypeClick:(id)sender;
@end
