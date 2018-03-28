//
//  SPTextField.h
//  shiji
//
//  Created by 王博 on 16/10/26.
//  Copyright © 2016年 com.dtfunds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPTextField;
@protocol SPTextFieldDelegate <NSObject>
@optional
-(void)spTextField:(SPTextField *)textField;
@end




@interface SPTextField : UIView
@property (nonatomic,strong)UITextField *textField;
//占位符
@property (nonatomic,strong)CATextLayer *placeholdLayer;
@property (nonatomic,weak)id<SPTextFieldDelegate> delegate;
//默认占位符的字符串
@property (nonatomic,strong)NSString *regexStr;

@property (nonatomic,strong)NSString *placeholdStr;
@property (nonatomic,strong)NSString *blankErrStr;
@property (nonatomic,strong)NSString *formatErrStr;

//样式
@property (nonatomic,strong)UIColor *textFieldTintColor,*placeholderColor,*warningColor;

@property (nonatomic,strong)CALayer *defaultSeparator;

//提示信息
-(void)alertMessage:(NSString *)alertStr;
//重置占位符
-(void)resetMessage;
//缩小占位符
-(void)shrinkRect;
//重置占位符位置
-(void)resetRect;
-(BOOL)checkText;
-(BOOL)checkTextQuiet;
+(SPTextField *)spTextFieldWithWidth:(CGFloat)width placeholder:(NSString *)placeholdStr delegate:(id<SPTextFieldDelegate>)delegate;
-(void)setPlaceHolder:(NSString*)p regex:(NSString*)r blankErr:(NSString *)b formatErr:(NSString *)f;
-(void)setRegex:(NSString*)r blankErr:(NSString *)b formatErr:(NSString *)f;
-(NSString *)text;
@end

@interface UITextField(SPTextField)
//获取对应的SPTextField
-(SPTextField *)sp_owner;
@end
