//
//  WKChoiceArearView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKChoiceArearDelegate <NSObject>

@optional

- (void)WKCancelAction;

- (void)WKOKAction;

@end

@interface WKChoiceArearView : UIView

@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;

@property (weak, nonatomic) IBOutlet UIView *mPickView;

@property (weak, nonatomic) id <WKChoiceArearDelegate>delegate;

+ (WKChoiceArearView *)shareView;

@end
