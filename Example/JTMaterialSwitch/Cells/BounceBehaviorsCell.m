//
//  BounceBehaviorsCell.m
//  JTMaterialSwitch
//
//  Created by Junichi Tsurukawa on 2015/10/03.
//  Copyright 2015 Junichi Tsurukawa. All rights reserved.
//

#import "BounceBehaviorsCell.h"
#import "JTMaterialSwitch.h"

@implementation BounceBehaviorsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  CGRect screenFrame = [[UIScreen mainScreen] bounds];

  JTMaterialSwitch *jtSwitchBounceOFF = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                     style:JTMaterialSwitchStyleLight
                                                                     state:JTMaterialSwitchStateOn];
  jtSwitchBounceOFF.center = CGPointMake(screenFrame.size.width/3, 35);
  jtSwitchBounceOFF.isBounceEnabled = NO;
  [self.contentView addSubview:jtSwitchBounceOFF];
  
  JTMaterialSwitch *jtSwitchBounceON= [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                      style:JTMaterialSwitchStyleLight
                                                                      state:JTMaterialSwitchStateOn];
  jtSwitchBounceON.center = CGPointMake(screenFrame.size.width*2/3, 35);
  jtSwitchBounceON.isBounceEnabled = YES; // default value
  [self.contentView addSubview:jtSwitchBounceON];

  UILabel *labelBounceOFF = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelBounceOFF.center = CGPointMake(screenFrame.size.width/3, 70);
  labelBounceOFF.font = [UIFont fontWithName:@"Helvetica" size:13];
  labelBounceOFF.textAlignment = NSTextAlignmentCenter;
  [labelBounceOFF setText:@"OFF"];
  [self.contentView addSubview:labelBounceOFF];
  
  UILabel *labelBounceON = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
  labelBounceON.center = CGPointMake(screenFrame.size.width*2/3, 70);
  labelBounceON.font = [UIFont fontWithName:@"Helvetica" size:13];
  labelBounceON.textAlignment = NSTextAlignmentCenter;
  [labelBounceON setText:@"ON"];
  [self.contentView addSubview:labelBounceON];
  
  return self;
}

@end
