//
//  BasicLoadingViewController.m
//  XMPPDemo
//
//  Created by Hexun pro on 15/4/28.
//  Copyright (c) 2015年 Hexun. All rights reserved.
//

#import "BasicLoadingViewController.h"
#import "WADynamicViewController.h"
#import "FriendListViewController.h"
#import "ChatListViewController.h"
#import "UIColor+_16ToRGB.h"
#import "FunctionTestViewController.h"


@interface BasicLoadingViewController ()
{
   
    UITouch *onlyTouch;
    CGFloat leftToolScalef;
    CGFloat rightToolScalef;
    CGFloat mainScalef;
    BOOL isLeftOrRightTool;
    BOOL isShowToolView;
    BOOL  moveDirection;//  yes   向右 ； no 向左
}

@end

@implementation BasicLoadingViewController
@synthesize leftToolView;
@synthesize rightToolView;
@synthesize tableBarViewController;
@synthesize startPoint;
@synthesize endPoint;


- (void)loadView
{
    [super loadView];
    
    [self initLeftToolView];
    [self initRightToolView];
    [self initTabbarViewController];
}


- (void)initLeftToolView
{
    leftToolView = [[LeftToolViewController alloc]init];

    @weakify(self);
    [leftToolView setRestoreBlock:^(NSString *name){
        @strongify(self);

        [self animationadjustViewWithTouchItem:YES];

        UIViewController *controller = [[UIViewController alloc]init];
        controller.view.backgroundColor = [UIColor whiteColor];
        RootNavViewController *nav = (RootNavViewController *)self.tableBarViewController.selectedViewController;
        [nav pushViewController:controller animated:YES];

        
    }];
    
    leftToolView.view.frame       = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    leftToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, LEFTSCALING, LEFTSCALING);
    leftToolView.view.center       = CGPointMake(- SCREEN_WIDTH*LEFTSCALING,SCREEN_HEIGHT/2);
    [self.view addSubview:leftToolView.view];

    
}


- (void)initRightToolView
{
    rightToolView = [[RoghtToolViewController alloc]init];

    @weakify(self);
    [rightToolView setRestoreBlock:^(NSString *name){
        @strongify(self);

        [self animationadjustViewWithTouchItem:YES];
        
        UIViewController *controller = [[UIViewController alloc]init];
        controller.view.backgroundColor = [UIColor whiteColor];

        RootNavViewController *nav = (RootNavViewController *)self.tableBarViewController.selectedViewController;
        [nav pushViewController:controller animated:YES];
        
    }];
    
    rightToolView.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    rightToolView.view.center = CGPointMake(SCREEN_WIDTH+SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    rightToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [self.view addSubview:rightToolView.view];
}

- (void)initTabbarViewController
{
    tableBarViewController = [[TableBarViewController alloc]init];
    
    ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];

    @weakify(self);
    [chatListViewController setAnmiationBlock:^(BOOL isLeftOrRight)
     {
         @strongify(self);
         [self animateViewWithleftOrRight:isLeftOrRight];
     }];


    RootNavViewController *chatNav                               = [[RootNavViewController alloc]initWithRootViewController:chatListViewController];
    FriendListViewController *friendListViewController = [[FriendListViewController alloc]init];
    RootNavViewController *friendNav                            = [[RootNavViewController alloc]initWithRootViewController:friendListViewController];

    
    WADynamicViewController *waDynamicViewController = [[WADynamicViewController alloc]init];
    RootNavViewController *DynamicNav = [[RootNavViewController alloc]initWithRootViewController:waDynamicViewController];
    
    FunctionTestViewController *functionTest = [[FunctionTestViewController alloc]init];
    RootNavViewController *FunctionNav = [[RootNavViewController alloc]initWithRootViewController:functionTest];
    
    UITabBarItem *chatItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage new] tag:1];
    chatListViewController.tabBarItem = chatItem;
    [chatItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    
    UITabBarItem *FriendItem = [[UITabBarItem alloc]initWithTitle:@"联系人" image:[UIImage new] tag:2];
    [FriendItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    friendListViewController.tabBarItem = FriendItem;

    
    UITabBarItem *DyItem = [[UITabBarItem alloc]initWithTitle:@"动态" image:[UIImage new] tag:3];
    [DyItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    waDynamicViewController.tabBarItem =DyItem;

    
    UITabBarItem *FtItem = [[UITabBarItem alloc]initWithTitle:@"功能测试" image:[UIImage new] tag:4];
    [FtItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    functionTest.tabBarItem =FtItem;

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>5.0) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
            
            /*
             
                         [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextColor:[UIColor colorWithHexString:@"#828283"]} forState:UIControlStateNormal];
                         [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextColor:[UIColor colorWithHexString:@"#bb1818"]} forState:UIControlStateSelected];
                         [chatListViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:[selectArray objectAtIndex:0]] withFinishedUnselectedImage:[UIImage imageNamed:[img objectAtIndex:0]]];
                         //            _homePageViewController.tabBarItem.title=@"首页";
                         //UIEdgeInsets inset=_homePageViewController.tabBarItem.imageInsets;
             
                         _homePageViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(5 , 0,-5, 0);
             
                         [_managerProductionViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:[selectArray objectAtIndex:1]] withFinishedUnselectedImage:[UIImage imageNamed:[img objectAtIndex:1]]];
             
                         _managerProductionViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
             
                         _myManagerViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
             
                         [_myManagerViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:[selectArray objectAtIndex:2]] withFinishedUnselectedImage:[UIImage imageNamed:[img objectAtIndex:2]]];
                         [_moreViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:[selectArray objectAtIndex:3]] withFinishedUnselectedImage:[UIImage imageNamed:[img objectAtIndex:3]]];
             
                         //_moreViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(6, inset.left,-5, inset.right);
                         [_moreViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
              DDLogInfo(@"-----------------%f------------",inset.left);
             */
            
        }else{
            
            [[UITabBarItem appearanceWhenContainedIn:[UITabBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#828283"],NSFontAttributeName:[UIFont systemFontOfSize:10.0f]} forState:UIControlStateNormal];
            [[UITabBarItem appearanceWhenContainedIn:[UITabBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#bb1818"],NSFontAttributeName:[UIFont systemFontOfSize:10.0f]} forState:UIControlStateSelected];
            /*
             UIImage *nonalImg=[[UIImage imageNamed:[img objectAtIndex:0]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             UIImage *selectImg=[[UIImage imageNamed:[selectArray objectAtIndex:0]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             UITabBarItem *item=[[UITabBarItem alloc]initWithTitle:@"" image:nonalImg selectedImage:selectImg];
             _homePageViewController.tabBarItem=item;
             
             [item release];
             //UIEdgeInsets inset=_homePageViewController.tabBarItem.imageInsets;
             
             
             UIImage *nonalImg1=[[UIImage imageNamed:[img objectAtIndex:1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             UIImage *selectImg1=[[UIImage imageNamed:[selectArray objectAtIndex:1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             UITabBarItem *item1=[[UITabBarItem alloc]initWithTitle:@"" image:nonalImg1 selectedImage:selectImg1];
             _moreViewController.tabBarItem=item1;
             _managerProductionViewController.tabBarItem=item1;
             [item1 release];
             
             
             UIImage *nonalImg2=[[UIImage imageNamed:[img objectAtIndex:2]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             UIImage *selectImg2=[[UIImage imageNamed:[selectArray objectAtIndex:2]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             UITabBarItem *item2=[[UITabBarItem alloc]initWithTitle:@"" image:nonalImg2 selectedImage:selectImg2];
             //            _moreViewController.tabBarItem=item2;
             _myManagerViewController.tabBarItem=item2;
             [item2 release];
             
             
             UIImage *nonalImg3=[[UIImage imageNamed:[img objectAtIndex:3]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             UIImage *selectImg3=[[UIImage imageNamed:[selectArray objectAtIndex:3]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
             UITabBarItem *item3=[[UITabBarItem alloc]initWithTitle:@"" image:nonalImg3 selectedImage:selectImg3];
             _moreViewController.tabBarItem=item3;
             [item3 release];
             //_moreViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(6, inset.left,-5, inset.right);
             
             if ([UIScreen mainScreen].scale==1||[UIScreen mainScreen].scale==2) {
             _moreViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);
             _myManagerViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
             _managerProductionViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
             _homePageViewController.tabBarItem.imageInsets=UIEdgeInsetsMake(5 , 0,-5, 0);
             }else{
             _homePageViewController.tabBarItem.title=@"首页";
             _moreViewController.tabBarItem.title=@"更多";
             _managerProductionViewController.tabBarItem.title=@"理财产品";
             _myManagerViewController.tabBarItem.title=@"我的理财客";
             
             }
             
             DDLogInfo(@"-----------------%f------------",inset.left);

             */
            
        }
    }
    
    NSArray *viewControllers  = [NSArray arrayWithObjects:chatNav,friendNav,DynamicNav,FunctionNav, nil];
    
    tableBarViewController.viewControllers = viewControllers;
    
    [self.view addSubview:tableBarViewController.view];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(showToolViewAnimation:)];
    [self.view addGestureRecognizer:pan];

}

- (void)showToolViewAnimation:(UIPanGestureRecognizer *)rec
{
//    if (!isShowToolView)
//    return;
    CGPoint point = [rec translationInView:self.view];
//    DDLogInfo(@"point.x==%f  point.y==%f",point.x,point.y);
//    scalef = (point.x==0?0:(point.x/SCREEN_WIDTH))+scalef;
    
    
    if (rec.state == UIGestureRecognizerStateBegan)
    {
        startPoint = [rec locationInView:self.view];

        if (startPoint.x<5||startPoint.x>(SCREEN_WIDTH-5))
        {
            return;
        }
    }
    
    if (rec.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point1 = [rec locationInView:self.view];

        if (startPoint.x-point1.x<0)
        {
            moveDirection = YES;
        }
        else
        {
            moveDirection = NO;
        }

        CGPoint mainViewCenterPoint = CGPointZero;
        CGPoint leftViewCenterPoint    = CGPointZero;
        CGPoint rightViewCenterPoint  = CGPointZero;

        if (startPoint.x<5)
        {
            if (self.tableBarViewController.view.origin.x<SCREEN_WIDTH*0.8)
            {
                mainViewCenterPoint = CGPointMake( SCREEN_WIDTH/2 + point1.x, SCREEN_HEIGHT/2);
            }
            if (self.leftToolView.view.origin.x<=0)
            {
                leftViewCenterPoint    = CGPointMake(-SCREEN_WIDTH/2 + point1.x*SCALINGSPEED, SCREEN_HEIGHT/2);
            }

            rec.view.center = CGPointMake(rec.view.center.x + point.x,rec.view.center.y);
            rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,mainScalef,mainScalef);
            [rec setTranslation:CGPointMake(0, 0) inView:self.view];
            
            leftToolView.view.center = CGPointMake(leftToolView.view.center.x + point.x*SCALINGSPEED,leftToolView.view.center.y);
            leftToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        }
        else
        {

            if (self.tableBarViewController.view.origin.x>=SCREEN_WIDTH*0.3)
            {
                mainViewCenterPoint = CGPointMake( SCREEN_WIDTH/2 + point1.x, SCREEN_HEIGHT/2);
            }
            if (self.rightToolView.view.origin.x>=(SCREEN_WIDTH+SCREEN_WIDTH*0.3))
            {
                rightViewCenterPoint    = CGPointMake(SCREEN_WIDTH*3/2 - point1.x*0.8, SCREEN_HEIGHT/2);
            }
            rec.view.center = CGPointMake(rec.view.center.x + point.x,rec.view.center.y);
            rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,mainScalef,mainScalef);
            
            rightToolView.view.center = CGPointMake(rightToolView.view.center.x + point.x*SCALINGSPEED,rightToolView.view.center.y);
            rightToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,rightToolScalef,rightToolScalef);
            
            [rec setTranslation:CGPointMake(0, 0) inView:self.view];
            
        }
    }

    //手势结束后修正位置
    if (rec.state == UIGestureRecognizerStateEnded)
    {
        [self animationadjustViewWithTouchItem:NO];
    }

}




- (void)animationadjustViewWithTouchItem:(BOOL)isTouch
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0f];
    self.tableBarViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.leftToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.rightToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
    
    CGPoint mainViewCenterPoint;
    CGPoint leftViewCenterPoint;
    CGPoint rightViewCenterPoint;

    if (isTouch)
    {
        if (isLeftOrRightTool)
        {
            mainViewCenterPoint = CGPointMake(SCREEN_WIDTH/2+ SCREEN_WIDTH*MAINVIEWSCALING, SCREEN_HEIGHT/2);
            leftViewCenterPoint    = CGPointMake(SCREEN_WIDTH*LEFTSCALING, SCREEN_HEIGHT/2);
        }
        else
        {
            mainViewCenterPoint = CGPointMake(SCREEN_WIDTH/2 - SCREEN_WIDTH*MAINVIEWSCALING, SCREEN_HEIGHT/2);
            rightViewCenterPoint  = CGPointMake(SCREEN_WIDTH*RIGHTSCALING, SCREEN_HEIGHT/2);
        }
    }
    else
    {
        if (isLeftOrRightTool)
        {
            mainViewCenterPoint = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
            leftViewCenterPoint    = CGPointMake(-SCREEN_WIDTH*LEFTSCALING, SCREEN_HEIGHT/2);
        }
        else
        {
            mainViewCenterPoint = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
            rightViewCenterPoint  = CGPointMake(-SCREEN_WIDTH*RIGHTSCALING, SCREEN_HEIGHT/2);
        }
    }

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    self.tableBarViewController.view.center = mainViewCenterPoint;
    self.tableBarViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,mainScalef,mainScalef);
    if (isLeftOrRightTool)
    {
        self.leftToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftToolScalef, leftToolScalef);
        self.leftToolView.view.center = leftViewCenterPoint;
    }
    else
    {
        self.rightToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, rightToolScalef, rightToolScalef);
        self.rightToolView.view.center = rightViewCenterPoint;
    }
    
    [UIView commitAnimations];
   
}

- (void)animateViewWithleftOrRight:(BOOL)leftOrRight
{
    isLeftOrRightTool = leftOrRight;

    if (isShowToolView==NO)
    {

        isShowToolView = YES;

        self.tableBarViewController.view.transform = CGAffineTransformIdentity;
        self.leftToolView.view.transform = CGAffineTransformIdentity;

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        isLeftOrRightTool = leftOrRight;

        CGPoint mainViewCenterPoint = CGPointZero;
        CGPoint leftViewCenterPoint    = CGPointZero;
        CGPoint rightViewCenterPoint  = CGPointZero;

        if (isLeftOrRightTool)
        {
            mainViewCenterPoint = CGPointMake(SCREEN_WIDTH/2+SCREEN_WIDTH*MAINVIEWSCALING, SCREEN_HEIGHT/2);
            leftViewCenterPoint    = CGPointMake(SCREEN_WIDTH*LEFTSCALING, SCREEN_HEIGHT/2);
        }
        else
        {
            mainViewCenterPoint = CGPointMake(SCREEN_WIDTH/2 - SCREEN_WIDTH*MAINVIEWSCALING, SCREEN_HEIGHT/2);
            rightViewCenterPoint  = CGPointMake(SCREEN_WIDTH*RIGHTSCALING, SCREEN_HEIGHT/2);
        }

        if (leftOrRight)
        {
            leftToolScalef = 1.0;
            self.rightToolView.view.alpha = 0.0;
            self.tableBarViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
            [self.tableBarViewController.view setCenter:mainViewCenterPoint];
            self.leftToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            [self.leftToolView.view setCenter:leftViewCenterPoint];
            self.leftToolView.view.alpha = 1.0;

        }
        else
        {
            self.leftToolView.view.alpha = 0.0;
            self.tableBarViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
            [self.tableBarViewController.view setCenter:mainViewCenterPoint];

            self.rightToolView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            [self.rightToolView.view setCenter:rightViewCenterPoint];
            self.rightToolView.view.alpha = 1.0;
        }
        [UIView commitAnimations];
    }
    else
    {
        [self animationadjustViewWithTouchItem:YES];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    startPoint = CGPointMake(-1111, -11111);
    endPoint   = CGPointMake(-1111, -11111);
    isShowToolView = NO;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



- (void)dealloc
{
    leftToolView = nil;
    rightToolView = nil;
    tableBarViewController = nil;

}

@end
