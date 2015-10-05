//
//  DarkStyleCell.m
//  JTMaterialSwitch
//
//  Created by Junichi Tsurukawa on 2015/10/03.
//  Copyright 2015 Junichi Tsurukawa. All rights reserved.
//

#import "DarkStyleCell.h"
#import "JTMaterialSwitch.h"

@implementation DarkStyleCell {
  UILabel *styleLabel;
  JTMaterialSwitch *jtSwitch;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  CGRect screenFrame = [[UIScreen mainScreen] bounds];
  styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, screenFrame.size.width-60, 20)];
  styleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
  [styleLabel setText:@"JTMaterialSwitchStyleDark:"];
  [self.contentView addSubview:styleLabel];
  
  jtSwitch = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                style:JTMaterialSwitchStyleDark
                                                                state:JTMaterialSwitchStateOn];
  jtSwitch.center = CGPointMake(screenFrame.size.width*6/7, 45);
  [jtSwitch addTarget:self action:@selector(stateChanged) forControlEvents:UIControlEventValueChanged];
  [self.contentView addSubview:jtSwitch];
  
  UILabel *thumbDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, screenFrame.size.width-60, 20)];
  thumbDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  thumbDescriptionLabel.textColor = [UIColor grayColor];
  [thumbDescriptionLabel setText:@"Thumb On: #5AB7AA  Off: #9F9F9F"];
  [self.contentView addSubview:thumbDescriptionLabel];
  
  UILabel *trackDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, screenFrame.size.width-60, 20)];
  trackDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  trackDescriptionLabel.textColor = [UIColor grayColor];
  [trackDescriptionLabel setText:@"Track   On: #385B56   Off: #4B4C4B"];
  [self.contentView addSubview:trackDescriptionLabel];
  
  return self;
}

- (void)stateChanged
{
  if(jtSwitch.isOn == YES) {
    [styleLabel setText:@"JTMaterialSwitchStyleDark: ON"];
  }
  else {
    [styleLabel setText:@"JTMaterialSwitchStyleDark: OFF"];
  }
}

@end
