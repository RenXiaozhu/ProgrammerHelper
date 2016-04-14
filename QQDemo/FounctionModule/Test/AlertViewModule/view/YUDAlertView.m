//
//  YUDAlertView.m
//  SmartBascketball
//
//  Created by 王傲 on 16/4/5.
//  Copyright © 2016年 yundongsports.com. All rights reserved.
//

#import "YUDAlertView.h"

typedef enum
{
    UIStructTypeOnlyCancel,
    UIStructTypeTwoButton,
    UIStructTypeMoreThanTwoBuuton
}UIStructType;

@interface YUDAlertView ()

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) NSInteger buttonCount;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *heightArr;
@end

@implementation YUDAlertView

- (NSMutableArray *)viewArray
{
    if (_viewArray == nil)
    {
        _viewArray = [[NSMutableArray alloc]init];
    }
    return _viewArray;
}

- (NSMutableArray *)titles
{
    if (_titles == nil)
    {
        _titles = [[NSMutableArray alloc]init];
    }
    return _titles;
}

- (NSMutableArray *)heightArr
{
    if (_heightArr == nil)
    {
        _heightArr = [[NSMutableArray alloc]init];
    }
    return _heightArr;
}

- (nullable instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles
{




    self = [super initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH-40,1)];
    if (self)
    {
        [self.titles addObject:title?title:@""];
        [self.titles addObject:message?message:@""];
        [self.titles addObjectsFromArray:otherButtonTitles?otherButtonTitles:@[]];
        [self.titles addObject:cancelButtonTitle?cancelButtonTitle:@"取消"];

        [self loadUI];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self loadUI];
}

- (void)loadUI
{
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, [self calculateTotalHeight])];
    [self setBackgroundColor:[UIColor colorWithHexString:@"#fefefe"]];
    [self setCenter:CGPointMake(SCREEN_WIDTH/2,  -self.frame.size.height/2)];
     self.layer.masksToBounds = YES;
     self.layer.cornerRadius      = 3.0;
     self.layer.borderWidth       = 1.0;
     self.layer.borderColor        = [UIColor lightGrayColor].CGColor;

    if (!self.viewArray)
    {
        for (int i = 0; i<self.titles.count; i++)
        {
            if (i<2)
            {
                UILabel *btn = [[UILabel alloc]init];
                [btn setBackgroundColor: [UIColor clearColor]];
                [btn setText:self.titles[i]];
                [btn setTextColor:[UIColor colorWithHexString:@"#cecece"]];
                [btn setFont:[UIFont systemFontOfSize:14]];
                [btn setFrame:CGRectMake(0, 0, self.width, [self.heightArr[i] floatValue])];
                [btn setTag:i];
//                [[btn layer] setMasksToBounds:YES];
//                [[btn layer] setBorderColor:[UIColor lightGrayColor].CGColor];
//                [[btn layer] setBorderWidth:1.0];
                [self addSubview:btn];
            }
            else
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundColor: [UIColor clearColor]];
                [btn setTitle: self.titles[i] forState: UIControlStateNormal];
                [btn setTitleColor: [UIColor colorWithHexString:@"#cecece"] forState: UIControlStateNormal];
                [[btn titleLabel] setFont:[UIFont systemFontOfSize:14]];
                [btn setFrame:CGRectMake(0, 0, self.width, [self.heightArr[i] floatValue])];
                [btn setTag:i];
                [[btn layer] setMasksToBounds:YES];
                [[btn layer] setBorderColor:[UIColor lightGrayColor].CGColor];
                [[btn layer] setBorderWidth:1.0];
                [btn addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }

        }
    }

}



- (void)show
{

    [[[UIApplication sharedApplication] keyWindow] addSubview:self];

    [UIView animateWithDuration:1.2 animations:^{

        [self setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];

        CGFloat offsetHeight = 0;

        for (int i = 0; i<self.viewArray.count; i++)
        {
            offsetHeight = offsetHeight + [self.heightArr[i] floatValue]/2;
            if (i<2)
            {
                UILabel *label = self.viewArray[i];
                [label setCenter:CGPointMake(label.centerX, offsetHeight)];
            }
            else
            {
                UIButton *btn = self.viewArray[i];
                [btn setCenter:CGPointMake(btn.centerX, offsetHeight)];
            }

            offsetHeight += [self.heightArr[i] floatValue];
        }

    }];

}



- (void)disappearFromWindow
{
        [UIView animateWithDuration:0.6 animations:^{
            [self setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT+self.height)];
        }];
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)doAction:(UIButton *)btn
{
    if (btn.tag == self.titles.count-1)
    {
        [self disappearFromWindow];
    }
    else
    {
        self.actionBlock(btn.tag);
        [self disappearFromWindow];
    }
}

- (CGFloat)calculateTotalHeight
{

    CGFloat height = 80;

    for (NSString *text in self.titles)
    {
        CGRect rect = [text boundingRectWithSize:CGSizeMake( SCREEN_WIDTH-40-20, 100) options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                   context:nil];
        if (rect.size.height)
        {
            height = rect.size.height;
        }
        [self.heightArr addObject:@(height)];
    }

    return height;
}

@end
