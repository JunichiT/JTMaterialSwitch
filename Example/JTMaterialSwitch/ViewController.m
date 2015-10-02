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
  
  JTMaterialSwitch *jt3 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeSmall
                                                       state:JTMaterialSwitchStateOn];
  jt3.center = CGPointMake(200, 100);
  jt3.delegate = self;
  [self.view addSubview:jt3];
  
  JTMaterialSwitch *jt4 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                           style:JTMaterialSwitchStyleLight
                                                           state:JTMaterialSwitchStateOn];
  jt4.center = CGPointMake(200, 150);
  jt4.isRippleEnabled = YES;
//  jt4.isBounceEnabled = NO;
  [self.view addSubview:jt4];
  
  jt5 = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeBig
                                         style:JTMaterialSwitchStyleDefault
                                         state:JTMaterialSwitchStateOn];

  jt5.center = CGPointMake(200, 200);
  jt5.isBounceEnabled = YES;
  [self.view addSubview:jt5];
  
  UISwitch *uiswitch = [[UISwitch alloc] init];
  uiswitch.center = CGPointMake(200, 350);
  [self.view addSubview:uiswitch];
    
}

- (void)switchStateChanged:(JTMaterialSwitchState)currentState
{
  if (currentState == JTMaterialSwitchStateOn) {
    [self.statusLabel setText:@"ON"];
    [jt5 setEnabled:YES];
    if (jt5.isOn == YES) {
      [jt5 setOn:NO animated:YES];
    }
    else {
      [jt5 setOn:YES animated:YES];
    }
  }
  else{
    [self.statusLabel setText:@"OFF"];
    [jt5 setEnabled:NO];
    if (jt5.isOn == YES) {
      [jt5 setOn:NO animated:NO];
    }
    else {
      [jt5 setOn:YES animated:NO];
    }
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
