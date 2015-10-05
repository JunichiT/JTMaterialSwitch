//
//  DefaultStyleCell.m
//  JTMaterialSwitch
//
//  Created by Junichi Tsurukawa on 2015/10/03.
//  Copyright 2015 Junichi Tsurukawa. All rights reserved.
//

#import "DefaultStyleCell.h"
#import "JTMaterialSwitch.h"

@implementation DefaultStyleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  CGRect screenFrame = [[UIScreen mainScreen] bounds];
  UILabel *styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, screenFrame.size.width-60, 20)];
  styleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
  [styleLabel setText:@"JTMaterialSwitchStyleDefault:"];
  [self.contentView addSubview:styleLabel];
  
  /**
   *  The following code is actually the same as the below initialization.
   *
   *  // The easiest way to use JTMaterialSwitch!
   *  JTMaterialSwitch *jtSwitch = [[JTMaterialSwitch alloc] init];
   */
  JTMaterialSwitch *jtSwitch = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                style:JTMaterialSwitchStyleDefault
                                                                state:JTMaterialSwitchStateOn];
  jtSwitch.center = CGPointMake(screenFrame.size.width*6/7, 45);
  [self.contentView addSubview:jtSwitch];
  
  UILabel *thumbDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, screenFrame.size.width-60, 20)];
  thumbDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  thumbDescriptionLabel.textColor = [UIColor grayColor];
  [thumbDescriptionLabel setText:@"Thumb On: #244DF2  Off: #F7F7F7"];
  [self.contentView addSubview:thumbDescriptionLabel];
  
  UILabel *trackDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, screenFrame.size.width-60, 20)];
  trackDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
  trackDescriptionLabel.textColor = [UIColor grayColor];
  [trackDescriptionLabel setText:@"Track   On: #7C9FF8  Off: #B4B4B4"];
  [self.contentView addSubview:trackDescriptionLabel];
  
  return self;
}


@end
