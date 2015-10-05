//
//  LightStyleCell.m
//  JTMaterialSwitch
//
//  Created by Junichi Tsurukawa on 2015/10/03.
//  Copyright 2015 Junichi Tsurukawa. All rights reserved.
//

#import "LightStyleCell.h"
#import "JTMaterialSwitch.h"

@implementation LightStyleCell {
  UILabel *styleLabel;
  JTMaterialSwitch *jtSwitch;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  CGRect screenFrame = [[UIScreen mainScreen] bounds];
  styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, screenFrame.size.width-60, 20)];
  styleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
  [styleLabel setText:@"JTMaterialSwitchStyleLight:"];
  [self.contentView addSubview:styleLabel];
  
  jtSwitch = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                style:JTMaterialSwitchStyleLight
                                                                state:JTMaterialSwitchStateOn];
  jtSwitch.center = CGPointMake(screenFrame.size.width*6/7, 45);
  [jtSwitch addTarget:self action:@selector(stateChanged) forControlEvents:UIControlEventValueChanged];
  [self.contentView addSubview:jtSwitch];
  
  UILabel *buttonDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, screenFrame.size.width-60, 20)];
  buttonDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  buttonDescriptionLabel.textColor = [UIColor grayColor];
  [buttonDescriptionLabel setText:@"Thumb On: #007562  Off: #E8E9E8"];
  [self.contentView addSubview:buttonDescriptionLabel];
  
  UILabel *trackDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, screenFrame.size.width-60, 20)];
  trackDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  trackDescriptionLabel.textColor = [UIColor grayColor];
  [trackDescriptionLabel setText:@"Track   On: #48A599  Off: #6E6E6E"];
  [self.contentView addSubview:trackDescriptionLabel];
  
  return self;
}

- (void)stateChanged
{
  if(jtSwitch.isOn == YES) {
    [styleLabel setText:@"JTMaterialSwitchStyleLight: ON"];
  }
  else {
    [styleLabel setText:@"JTMaterialSwitchStyleLight: OFF"];
  }
}

@end
