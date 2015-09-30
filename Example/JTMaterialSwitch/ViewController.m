//
//  ViewController.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/09/06.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
  JTMaterialSwitch *jt5;
}

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 400, 50, 50)];
  [self.view addSubview:self.statusLabel];
  
  JTMaterialSwitch *jt3 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeSmall WithState:JTMaterialSwitchStateOn];
  jt3.center = CGPointMake(200, 100);
  jt3.delegate = self;
  jt3.buttonOnTintColor  = [UIColor colorWithRed:52./255. green:109./255. blue:241./255. alpha:1.0];
  jt3.buttonOffTintColor = [UIColor colorWithRed:249./255. green:249./255. blue:249./255. alpha:1.0];
  jt3.sliderOnTintColor = [UIColor colorWithRed:143./255. green:179./255. blue:247./255. alpha:1.0];
  jt3.sliderOffTintColor = [UIColor colorWithRed:193./255. green:193./255. blue:193./255. alpha:1.0];
  jt3.rippleFillColor = [UIColor grayColor];
  [jt3 addTarget:self action:@selector(hoge) forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:jt3];
  
  JTMaterialSwitch *jt4 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal WithState:JTMaterialSwitchStateOff];
  jt4.center = CGPointMake(200, 250);
  jt4.rippleFillColor = [UIColor orangeColor];
  [self.view addSubview:jt4];
  
  jt5 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeBig WithState:JTMaterialSwitchStateOn];
  jt5.center = CGPointMake(200, 400);
  [self.view addSubview:jt5];
  
}

- (void)hoge{
}

- (void)switchStateChanged:(JTMaterialSwitchState)currentState
{
  if (currentState == JTMaterialSwitchStateOn) {
    [self.statusLabel setText:@"ON"];
    [jt5 setEnabled:YES];
  }
  else{
    [self.statusLabel setText:@"OFF"];
    [jt5 setEnabled:NO];
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
