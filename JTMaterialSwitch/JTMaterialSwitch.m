//
//  JTMaterialSwitch.m
//  JTMaterialSwitch
//
//  Created by El Capitan on 2015/09/06.
//  Copyright © 2015年 Junichi Tsurukawa. All rights reserved.
//

#import "JTMaterialSwitch.h"

@implementation JTMaterialSwitch

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  CGRect sliderFrame = CGRectZero;
  sliderFrame.size.height = 15.0;
  sliderFrame.size.width = frame.size.width;
  sliderFrame.origin.x = 0.0;
  sliderFrame.origin.y = (frame.size.height-sliderFrame.size.height)/2;
  
  UIView *slider = [[UIView alloc] initWithFrame:sliderFrame];
  slider.backgroundColor = [UIColor grayColor];
  slider.layer.cornerRadius = MIN(slider.frame.size.height, slider.frame.size.width)/2;
  self.isOn = false;
  [self addSubview:slider];
  
  CGRect buttonFrame = CGRectZero;
  buttonFrame.size.height = 20.0;
  buttonFrame.size.width = buttonFrame.size.height;
  buttonFrame.origin.x = 0.0;
  buttonFrame.origin.y = (frame.size.height-buttonFrame.size.height)/2;
  
  self.sliderButton = [[UIButton alloc] initWithFrame:buttonFrame];
  self.sliderButton.backgroundColor = [UIColor whiteColor];
  self.sliderButton.layer.cornerRadius = self.sliderButton.frame.size.height/2;
  self.sliderButton.layer.shadowOpacity = 1.0f;
  self.sliderButton.layer.shadowOffset = CGSizeMake(0.0, 1.0);
  self.sliderButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
  [self.sliderButton addTarget:self action:@selector(switchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  
  [self addSubview:self.sliderButton];
  
  return self;
}

- (void)switchButtonTapped: (id)sender
{
  if (self.isOn == true) {
    // switch movement animation
    [UIView animateWithDuration:0.15f delay:0.1f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
      //アニメーションで変化させたい値を設定する(最終的に変更したい値)
      CGRect buttonFrame = self.sliderButton.frame;
      buttonFrame.origin.x = self.frame.size.width - self.sliderButton.frame.size.width;
      self.sliderButton.frame = buttonFrame;
      self.sliderButton.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
      // change state to false
      self.isOn = false;
    }];
  }
  
  else {
    // switch movement animation
    [UIView animateWithDuration:0.15f delay:0.1f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
      //アニメーションで変化させたい値を設定する(最終的に変更したい値)
      CGRect buttonFrame = self.sliderButton.frame;
      buttonFrame.origin.x = 0.0;
      self.sliderButton.frame = buttonFrame;
      self.sliderButton.backgroundColor = [UIColor orangeColor];
    } completion:^(BOOL finished) {
      // change state to false
      self.isOn = true;
    }];
  }
  NSLog(@"now isOn: %d", self.isOn);
}

@end
