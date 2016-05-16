//
//  AttributeCollectionView.m
//  天巢新1期
//
//  Created by 唐建平 on 15/12/15.
//  Copyright © 2015年 JP. All rights reserved.
//

#import "AttributeView.h"
#import "UIView+Extnesion.h"

#define AppColor  [UIColor colorWithRed:0.90 green:0.49 blue:0.15 alpha:1.00]

#define margin 15
// 屏幕的宽
#define JPScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define JPScreenH [UIScreen mainScreen].bounds.size.height
//RGB
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface AttributeView ()

@property (nonatomic ,weak) UIButton *btn;
@end

@implementation AttributeView

/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @param viewWidth 视图宽度
 *
 *  @return attributeView
 */
+ (AttributeView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth andTag:(NSArray *)mTagArr{
    int count = 0;
    float btnW = 0;
    

    
    AttributeView *view = [[AttributeView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *line1 = [UIView new];
    line1.frame = CGRectMake(10, 20, viewWidth/2-50, 0.5);
    line1.backgroundColor = [UIColor colorWithRed:0.52 green:0.52 blue:0.52 alpha:0.45];
    [view addSubview:line1];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@ : ",title];
    label.font = font;
    label.textColor = Color(160, 160, 160);
    label.frame = (CGRect){{line1.frame.size.width+line1.frame.origin.x+20,10},{40,20}};
    [view addSubview:label];
    
    
    UIView *line2 = [UIView new];
    line2.frame = CGRectMake(label.frame.origin.x+label.frame.size.width+20, 20, viewWidth/2-50, 0.5);
    line2.backgroundColor = [UIColor colorWithRed:0.52 green:0.52 blue:0.52 alpha:0.45];
    [view addSubview:line2];
    
    for (int i = 0; i<texts.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        
        NSString *mtag = mTagArr[i];
        
        btn.tag = [mtag integerValue];
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        NSString *str = texts[i];
        [btn setTitle:str forState:UIControlStateNormal];
        CGSize strsize = [str sizeWithFont:[UIFont boldSystemFontOfSize:13]];
        
        
        CGRect  btnRect = btn.frame;
        btnRect.size.width = strsize.width + margin;
        btnRect.size.height = strsize.height+ margin;
        btn.frame = btnRect;
        
        
        if (i == 0) {
            
            btnRect.origin.x = margin;
            btn.frame = btnRect;
            
            btnW += CGRectGetMaxX(btn.frame);
        }
        else{
            btnW += CGRectGetMaxX(btn.frame)+margin;
            if (btnW > viewWidth) {
                count++;
                btnRect.origin.x = margin;
                btn.frame = btnRect;
                btnW = CGRectGetMaxX(btn.frame);
            }
            else{
                btnRect.origin.x += btnW-btn.frame.size.width;
                btn.frame = btnRect;
                
                
            }
        }
        btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:Color(104, 97, 97) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        btnRect.origin.y += count * (btn.frame.size.height + margin) + margin + label.frame.size.height +8;

        btn.frame = btnRect;
        
        btn.layer.cornerRadius = 15;
        btn.layer.borderColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.clipsToBounds = YES;
        [view addSubview:btn];
        if (i == texts.count - 1) {
            
            btnRect = view.frame;
            btnRect.size.height = CGRectGetMaxY(btn.frame) + 10;
            btnRect.origin.x = 0;
            btnRect.size.width = viewWidth;
            view.frame = btnRect;
        }
    }
    return view;
}

- (void)btnClick:(UIButton *)sender{
    if (![self.btn isEqual:sender]) {
        self.btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
        self.btn.selected = NO;
        sender.backgroundColor = AppColor;
        sender.selected = YES;
    }else if([self.btn isEqual:sender]){
        if (sender.selected == YES) {
            sender.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
            sender.selected = NO;
        }else{
            sender.backgroundColor = AppColor;
            sender.selected = YES;
        }
    }else{
        
    }
    if ([self.Attribute_delegate respondsToSelector:@selector(Attribute_View:didClickBtn:andTag:)] ) {
        [self.Attribute_delegate Attribute_View:self didClickBtn:sender andTag:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
    self.btn = sender;
    
}

@end
