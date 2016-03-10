//
//  ReplyView.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/5.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"

@interface ReplyView : UIView
@property (weak, nonatomic) IBOutlet IQTextView *mReply;
@property (weak, nonatomic) IBOutlet UIButton *mCancel;
@property (weak, nonatomic) IBOutlet UIButton *mOK;
@property (weak, nonatomic) IBOutlet UILabel *mtitle;


+ (ReplyView *)shareView;

+(void)showInVC:(UIViewController*)vc block:(void(^)(NSString* text))block;

@end
