//
//  DarkStyleCell.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/10/03.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "DarkStyleCell.h"
#import "JTMaterialSwitch.h"

@implementation DarkStyleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  CGRect screenFrame = [[UIScreen mainScreen] bounds];
  UILabel *styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, screenFrame.size.width-60, 20)];
  styleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
  [styleLabel setText:@"JTMaterialSwitchStyleDark:"];
  [self.contentView addSubview:styleLabel];
  
  JTMaterialSwitch *jtSwitch = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                style:JTMaterialSwitchStyleDark
                                                                state:JTMaterialSwitchStateOn];
  jtSwitch.center = CGPointMake(screenFrame.size.width*6/7, 45);
  [self.contentView addSubview:jtSwitch];
  
  UILabel *buttonDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, screenFrame.size.width-60, 20)];
  buttonDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  buttonDescriptionLabel.textColor = [UIColor grayColor];
  [buttonDescriptionLabel setText:@"Thumb On: #5AB7AA  Off: #9F9F9F"];
  [self.contentView addSubview:buttonDescriptionLabel];
  
  UILabel *sliderDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, screenFrame.size.width-60, 20)];
  sliderDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  sliderDescriptionLabel.textColor = [UIColor grayColor];
  [sliderDescriptionLabel setText:@"Track   On: #385B56   Off: #4B4C4B"];
  [self.contentView addSubview:sliderDescriptionLabel];
  
  return self;
}

@end
