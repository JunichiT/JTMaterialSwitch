//
//  CustomizedStyleCell.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/10/03.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "CustomizedStyleCell.h"
#import "JTMaterialSwitch.h"

@implementation CustomizedStyleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, self.contentView.frame.size.width-60, 20)];
  [label setText:@"Customized Behaviors:"];
  [self.contentView addSubview:label];
  
  JTMaterialSwitch *jtSwitch = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                style:JTMaterialSwitchStyleDark
                                                                state:JTMaterialSwitchStateOn];
  jtSwitch.center = CGPointMake(self.contentView.frame.size.width-40, 40);
  jtSwitch.buttonOnTintColor = [UIColor redColor];
  jtSwitch.buttonOffTintColor = [UIColor yellowColor];
  jtSwitch.buttonOnTintColor = [UIColor blueColor];
  jtSwitch.sliderOffTintColor = [UIColor orangeColor];
  jtSwitch.rippleFillColor = [UIColor greenColor];
  [self.contentView addSubview:jtSwitch];
  
  return self;
}

@end
