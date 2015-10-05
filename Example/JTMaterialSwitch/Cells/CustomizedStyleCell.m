//
//  CustomizedStyleCell.m
//  JTMaterialSwitch
//
//  Created by Junichi Tsurukawa on 2015/10/03.
//  Copyright 2015 Junichi Tsurukawa. All rights reserved.
//

#import "CustomizedStyleCell.h"
#import "JTMaterialSwitch.h"

@implementation CustomizedStyleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  CGRect screenFrame = [[UIScreen mainScreen] bounds];
  UILabel *styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, screenFrame.size.width-60, 20)];
  styleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
  [styleLabel setText:@"Customized Style:"];
  [self.contentView addSubview:styleLabel];
  
  JTMaterialSwitch *jtSwitch = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                style:JTMaterialSwitchStyleDefault
                                                                state:JTMaterialSwitchStateOn];
  jtSwitch.center = CGPointMake(screenFrame.size.width*6/7, 45);
  // Custom behaviors to each component
  jtSwitch.thumbOnTintColor  = [UIColor colorWithRed:237./255. green:159./255. blue:53./255. alpha:1.0];
  jtSwitch.thumbOffTintColor = [UIColor colorWithRed:232./255. green:233./255. blue:232./255. alpha:1.0];
  jtSwitch.trackOnTintColor  = [UIColor colorWithRed:243./255. green:204./255. blue:146./255. alpha:1.0];
  jtSwitch.trackOffTintColor = [UIColor colorWithRed:164./255. green:164./255. blue:164./255. alpha:1.0];
  jtSwitch.rippleFillColor = [UIColor greenColor];
  [self.contentView addSubview:jtSwitch];
  
  UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, screenFrame.size.width-60, 20)];
  descriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  descriptionLabel.textColor = [UIColor grayColor];
  [descriptionLabel setText:@"You can set any colors to attributes."];
  [self.contentView addSubview:descriptionLabel];
  
  UILabel *subDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, screenFrame.size.width-60, 20)];
  subDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  subDescriptionLabel.textColor = [UIColor grayColor];
  [subDescriptionLabel setText:@"(Thumb On/Off, Track On/Off, Ripple)"];
  [self.contentView addSubview:subDescriptionLabel];
  
  return self;
}

@end
