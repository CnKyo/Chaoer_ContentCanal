//
//  MovieAddComment.m
//  qukan43
//
//  Created by yang on 15/12/3.
//  Copyright © 2015年 ReNew. All rights reserved.
//

#import "MovieAddComment.h"
#import "mTagButton.h"
@implementation MovieAddComment


{

    int mTotle;
    int mSpeed;
    int mMass;
    
    
    NSMutableArray *mIds;
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame andArray:(NSArray *)mArr

{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MovieAddComment1"
                                                       owner:self
                                                     options:nil];
        
        self.v_addcomment = [array objectAtIndex:0];
        self.v_addcomment.frame = self.bounds;
        [self addSubview:self.v_addcomment];

        mIds = [NSMutableArray new];
        
        self.v_count.layer.cornerRadius = self.v_count.frame.size.height/2;
        self.v_count.layer.borderWidth = 1.0;
        
        self.v_count.layer.borderColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0].CGColor;
        self.count = -1;
 
        self.mCommitBtn.layer.masksToBounds = YES;
        self.mCommitBtn.layer.cornerRadius = 3;
        
        [self.mCommitBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        mTotle = 0;
        mSpeed = 0;
        mMass = 0;
        
        for (UIButton *nnn in self.mTagView.subviews) {
            [nnn removeFromSuperview];
        }
        

       
        CGFloat LW = self.mTagView.mwidth/3-15;
        
        CGFloat mXX = 5;
        CGFloat mYY = 2;;
        
        for ( int i = 0; i<mArr.count; i++) {
            
            GSystemTags *mTag = mArr[i];
            
      
            mTagButton *lll = [mTagButton new];
            
            lll.frame = CGRectMake(mXX, mYY, LW-10, 25);
            lll.titleLabel.font = [UIFont systemFontOfSize:14];
            [lll setTitle:mTag.mTagName forState:0];
            
            lll.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            lll.layer.masksToBounds = YES;
            lll.layer.cornerRadius = 12;
            
            
            [lll setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [lll setTitleColor:[UIColor colorWithRed:0.55 green:0.75 blue:0.94 alpha:1.00] forState:UIControlStateNormal];
            
            [lll setBackgroundImage:[UIImage imageNamed:@"ppt_system_tag_nomal"] forState:UIControlStateNormal];
            [lll setBackgroundImage:[UIImage imageNamed:@"ppt_system_tag_selected"] forState:UIControlStateSelected];

            
            lll.mTag = mTag;
            
            
            [lll addTarget:self action:@selector(tagAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.mTagView addSubview:lll];
            
            mXX += LW;
            
            if (mXX >= DEVICE_Width-LW) {
                mXX = 5;
                mYY += 30;
            }
            
        }

        

    }
    return self;
}

- (void)tagAction:(mTagButton *)sender{

    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [mIds addObject:sender.mTag.mTagName];
    }else{
        
        [mIds removeObject:sender.mTag.mTagName];
    }
    
    
}

#pragma mark----提交评价
- (void)commitAction:(UIButton *)sender{

    
    NSString *mTagIds = @"";
    for (int i =0;i<mIds.count;i++) {
        
        NSString *str = mIds[i];
        if (i == mIds.count-1) {
            mTagIds = [mTagIds stringByAppendingString:[NSString stringWithFormat:@"%@",str]];
        }else{
            mTagIds = [mTagIds stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
        }
        
        
    }
    
    MLLog(@"提交");
    
    if (mSpeed == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择速度评分！"];
        return;
    }
    if (mMass == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品质量评分！"];
        return;
    }
    if (mIds.count<=0) {
        [SVProgressHUD showErrorWithStatus:@"请选择标签！"];
        return;
    }
    if(self.mContent.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入评价内容！"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];
    [[mUserInfo backNowUser] rateOrder:[mUserInfo backNowUser].mUserId andLegUserId:[mUserInfo backNowUser].mLegworkUserId andSpeed:mSpeed andMass:mMass andOrderCode:self.mOrder.mOrderCode andOrderType:self.mType andContent:self.mContent.text andTags:mTagIds block:^(mBaseData *resb) {
        [SVProgressHUD dismiss];
        [self.delegate isSucess:resb.mSucess];
        
    }];
    
    
    
}
-(IBAction)hidKeyboard:(id)sender{
    [self endEditing:YES];
    
}

-(void)cleamCount{
    self.v_count.hidden = YES;
    self.count = -1;
    
    [self.img_star1 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.img_star2 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.img_star3 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.img_star4 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.img_star5 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    
    [self.mSpeed1 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.mSpeed2 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.mSpeed3 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.mSpeed4 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.mSpeed5 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    
    [self.mMass1 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.mMass2 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.mMass3 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.mMass4 setImage:[UIImage imageNamed:@"StarUnSelect"]];
    [self.mMass5 setImage:[UIImage imageNamed:@"StarUnSelect"]];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.v_star];
    if((point.x>0 && point.x<self.v_star.frame.size.width)&&(point.y>0 && point.y<self.v_star.frame.size.height)){
        self.canAddStar = YES;
        [self changeStarForegroundViewWithPoint:point];
        
    }else{
        self.canAddStar = NO;
    }
    
    UITouch *touch1 = [touches anyObject];
    
    CGPoint  point1 = [touch1 locationInView:self.mSpeedView];
    if((point1.x>0 && point1.x<self.mSpeedView.frame.size.width)&&(point1.y>0 && point1.y<self.mSpeedView.frame.size.height)){
        self.canAddStar = YES;
        [self changeStarForegroundViewWithPoint1:point1];
        
    }else{
        self.canAddStar = NO;
    }
    UITouch *touch2 = [touches anyObject];
    
    CGPoint  point2 = [touch2 locationInView:self.mMassView];
    if((point2.x>0 && point2.x<self.mMassView.frame.size.width)&&(point2.y>0 && point2.y<self.mMassView.frame.size.height)){
        self.canAddStar = YES;
        [self changeStarForegroundViewWithPoint2:point2];
        
    }else{
        self.canAddStar = NO;
    }
    
    point2 = [touch2 locationInView:self.mCancle];
    if((point2.x>0 && point2.x<self.mCancle.frame.size.width)&&(point2.y>0 && point2.y<self.mCancle.frame.size.height)){
        self.canAddStar = YES;
        [self changeStarForegroundViewWithPoint2:point2];
        
    }else{
        self.canAddStar = NO;
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    if(self.canAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.v_star];
        [self changeStarForegroundViewWithPoint:point];
        
         point = [touch locationInView:self.mSpeedView];
        [self changeStarForegroundViewWithPoint1:point];

        
         point = [touch locationInView:self.mMassView];
        [self changeStarForegroundViewWithPoint2:point];

    
    }
   

    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.canAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.v_star];
        [self changeStarForegroundViewWithPoint:point];
        
        point = [touch locationInView:self.mSpeedView];
        [self changeStarForegroundViewWithPoint1:point];
        
        
        point = [touch locationInView:self.mMassView];
        [self changeStarForegroundViewWithPoint2:point];
    }
    
    self.canAddStar = NO;
    return;
}


-(void)changeStarForegroundViewWithPoint:(CGPoint)point{
    if(self.v_count.hidden){
        self.v_count.hidden = NO;
    }
    NSInteger count = 0;
    
    count = count + [self changeImg:point.x image:self.img_star1];
    count = count + [self changeImg:point.x image:self.img_star2];
    count = count + [self changeImg:point.x image:self.img_star3];
    count = count + [self changeImg:point.x image:self.img_star4];
    count = count + [self changeImg:point.x image:self.img_star5];
    if(count==0){
        count = 1;
        [self.img_star1 setImage:[UIImage imageNamed:@"StarSelectHeaf"]];
    }
    self.count = count;
    [self checkCount:count];
    if(count==10){
        self.lbl_count.text = @"10";
    }else{
        self.lbl_count.text = [NSString stringWithFormat:@"%ld",(long)count];
    }


    
}
-(void)changeStarForegroundViewWithPoint1:(CGPoint)point{
    NSInteger count1 = 0;
    
    
    count1 = count1 + [self changeImg:point.x image:self.mSpeed1];
    count1 = count1 + [self changeImg:point.x image:self.mSpeed2];
    count1 = count1 + [self changeImg:point.x image:self.mSpeed3];
    count1 = count1 + [self changeImg:point.x image:self.mSpeed4];
    count1 = count1 + [self changeImg:point.x image:self.mSpeed5];
    if(count1==0){
        count1 = 1;
        [self.mSpeed1 setImage:[UIImage imageNamed:@"StarSelectHeaf"]];
    }
    self.count = count1;
    [self checkCount1:count1];
    if(count1==10){
        self.lbl_count.text = @"10";
    }else{
        self.lbl_count.text = [NSString stringWithFormat:@"%ld",(long)count1];
    }
}
-(void)changeStarForegroundViewWithPoint2:(CGPoint)point{
    NSInteger count2 = 0;
    
    count2 = count2 + [self changeImg:point.x image:self.mMass1];
    count2 = count2 + [self changeImg:point.x image:self.mMass2];
    count2 = count2 + [self changeImg:point.x image:self.mMass3];
    count2 = count2 + [self changeImg:point.x image:self.mMass4];
    count2 = count2 + [self changeImg:point.x image:self.mMass5];
    if(count2==0){
        count2 = 1;
        [self.mMass1 setImage:[UIImage imageNamed:@"StarSelectHeaf"]];
    }
    self.count = count2;
    [self checkCount2:count2];
    if(count2==10){
        self.lbl_count.text = @"10";
    }else{
        self.lbl_count.text = [NSString stringWithFormat:@"%ld",(long)count2];
    }
}
-(void)checkCount:(NSInteger)count{

    switch (count) {
        case 1:
        case 2:
            self.lbl_counttext.text = @"不满意";
            mTotle = 1;

            break;
        case 3:
        case 4:
            self.lbl_counttext.text = @"很差";
            mTotle = 2;
            
            break;
        case 5:
        case 6:
            self.lbl_counttext.text = @"一般";
            mTotle = 3;
            
            break;
        case 7:
        case 8:
            self.lbl_counttext.text = @"不错";
            mTotle = 4;
            
            break;
        case 9:
        case 10:
            self.lbl_counttext.text = @"满意";
            mTotle = 5;

            break;
        default:
            break;
    }
}

-(void)checkCount1:(NSInteger)count{
    
    switch (count) {
        case 1:
        case 2:
            self.mSpeedLb.text = @"不满意";
            mSpeed = 1;
            break;
        case 3:
        case 4:
            self.mSpeedLb.text = @"很差";
            mSpeed = 2;
            break;
        case 5:
        case 6:
            self.mSpeedLb.text = @"一般";
            mSpeed = 3;
            break;
        case 7:
        case 8:
            self.mSpeedLb.text = @"不错";
            mSpeed = 4;
            break;
        case 9:
        case 10:
            self.mSpeedLb.text = @"满意";
            mSpeed = 5;
            break;
        default:
            break;
    }
}
-(void)checkCount2:(NSInteger)count{
    switch (count) {
        case 1:
        case 2:
            
            self.mMassLb.text = @"不满意";
            mMass = 1;

            break;
        case 3:
        case 4:
            self.mMassLb.text = @"很差";
            mMass = 2;

            break;
        case 5:
        case 6:
            
            self.mMassLb.text = @"一般";
            mMass = 3;

            break;
        case 7:
        case 8:
            
            self.mMassLb.text = @"不错";
            mMass = 4;

            break;
        case 9:
        case 10:
            self.mMassLb.text = @"满意";
            mMass = 5;

            break;
        default:
            break;
    }
}

-(NSInteger)changeImg:(float)x image:(UIImageView*)img{
    if(x> img.frame.origin.x + img.frame.size.width/2){
        [img setImage:[UIImage imageNamed:@"StarSelected"]];
        return 2;
    }else if(x> img.frame.origin.x){
        [img setImage:[UIImage imageNamed:@"StarSelectHeaf"]];
        return 1;
//        [self setImageAnimation:img];
    }else{
        [img setImage:[UIImage imageNamed:@"StarUnSelect"]];
        return 0;
    }
}

-(void)setImageAnimation:(UIView *)v{
    CGRect rec = v.frame;
    [UIView animateWithDuration:0.1 animations:^{
        v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y -3, v.frame.size.width, v.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            v.frame = rec;
        } completion:^(BOOL finished) {
            v.frame = rec;
        }];
    }];
}


-(IBAction)closeView:(id)sender{
    [self removeFromSuperview];
}


@end
