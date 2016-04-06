//
//  RXZAnimationBtn.m
//  QQDemo
//
//  Created by 王傲 on 16/4/1.
//  Copyright © 2016年 任小柱. All rights reserved.
//

#import "RXZAnimationBtn.h"

@interface RXZAnimationBtn ()
@property (nonatomic, strong) UIImageView *actionImg;
@property (nonatomic, strong) NSMutableArray *palyImgs;
@property (nonatomic, assign) BOOL isselect;
@end

@implementation RXZAnimationBtn


- (UIImageView *)actionImg
{
    if (_actionImg == nil)
    {
        UIImage *img = GET_IMAGE_FROM_BUNDLE_PATH(@"1.png", @"atmImg");

        _actionImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  img.size.width/10, img.size.height/10)];
        [_actionImg setUserInteractionEnabled:YES];
        [_actionImg setAnimationDuration:0.2];
        [_actionImg setAnimationRepeatCount:1];
        [_actionImg setImage:img];
        
        [self addSubview:_actionImg];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(starAction:)];
        [_actionImg addGestureRecognizer:tap];


    }
    return _actionImg;
}

- (NSMutableArray *)palyImgs
{
    if (_palyImgs == nil)
    {
        _palyImgs = [[NSMutableArray alloc]init];
    }
    return _palyImgs;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadUI];
        [self setIsselect:NO];
    }

    return self;
}

- (void)setIsselect:(BOOL)isselect
{
    _isselect = isselect;
    [self loadImgs:isselect];
}

- (void)loadImgs:(BOOL)select
{
    [self.palyImgs removeAllObjects];
    if (select)
    {
        dispatch_async(dispatch_get_global_queue( 0 , DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{

            for (int i = 1; i<46; i++)
            {
                NSString *imgname = [NSString stringWithFormat:@"%d.png",i];
                UIImage *img          = GET_IMAGE_FROM_BUNDLE_PATH(imgname, @"atmImg");
                [self.palyImgs addObject:img];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.actionImg setAnimationImages: self.palyImgs];
                [self.actionImg startAnimating];
                [self.actionImg setImage: GET_IMAGE_FROM_BUNDLE_PATH(@"1.png", @"atmImg")];
            });

        });
    }
    else
    {
          dispatch_async(dispatch_get_global_queue( 0 , DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
              for (int i = 45; i>1  ; i--)
              {
                  NSString *imgname = [NSString stringWithFormat:@"%d.png",i];
                  UIImage *img          = GET_IMAGE_FROM_BUNDLE_PATH(imgname, @"atmImg");
                  [self.palyImgs addObject:img];
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.actionImg setAnimationImages: self.palyImgs];
                  [self.actionImg startAnimating];
                  [self.actionImg setImage: GET_IMAGE_FROM_BUNDLE_PATH(@"45.png", @"atmImg")];
              });

          });
    }
}

- (void)loadUI
{
    [self.actionImg setCenter:CGPointMake(self.width/2, self.height/2)];
    [self.actionImg setAnimationImages:self.palyImgs];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self loadUI];
}

- (void)starAction:(UITapGestureRecognizer *)tap
{
    if (_isselect)
    {
        [self setIsselect:NO];
    }
    else
    {
        [self setIsselect:YES];
    }

}

- (void)dealloc
{
    
    _actionImg = nil;
    _palyImgs  = nil;
}

@end
