//
//  messageView.h
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/9.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messageView : UIView

@property (weak, nonatomic) IBOutlet UILabel *mTitiel;

@property (weak, nonatomic) IBOutlet UILabel *mtime;

@property (weak, nonatomic) IBOutlet UILabel *mcontent;

+ (messageView *)shareView;
@end
