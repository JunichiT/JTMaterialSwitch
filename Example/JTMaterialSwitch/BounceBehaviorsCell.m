//
//  BounceBehaviorsCell.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/10/03.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "BounceBehaviorsCell.h"
#import "JTMaterialSwitch.h"

@implementation BounceBehaviorsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  JTMaterialSwitch *jtSwitchBounceOFF = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                     style:JTMaterialSwitchStyleLight
                                                                     state:JTMaterialSwitchStateOn];
  jtSwitchBounceOFF.center = CGPointMake(self.contentView.frame.size.width/3, 30);
  jtSwitchBounceOFF.isBounceEnabled = NO;
  [self.contentView addSubview:jtSwitchBounceOFF];
  
  JTMaterialSwitch *jtSwitchBounceON= [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                      style:JTMaterialSwitchStyleLight
                                                                      state:JTMaterialSwitchStateOn];
  jtSwitchBounceON.center = CGPointMake(self.contentView.frame.size.width*2/3, 30);
  jtSwitchBounceON.isBounceEnabled = YES; // default value
  [self.contentView addSubview:jtSwitchBounceON];

  UILabel *labelBounceOFF = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelBounceOFF.center = CGPointMake(self.contentView.frame.size.width/3, 60);
  [labelBounceOFF setText:@"OFF"];
  [self.contentView addSubview:labelBounceOFF];
  
  UILabel *labelBounceON = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelBounceON.center = CGPointMake(self.contentView.frame.size.width*2/3, 60);
  [labelBounceON setText:@"ON"];
  [self.contentView addSubview:labelBounceON];
  
  return self;
}

@end
