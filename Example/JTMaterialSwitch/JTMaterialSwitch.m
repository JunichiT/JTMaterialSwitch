//
//  JTMaterialSwitch.m
//  JTMaterialSwitch
//
//  Created by Junichi Tsurukawa on 2015/07/29.
//
//  The MIT License (MIT)
//  Copyright (c) 2015 Junichi Tsurukawa. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "JTMaterialSwitch.h"

@implementation JTMaterialSwitch {
  float buttonOnPosition;
  float buttonOffPosition;
  float bouceOffset;
}

- (id)init {
  self = [super init];
  
  return self;
}

- (id)initWithSize:(JTMaterialSwitchSize)size WithState:(JTMaterialSwitchState)state {
  
  // initialize parameters
  self.buttonOnTintColor = [UIColor colorWithRed:49./255. green:117./255. blue:193./255. alpha:1.0];
  self.buttonOffTintColor = [UIColor whiteColor];
  bouceOffset = 3.0f;
  
  CGRect frame;
  CGRect sliderFrame = CGRectZero;
  CGRect buttonFrame = CGRectZero;

  // Determine switch size
  switch (size) {
    case JTMaterialSwitchSizeBig:
      frame = CGRectMake(0, 0, 60, 45);
      self.sliderThickness = 15.0;
      self.buttonSize = 30.0;
      break;
    
    case JTMaterialSwitchSizeNormal:
      frame = CGRectMake(0, 0, 40, 30);
      self.sliderThickness = 10.0;
      self.buttonSize = 20.0;
      break;
      
    case JTMaterialSwitchSizeSmall:
      frame = CGRectMake(0, 0, 30, 25);
      self.sliderThickness = 7.5;
      self.buttonSize = 15.0;
      break;
      
    default:
      frame = CGRectMake(0, 0, 40, 30);
      self.sliderThickness = 10.0;
      self.buttonSize = 20.0;
      break;
  }
  
  sliderFrame.size.height = self.sliderThickness;
  sliderFrame.size.width = frame.size.width;
  sliderFrame.origin.x = 0.0;
  sliderFrame.origin.y = (frame.size.height-sliderFrame.size.height)/2;
  buttonFrame.size.height = self.buttonSize;
  buttonFrame.size.width = buttonFrame.size.height;
  buttonFrame.origin.x = 0.0;
  buttonFrame.origin.y = (frame.size.height-buttonFrame.size.height)/2;
  
  // Actual initialization with selected size
  self = [super initWithFrame:frame];
  
  self.slider = [[UIView alloc] initWithFrame:sliderFrame];
  self.slider.backgroundColor = [UIColor grayColor];
  self.slider.layer.cornerRadius = MIN(self.slider.frame.size.height, self.slider.frame.size.width)/2;
  [self addSubview:self.slider];
  
  self.sliderButton = [[UIButton alloc] initWithFrame:buttonFrame];
  self.sliderButton.backgroundColor = [UIColor whiteColor];
  self.sliderButton.layer.cornerRadius = self.sliderButton.frame.size.height/2;
  self.sliderButton.layer.shadowOpacity = 1.0f;
  self.sliderButton.layer.shadowOffset = CGSizeMake(0.0, 1.0);
  self.sliderButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
  [self.sliderButton addTarget:self action:@selector(switchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  [self.sliderButton addTarget:self action:@selector(onTouchDragInside:withEvent:) forControlEvents:UIControlEventTouchDragInside];
  
  [self addSubview:self.sliderButton];
  
  buttonOnPosition = self.frame.size.width - self.sliderButton.frame.size.width + bouceOffset;
  buttonOffPosition = self.sliderButton.frame.origin.x - bouceOffset;
  
  // Set button's initial position from state property
  switch (state) {
    case JTMaterialSwitchStateOn:
      self.isOn = true;
      self.sliderButton.backgroundColor = self.buttonOnTintColor;
      CGRect buttonFrame = self.sliderButton.frame;
      buttonFrame.origin.x = buttonOnPosition;
      self.sliderButton.frame = buttonFrame;
      break;
      
    case JTMaterialSwitchStateOff:
      self.isOn = false;
      self.sliderButton.backgroundColor = self.buttonOffTintColor;
      break;
      
    default:
      self.isOn = false;
      self.sliderButton.backgroundColor = self.buttonOffTintColor;
      break;
  }
  
  UITapGestureRecognizer *singleTap =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(sliderTapped:)];
  [self.slider addGestureRecognizer:singleTap];
  
  return self;
}

- (id)initWithFrame:(CGRect)frame withState:(JTMaterialSwitchState)state {
  self = [super initWithFrame:frame];
  
  // initialize parameters
  self.buttonOnTintColor = [UIColor colorWithRed:49./255. green:117./255. blue:193./255. alpha:1.0];
  self.buttonOffTintColor = [UIColor whiteColor];
  self.sliderThickness = 10.0;
  self.buttonSize = 20.0;
  bouceOffset = 3.0f;
  

  CGRect sliderFrame = CGRectZero;
  sliderFrame.size.height = self.sliderThickness;
  sliderFrame.size.width = frame.size.width;
  sliderFrame.origin.x = 0.0;
  sliderFrame.origin.y = (frame.size.height-sliderFrame.size.height)/2;
  
  self.slider = [[UIView alloc] initWithFrame:sliderFrame];
  self.slider.backgroundColor = [UIColor grayColor];
  self.slider.layer.cornerRadius = MIN(self.slider.frame.size.height, self.slider.frame.size.width)/2;
  self.isOn = false;
  [self addSubview:self.slider];
  
  CGRect buttonFrame = CGRectZero;
  buttonFrame.size.height = self.buttonSize;
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
  [self.sliderButton addTarget:self action:@selector(onTouchDragInside:withEvent:) forControlEvents:UIControlEventTouchDragInside];

  [self addSubview:self.sliderButton];
  
  
  buttonOnPosition = self.frame.size.width - self.sliderButton.frame.size.width;
  buttonOffPosition = self.sliderButton.frame.origin.x;
  
  UITapGestureRecognizer *singleTap =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(sliderTapped:)];
  [self.slider addGestureRecognizer:singleTap];
  
  return self;
}

- (void)switchButtonTapped: (id)sender
{
  // Delegate method
  if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
    // sampleMethod2を呼び出す
    if (self.isOn == true) {
      [self.delegate switchStateChanged:JTMaterialSwitchStateOff];
    }
    else{
      [self.delegate switchStateChanged:JTMaterialSwitchStateOn];
    }
  }
  
  [self changeButtonPosition];

}

- (BOOL)getSwitchState
{
  return self.isOn;
}

//The event handling method
- (void)sliderTapped:(UITapGestureRecognizer *)recognizer
{
  // Delegate method
  if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
    // sampleMethod2を呼び出す
    if (self.isOn == true) {
      [self.delegate switchStateChanged:JTMaterialSwitchStateOff];
    }
    else{
      [self.delegate switchStateChanged:JTMaterialSwitchStateOn];
    }
  }
  
  [self changeButtonPosition];
}

- (void)changeButtonPosition
{
  if (self.isOn == true) {
    // switch movement animation
    [UIView animateWithDuration:0.15f
                          delay:0.1f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                       //アニメーションで変化させたい値を設定する(最終的に変更したい値)
                       CGRect buttonFrame = self.sliderButton.frame;
                       buttonFrame.origin.x = buttonOffPosition;
                       self.sliderButton.frame = buttonFrame;
                       self.sliderButton.backgroundColor = self.buttonOffTintColor;
//                       self.sliderButton.backgroundColor = [UIColor whiteColor];
                       self.slider.backgroundColor = [UIColor lightGrayColor];
                     }
                     completion:^(BOOL finished){
                       // change state to false
                       self.isOn = false;
                       NSLog(@"now isOn: %d", self.isOn);
                       // Bouncing effect: Move button a bit, for better UX
                       [UIView animateWithDuration:0.15f
                                        animations:^{
                                          // Bounce to the position
                                          CGRect buttonFrame = self.sliderButton.frame;
                                          buttonFrame.origin.x = buttonOffPosition+bouceOffset;
                                          self.sliderButton.frame = buttonFrame;
                                        }];
                     }];
  }
  
  else {
    // switch movement animation
    [UIView animateWithDuration:0.15f
                          delay:0.1f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                       //アニメーションで変化させたい値を設定する(最終的に変更したい値)
                       CGRect buttonFrame = self.sliderButton.frame;
                       buttonFrame.origin.x = buttonOnPosition;
                       self.sliderButton.frame = buttonFrame;
                       self.sliderButton.backgroundColor = self.buttonOnTintColor;
//                       self.sliderButton.backgroundColor = [UIColor colorWithRed:49./255. green:117./255. blue:193./255. alpha:1.0];
//                       self.slider.backgroundColor = [UIColor colorWithRed:127./255. green:164./255. blue:255./255. alpha:1.0];
                     }
                     completion:^(BOOL finished){
                       // change state to true
                       self.isOn = true;
                       NSLog(@"now isOn: %d", self.isOn);
                       // Bouncing effect: Move button a bit, for better UX
                       [UIView animateWithDuration:0.15f
                                        animations:^{
                                          // Bounce to the position
                                          CGRect buttonFrame = self.sliderButton.frame;
                                          buttonFrame.origin.x = buttonOnPosition-bouceOffset;
                                          self.sliderButton.frame = buttonFrame;
                                        }];
                     }];
  }
}

- (void)onTouchDragInside:(UIButton*)btn withEvent:(UIEvent*)event{
  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  if (btn.frame.origin.x >= buttonOffPosition && btn.frame.origin.x <= buttonOnPosition) {
    btn.center=CGPointMake(btn.center.x+dX, btn.center.y);
    NSLog(@"buttonOffPos: %f", buttonOffPosition);
    NSLog(@"btn.center.x+dX: %f", btn.center.x+dX);
    NSLog(@"buttonOnPos: %f", buttonOnPosition);
  }
}

// Touch circle effect



@end
