//
//  SPTextField.m
//  shiji
//
//  Created by 王博 on 16/10/26.
//  Copyright © 2016年 xyz.r4l All rights reserved.
//

#import "SPTextField.h"

#define tRegex(TARGET,REGEX) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",REGEX]evaluateWithObject:TARGET]
@implementation SPTextField
@synthesize textFieldTintColor=_textFieldTintColor;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initStyle];
        

    }
    return self;
}
-(void)initStyle
{
    self.textFieldTintColor = [UIColor colorWithRed:204/255.0 green:162/255.0 blue:93/255.0 alpha:1];
    self.placeholderColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.warningColor = [UIColor colorWithRed:239/255.0 green:76/255.0 blue:59/255.0 alpha:1];
    
}
-(void)setTextFieldTintColor:(UIColor *)textFieldTintColor{
    _textFieldTintColor = textFieldTintColor;
    [self.textField setTintColor:self.textFieldTintColor];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
}
-(void)setSeparatorColor:(UIColor *)separatorColor{
    
}
+(SPTextField *)spTextFieldWithWidth:(CGFloat)width placeholder:(NSString *)placeholdStr delegate:(id<SPTextFieldDelegate>)delegate{
    static const CGFloat defaultViewHeight=60;
    static const CGFloat defaultTextFieldHeight=30;
    static const CGFloat defaultGapH=5;
    static const CGFloat defaultGapV=5;
    static const CGFloat defaultLayerHeight=20;
    static const CGFloat defaultLayerFontSize=14;
    SPTextField *stf=[[SPTextField alloc]initWithFrame:CGRectMake(0, 0, width, defaultViewHeight)];
    stf.textField=[[UITextField alloc]initWithFrame:CGRectMake(defaultGapH, defaultViewHeight-defaultTextFieldHeight-defaultGapV, stf.frame.size.width-2*defaultGapH, defaultTextFieldHeight)];
    [stf addSubview:stf.textField];
    [stf.textField setTintColor:stf.textFieldTintColor];
    stf.placeholdStr=placeholdStr;
    stf.placeholdLayer=[CATextLayer new];
    [stf.placeholdLayer setForegroundColor:stf.placeholderColor.CGColor];
    [stf.placeholdLayer setBounds:CGRectMake(0, 0, stf.textField.frame.size.width, defaultLayerHeight)];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:defaultLayerFontSize]};
    [stf.placeholdStr boundingRectWithSize:stf.textField.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    [stf.placeholdLayer setPosition:CGPointMake(stf.placeholdLayer.frame.size.width/2+defaultGapH, stf.textField.center.y)];
    [stf.placeholdLayer setContentsScale:[UIScreen mainScreen].scale];
    [stf.placeholdLayer setString:stf.placeholdStr];
    [stf.placeholdLayer setFontSize:defaultLayerFontSize];
    [stf.layer addSublayer:stf.placeholdLayer];
    stf.delegate=delegate;
    [stf.textField addTarget:stf action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    stf.defaultSeparator=[CALayer new];
    [stf.defaultSeparator setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor];
    [stf.defaultSeparator setFrame:CGRectMake(stf.textField.frame.origin.x, stf.frame.size.height-1, stf.textField.frame.size.width, 0.5)];
    [stf.layer addSublayer:stf.defaultSeparator];
    [stf.defaultSeparator setHidden:YES];
    return stf;
}
-(void)setPlaceHolder:(NSString*)p regex:(NSString*)r blankErr:(NSString *)b formatErr:(NSString *)f{
    self.placeholdStr=p;
    self.regexStr=r;
    self.blankErrStr=b;
    self.formatErrStr=f;
}
-(void)setRegex:(NSString*)r blankErr:(NSString *)b formatErr:(NSString *)f{
    self.regexStr=r;
    self.blankErrStr=b.length>0?b:self.placeholdStr;
    self.formatErrStr=f.length>0?f:self.placeholdStr;
}
-(void)textFieldTextChanged:(UITextField *)sender{
    if (sender.text.length>0) {
        [self shrinkRect];
    }
    else{
        [self resetRect];
        [self resetMessage];
    }
    if ([self.delegate respondsToSelector:@selector(spTextField:)]) {
        [self.delegate spTextField:self];
    }
}
#pragma mark Public Method
-(void)alertMessage:(NSString *)alertStr{
    [_placeholdLayer setString:alertStr];
    [_placeholdLayer setForegroundColor:self.warningColor.CGColor];
    CGPoint orig=_placeholdLayer.position;
    CAKeyframeAnimation *keyFrameAnime=[CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    [keyFrameAnime setDuration:0.6];
    [keyFrameAnime setValues:@[@(orig.x+30),@(orig.x-30),@(orig.x+10),@(orig.x-10),@(orig.x)]];
    [_placeholdLayer addAnimation:keyFrameAnime forKey:@"alert"];
    
}
-(void)resetMessage{
    [_placeholdLayer setString:_placeholdStr];
    [_placeholdLayer setForegroundColor:self.placeholderColor.CGColor];

}
-(void)shrinkRect{
    [self resetMessage];
    CATransform3D t=CATransform3DIdentity;
    t=CATransform3DScale(t, 0.7, 0.7, 1);
    t=CATransform3DTranslate(t, -0.3*self.placeholdLayer.frame.size.width/2/0.7, -25/0.7, 0);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.placeholdLayer setTransform:t];
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)resetRect{
    [self resetMessage];
    [UIView animateWithDuration:0.3 animations:^{
        [self.placeholdLayer setTransform:CATransform3DIdentity];
    }];
}
-(BOOL)checkTextQuiet{
    BOOL isRight=YES;
    NSMutableString *noSpaceStr=[[NSMutableString alloc]initWithString:self.textField.text];
    [noSpaceStr replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, noSpaceStr.length)];
    NSString *text=noSpaceStr;
    if (!tRegex(text, self.regexStr)) {
        isRight=NO;
    }
    return isRight;
}
-(BOOL)checkText{
    BOOL isRight=YES;
    NSMutableString *noSpaceStr=[[NSMutableString alloc]initWithString:self.textField.text];
    [noSpaceStr replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, noSpaceStr.length)];
    NSString *text=noSpaceStr;
    if (!tRegex(text, self.regexStr)) {
        isRight=NO;
        if (text.length!=0){
            [self alertMessage:self.formatErrStr];
        }
        else{
            [self alertMessage:self.blankErrStr];
        }
    }
    return isRight;
}
-(NSString *)text{
    return self.textField.text;
}
-(void)setPlaceholdStr:(NSString *)placeholdStr{
    _placeholdStr=placeholdStr;
    [_placeholdLayer setString:_placeholdStr];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation UITextField (SPTextField)

-(SPTextField *)sp_owner{
    if ([self.superview isKindOfClass:[SPTextField class]]) {
        return (SPTextField*)self.superview;
    }
    return nil;
}

@end

