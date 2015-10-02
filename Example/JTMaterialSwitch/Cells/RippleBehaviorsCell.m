//
//  RippleBehaviorsCell.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/10/03.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "RippleBehaviorsCell.h"
#import "JTMaterialSwitch.h"

@implementation RippleBehaviorsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  JTMaterialSwitch *jtSwitchRippleOFF = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                         style:JTMaterialSwitchStyleDefault
                                                                         state:JTMaterialSwitchStateOn];
  jtSwitchRippleOFF.center = CGPointMake(self.contentView.frame.size.width/3, 30);
  jtSwitchRippleOFF.isRippleEnabled = NO;
  [self.contentView addSubview:jtSwitchRippleOFF];
  
  JTMaterialSwitch *jtSwitchRippleON= [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                       style:JTMaterialSwitchStyleDefault
                                                                       state:JTMaterialSwitchStateOn];
  jtSwitchRippleON.center = CGPointMake(self.contentView.frame.size.width*2/3, 30);
  jtSwitchRippleON.isRippleEnabled = YES; // default value
  [self.contentView addSubview:jtSwitchRippleON];
  
  UILabel *labelRippleOFF = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelRippleOFF.center = CGPointMake(self.contentView.frame.size.width/3, 60);
  [labelRippleOFF setText:@"OFF"];
  [self.contentView addSubview:labelRippleOFF];
  
  UILabel *labelRippleON = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelRippleON.center = CGPointMake(self.contentView.frame.size.width*2/3, 60);
  [labelRippleON setText:@"ON"];
  [self.contentView addSubview:labelRippleON];
  
  return self;
}

@end
