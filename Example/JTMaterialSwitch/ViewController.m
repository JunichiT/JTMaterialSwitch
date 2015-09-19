//
//  ViewController.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/09/06.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  CGRect frame = CGRectMake(100, 100, 50, 50);
  JTMaterialSwitch *jt = [[JTMaterialSwitch alloc] initWithFrame:frame
                                                       withState:JTMaterialSwitchStateOn];
//  jt.backgroundColor = [UIColor darkGrayColor];
  [self.view addSubview:jt];
  jt.center = CGPointMake(230, 130);
  
  CGRect frame2 = CGRectMake(100, 300, 50, 50);
  JTMaterialSwitch *jt2 = [[JTMaterialSwitch alloc] initWithFrame:frame2
                                                        withState:JTMaterialSwitchStateOff];
  jt2.delegate = self;
  jt2.buttonOffTintColor = [UIColor grayColor];
  jt2.buttonOnTintColor  = [UIColor greenColor];
  jt2.buttonSize = 2.0;
  [self.view addSubview:jt2];
  
  self.labelJT2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 50, 50)];
  [self.view addSubview:self.labelJT2];
}

- (void)switchStateChanged:(JTMaterialSwitchState)currentState
{
  if (currentState == JTMaterialSwitchStateOn) {
    [self.labelJT2 setText:@"ON"];
  }
  else{
    [self.labelJT2 setText:@"OFF"];
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
