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

  CGRect screenFrame = [[UIScreen mainScreen] bounds];

  JTMaterialSwitch *jtSwitchSmall = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeSmall
                                                                style:JTMaterialSwitchStyleDefault
                                                                state:JTMaterialSwitchStateOn];
  jtSwitchSmall.center = CGPointMake(screenFrame.size.width/4, 35);
  [self.contentView addSubview:jtSwitchSmall];
  
  JTMaterialSwitch *jtSwitchNormal = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                     style:JTMaterialSwitchStyleDefault
                                                                     state:JTMaterialSwitchStateOn];
  jtSwitchNormal.center = CGPointMake(screenFrame.size.width*2/4, 35);
  [self.contentView addSubview:jtSwitchNormal];
  
  JTMaterialSwitch *jtSwitchBig = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeBig
                                                                     style:JTMaterialSwitchStyleDefault
                                                                     state:JTMaterialSwitchStateOn];
  jtSwitchBig.center = CGPointMake(screenFrame.size.width*3/4, 35);
  [self.contentView addSubview:jtSwitchBig];
  
  UILabel *labelSmall = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelSmall.center = CGPointMake(screenFrame.size.width/4, 70);
  labelSmall.font = [UIFont fontWithName:@"Helvetica" size:13];
  labelSmall.textAlignment = NSTextAlignmentCenter;
  [labelSmall setText:@"Small"];
  [self.contentView addSubview:labelSmall];
  
  UILabel *labelNormal = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelNormal.center = CGPointMake(screenFrame.size.width*2/4, 70);
  labelNormal.font = [UIFont fontWithName:@"Helvetica" size:13];
  labelNormal.textAlignment = NSTextAlignmentCenter;
  [labelNormal setText:@"Normal"];
  [self.contentView addSubview:labelNormal];
  
  UILabel *labelBig = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelBig.center = CGPointMake(screenFrame.size.width*3/4, 70);
  labelBig.font = [UIFont fontWithName:@"Helvetica" size:13];
  labelBig.textAlignment = NSTextAlignmentCenter;
  [labelBig setText:@"Big"];
  [self.contentView addSubview:labelBig];
  
  return self;
}

@end
