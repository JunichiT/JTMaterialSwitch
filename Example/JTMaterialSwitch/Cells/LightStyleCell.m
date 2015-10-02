//
//  LightStyleCell.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/10/03.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "LightStyleCell.h"
#import "JTMaterialSwitch.h"

@implementation LightStyleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, self.contentView.frame.size.width-60, 20)];
  [label setText:@"JTMaterialSwitchStyleLight:"];
  [self.contentView addSubview:label];
  
  JTMaterialSwitch *jtSwitch = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal
                                                                style:JTMaterialSwitchStyleLight
                                                                state:JTMaterialSwitchStateOff];
  jtSwitch.center = CGPointMake(self.contentView.frame.size.width-40, 40);
  [self.contentView addSubview:jtSwitch];
  
  return self;
}

@end
