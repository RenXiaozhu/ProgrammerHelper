//
//  YUDAlertView.h
//  SmartBascketball
//
//  Created by 王傲 on 16/4/5.
//  Copyright © 2016年 yundongsports.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(NSInteger buttonIndex);

@interface YUDAlertView : UIView
@property ( nullable,nonatomic, strong)   ActionBlock actionBlock ;

- (nullable instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message  cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles;

- (void)show;

@end
