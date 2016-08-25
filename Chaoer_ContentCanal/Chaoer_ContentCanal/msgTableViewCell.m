//
//  msgTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "msgTableViewCell.h"

@implementation msgTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMmsg:(GMsgObj *)mmsg{

    if (mmsg.mType == 3) {
        self.mLogo.image = [UIImage imageNamed:@"system_msg"];
    }else if(mmsg.mType == 2){
        self.mLogo.image = [UIImage imageNamed:@"fix_msg"];
    }else{
        
        self.mLogo.image = [UIImage imageNamed:@"money_msg"];
    }
    
    
    self.mPoint.hidden = mmsg.mIsRead?YES:NO;
    
    
    self.mDetail.text = mmsg.mMsg_content;
    self.mTitle.text = mmsg.mMsg_title;
    
    self.mTime.text = mmsg.mGen_time;
    
    
    self.mCellH = 47 + [Util labelText:mmsg.mMsg_content fontSize:14 labelWidth:self.mDetail.mwidth];
}

@end
