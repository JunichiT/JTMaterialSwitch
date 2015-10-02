//
//  SizeBehaviorsCell.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/10/03.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "SizeBehaviorsCell.h"
#import "JTMaterialSwitch.h"

@implementation SizeBehaviorsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  JTMaterialSwitch *jtSwitchSmall = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeSmall
                                                                style:JTMaterialSwitchStyleDefault
                                                                state:JTMaterialSwitchStateOn];
  jtSwitchSmall.center = CGPointMake(self.contentView.frame.size.width/4, 30);
  [self.contentView addSubview:jtSwitchSmall];
  
  JTMaterialSwitch *jtSwitchNormal = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                     style:JTMaterialSwitchStyleDefault
                                                                     state:JTMaterialSwitchStateOn];
  jtSwitchNormal.center = CGPointMake(self.contentView.frame.size.width*2/4, 30);
  [self.contentView addSubview:jtSwitchNormal];
  
  JTMaterialSwitch *jtSwitchBig = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeBig
                                                                     style:JTMaterialSwitchStyleDefault
                                                                     state:JTMaterialSwitchStateOn];
  jtSwitchBig.center = CGPointMake(self.contentView.frame.size.width*3/4, 30);
  [self.contentView addSubview:jtSwitchBig];
  
  UILabel *labelSmall = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelSmall.center = CGPointMake(self.contentView.frame.size.width/4, 60);
  [labelSmall setText:@"Small"];
  [self.contentView addSubview:labelSmall];
  
  UILabel *labelNormal = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelNormal.center = CGPointMake(self.contentView.frame.size.width*2/4, 60);
  [labelNormal setText:@"Normal"];
  [self.contentView addSubview:labelNormal];
  
  UILabel *labelBig = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelBig.center = CGPointMake(self.contentView.frame.size.width*3/4, 60);
  [labelBig setText:@"Big"];
  [self.contentView addSubview:labelBig];
  
  return self;
}

@end
