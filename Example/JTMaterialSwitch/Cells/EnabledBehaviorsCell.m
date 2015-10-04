//
//  EnabledBehaviorsCell.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/10/03.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "EnabledBehaviorsCell.h"
#import "JTMaterialSwitch.h"

@implementation EnabledBehaviorsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  CGRect screenFrame = [[UIScreen mainScreen] bounds];

  JTMaterialSwitch *jtSwitchEnabledOFF = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                         style:JTMaterialSwitchStyleLight
                                                                         state:JTMaterialSwitchStateOn];
  jtSwitchEnabledOFF.center = CGPointMake(screenFrame.size.width/3, 30);
  jtSwitchEnabledOFF.isEnabled = NO;
  [self.contentView addSubview:jtSwitchEnabledOFF];
//  [jtSwitchEnabledOFF setEnabled:NO];

  JTMaterialSwitch *jtSwitchEnabledON = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                       style:JTMaterialSwitchStyleLight
                                                                       state:JTMaterialSwitchStateOff];
  
  [jtSwitchEnabledON addTarget:self action:@selector(changeState) forControlEvents:UIControlEventValueChanged];
  jtSwitchEnabledON.center = CGPointMake(screenFrame.size.width*2/3, 30);
  [self.contentView addSubview:jtSwitchEnabledON];
  [jtSwitchEnabledON setEnabled:YES]; // default value
  
  UILabel *labelEnabledOFF = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelEnabledOFF.center = CGPointMake(screenFrame.size.width/3, 60);
  labelEnabledOFF.font = [UIFont fontWithName:@"Helvetica" size:13];
  labelEnabledOFF.textAlignment = NSTextAlignmentCenter;
  [labelEnabledOFF setText:@"Disabled"];
  [self.contentView addSubview:labelEnabledOFF];
  
  UILabel *labelEnabledON = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelEnabledON.center = CGPointMake(screenFrame.size.width*2/3, 60);
  labelEnabledON.font = [UIFont fontWithName:@"Helvetica" size:13];
  labelEnabledON.textAlignment = NSTextAlignmentCenter;
  [labelEnabledON setText:@"Enabled"];
  [self.contentView addSubview:labelEnabledON];
  
  return self;
}

@end
