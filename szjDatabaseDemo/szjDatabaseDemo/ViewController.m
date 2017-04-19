//
//  ViewController.m
//  szjDatabaseDemo
//
//  Created by 史志杰 on 2017/4/19.
//  Copyright © 2017年 史志杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
	UIView * bkView;
	BOOL flag1;
	BOOL flag2;
	UILabel * label1;
	UILabel * label2;
	
	UIView * view1;
}

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self createMySegmentControl];
	
	[self createUI];

}

- (void)createUI
{
	UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
	btn.frame = CGRectMake(100, 200, 40, 40);
	[btn setTitle:@"颤抖" forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
	
	view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
	view1.backgroundColor = [UIColor redColor];
	[self.view addSubview:view1];
	
	
}
- (void)Click
{
	[self shakeAnimationForView:view1];
}

- (void)createMySegmentControl
{
	bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 132, 26)];
	bkView.backgroundColor = [UIColor whiteColor];
	//    bkView.tag = 1000;
	bkView.layer.borderColor = [[UIColor colorWithRed:47/255.0 green:180/255.0 blue:172/255.0 alpha:1] CGColor];
	bkView.layer.borderWidth = 1;
	bkView.layer.cornerRadius = 6;
	bkView.clipsToBounds = YES;
	NSLog(@"%@", bkView);
	
	UIImageView * btnImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 66, 26)];
	btnImage.tag = 1001;
	//    btnImage.userInteractionEnabled = YES;
	btnImage.image = [UIImage imageNamed:@"4"];
	[bkView addSubview:btnImage];
	
	//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	//    [bkView addGestureRecognizer:tap];
	
	UIControl * con1 = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 66, 26)];
	[con1 addTarget:self action:@selector(con1:) forControlEvents:UIControlEventTouchUpInside];
	[bkView addSubview:con1];
	UIControl * con2 = [[UIControl alloc] initWithFrame:CGRectMake(66, 0, 66, 26)];
	[con2 addTarget:self action:@selector(con2:) forControlEvents:UIControlEventTouchUpInside];
	[bkView addSubview:con2];
	
	label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 66, 26)];
	label1.textColor = [UIColor whiteColor];
	label1.text = @"左边";
	label1.font = [UIFont systemFontOfSize:17 weight:3];
	label1.textAlignment = NSTextAlignmentCenter;
	[bkView addSubview:label1];
	label2 = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 66, 26)];
	label2.textColor = [UIColor colorWithRed:47/255.0 green:180/255.0 blue:172/255.0 alpha:1];
	label2.text = @"右边";
	label2.font = [UIFont systemFontOfSize:17 weight:3];
	label2.textAlignment = NSTextAlignmentCenter;
	[bkView addSubview:label2];
	
	self.navigationItem.titleView = bkView;
	
}


- (void)con1:(UIControl *)con
{
	[[[self.childViewControllers firstObject] view] removeFromSuperview];
	
	label1.textColor = [UIColor whiteColor];
	label2.textColor = [UIColor colorWithRed:47/255.0 green:180/255.0 blue:172/255.0 alpha:1];
	
	//标志位的作用是，防止某一按钮可以连续响应，从而使图标超出范围
	flag1 = 0;
	if (!flag2) {
		flag2 = 1;
		for (UIView * tmpView in bkView.subviews) {
			if (tmpView.tag == 1001) {
				//普通动画
				//                [UIView animateWithDuration:0.3 animations:^{
				//                    CGRect frame = tmpView.frame;
				//                    frame.origin.x -= 66;
				//                    tmpView.frame = frame;
				//                }];
				
				//系统效果
				//UIViewAnimationOptionTransitionFlipFromLeft
				[UIView transitionWithView:tmpView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
					CGRect frame = tmpView.frame;
					frame.origin.x -= 66;
					tmpView.frame = frame;
				} completion:^(BOOL finished) {
					
				}];
			}
		}
	}
	
}
- (void)con2:(UIControl *)con
{
	[self.view addSubview:[[self.childViewControllers firstObject] view]];
	
	label1.textColor = [UIColor colorWithRed:47/255.0 green:180/255.0 blue:172/255.0 alpha:1];
	label2.textColor = [UIColor whiteColor];
	
	flag2 = 0;
	if (!flag1) {
		flag1 = 1;
		for (UIView * tmpView in bkView.subviews) {
			if (tmpView.tag == 1001) {
				//                [UIView animateWithDuration:0.3 animations:^{
				//                    CGRect frame = tmpView.frame;
				//                    frame.origin.x += 66;
				//                    tmpView.frame = frame;
				//                }];
				//UIViewAnimationOptionTransitionFlipFromRight
				[UIView transitionWithView:tmpView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
					CGRect frame = tmpView.frame;
					frame.origin.x += 66;
					tmpView.frame = frame;
				} completion:^(BOOL finished) {
					
				}];
			}
			
			
		}
	}
	
}

#pragma mark 抖动动画

- (void)shakeAnimationForView:(UIView *) view
{
	// 获取到当前的View
	
	CALayer *viewLayer = view.layer;
	
	// 获取当前View的位置
	
	CGPoint position = viewLayer.position;
	
	// 移动的两个终点位置
	
	CGPoint x = CGPointMake(position.x + 10, position.y);
	
	CGPoint y = CGPointMake(position.x - 10, position.y);
	
	// 设置动画
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	
	// 设置运动形式
	
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
	
	// 设置开始位置
	
	[animation setFromValue:[NSValue valueWithCGPoint:x]];
	// 设置结束位置
	
	[animation setToValue:[NSValue valueWithCGPoint:y]];
	
	// 设置自动反转
	
	[animation setAutoreverses:YES];
	
	// 设置时间
	
	[animation setDuration:.06];
	
	// 设置次数
	
	[animation setRepeatCount:3];
	
	// 添加上动画
	
	[viewLayer addAnimation:animation forKey:nil];
	
}



- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
