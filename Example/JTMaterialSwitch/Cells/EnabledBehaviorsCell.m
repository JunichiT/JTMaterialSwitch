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
  
  JTMaterialSwitch *jtSwitchEnabledOFF = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                         style:JTMaterialSwitchStyleLight
                                                                         state:JTMaterialSwitchStateOn];
  jtSwitchEnabledOFF.center = CGPointMake(self.contentView.frame.size.width/3, 30);
  [jtSwitchEnabledOFF setEnabled:NO];
  [self.contentView addSubview:jtSwitchEnabledOFF];
  
  JTMaterialSwitch *jtSwitchEnabledON= [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                       style:JTMaterialSwitchStyleLight
                                                                       state:JTMaterialSwitchStateOn];
  jtSwitchEnabledON.center = CGPointMake(self.contentView.frame.size.width*2/3, 30);
  [jtSwitchEnabledON setEnabled:YES]; // default value
  [self.contentView addSubview:jtSwitchEnabledON];
  
  UILabel *labelEnabledOFF = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelEnabledOFF.center = CGPointMake(self.contentView.frame.size.width/3, 60);
  [labelEnabledOFF setText:@"OFF"];
  [self.contentView addSubview:labelEnabledOFF];
  
  UILabel *labelEnabledON = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelEnabledON.center = CGPointMake(self.contentView.frame.size.width*2/3, 60);
  [labelEnabledON setText:@"ON"];
  [self.contentView addSubview:labelEnabledON];
  
  return self;
}

@end
