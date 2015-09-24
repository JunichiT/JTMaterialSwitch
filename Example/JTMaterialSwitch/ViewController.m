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
  
  self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 400, 50, 50)];
  [self.view addSubview:self.statusLabel];
  
  JTMaterialSwitch *jt3 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeSmall WithState:JTMaterialSwitchStateOn];
  jt3.center = CGPointMake(200, 400);
  jt3.delegate = self;
  [self.view addSubview:jt3];
  
  JTMaterialSwitch *jt4 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal WithState:JTMaterialSwitchStateOff];
  jt4.center = CGPointMake(200, 450);
  [self.view addSubview:jt4];
  
  JTMaterialSwitch *jt5 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeBig WithState:JTMaterialSwitchStateOn];
  jt5.center = CGPointMake(200, 500);
  [self.view addSubview:jt5];
  
}

- (void)switchStateChanged:(JTMaterialSwitchState)currentState
{
  if (currentState == JTMaterialSwitchStateOn) {
    [self.statusLabel setText:@"ON"];
  }
  else{
    [self.statusLabel setText:@"OFF"];
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
