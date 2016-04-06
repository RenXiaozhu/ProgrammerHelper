//
//  HtmlTestViewController.m
//  QQDemo
//
//  Created by 王傲 on 16/3/31.
//  Copyright © 2016年 任小柱. All rights reserved.
//

#import "HtmlTestViewController.h"
#import "RXZAnimationBtn.h"

@interface HtmlTestViewController ()

@end

@implementation HtmlTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *img = GET_IMAGE_FROM_BUNDLE_PATH(@"btn_open", @"ui");
    UIImage *select = GET_IMAGE_FROM_BUNDLE_PATH(@"btn_open_select", @"ui");

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage: img forState: UIControlStateNormal];
    [btn setBackgroundImage: select forState: UIControlStateSelected];
    [ btn addTarget:self action:@selector(action:) forControlEvents: UIControlEventTouchUpInside];
    [btn setFrame: CGRectMake(100, 100, img.size.width/10, img.size.height/10)];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.

    RXZAnimationBtn *actBtn = [[RXZAnimationBtn alloc]initWithFrame:CGRectMake(200, 200, 780/10, 337/10)];
    [self.view addSubview:actBtn];

}

- (void)action:(UIButton *)btn
{
    if (btn.selected == YES)
    {
        [btn setSelected:NO];
    }
    else
    {
        [btn setSelected:YES];
    }
//    UIImage *select = GET_IMAGE_FROM_BUNDLE_PATH(@"btn_open_select", @"ui");
//    [btn setBackgroundImage:select forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
