//
//  ReplyView.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/5.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "ReplyView.h"

@interface ReplyView ()

@property (nonatomic,strong)    UIView* mitbg;
@property (nonatomic,strong)    void(^mitblock)(NSString*txt);

@end
@implementation ReplyView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    _mReply.layer.borderColor = M_LINECO.CGColor;
    _mReply.layer.borderWidth = 0.8;
    _mReply.layer.cornerRadius = 3;
}

+ (ReplyView *)shareView{
    
    ReplyView *view = [[[NSBundle mainBundle]loadNibNamed:@"ReplyView" owner:self options:nil]objectAtIndex:0];
    return view;
    
}

+(void)showInVC:(UIViewController*)vc block:(void(^)(NSString* text))block
{
    
    UIView* replyBgView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height)];
    [vc.view addSubview:replyBgView];
    replyBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    ReplyView* replyView = [ReplyView shareView];
    replyView.layer.masksToBounds = YES;
    replyView.layer.cornerRadius = 5;
    
    CGRect rect = replyView.frame;
    rect.origin.x = 15;
    rect.origin.y = DEVICE_Height;
    rect.size.width = DEVICE_Width-30;
    rect.size.height = DEVICE_Width * (232.0f/320.0f);
    replyView.frame = rect;
    [vc.view addSubview:replyView];
    
    
    replyView.mitblock = block;
    replyView.mtitle.text = @"备注";
    replyView.mReply.placeholder = @"请输入备注";
    
    [replyView.mCancel addTarget:replyView action:@selector(canbt:) forControlEvents:UIControlEventTouchUpInside];
    [replyView.mOK addTarget:replyView action:@selector(okbt:) forControlEvents:UIControlEventTouchUpInside];
    replyView.mitbg = replyBgView;
    
    replyBgView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    [UIView animateWithDuration:0.2 animations:^{
        
        replyView.center = replyBgView.center;
        CGRect rect2 = replyView.frame;
        replyView.frame = rect2;
        
        
    }];
    
    
}

-(void)okbt:(UIButton*)bt
{
    if(  self.mReply.text.length == 0  )
    {
        [SVProgressHUD showErrorWithStatus:@"请先输入备注"];
        return;
    }
    
    if( _mitblock )
        _mitblock( self.mReply.text );
    [self hidenit];
}


-(void)canbt:(UIButton*)bt
{
    [self hidenit];
}

-(void)hidenit
{
    self.mReply.text = @"";
    self.mitbg.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height);
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect2 = self.frame;
        rect2.origin.y = DEVICE_Height;
        self.frame = rect2;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.mitbg removeFromSuperview];
        self.mitbg = nil;
        
    }];
}




@end
