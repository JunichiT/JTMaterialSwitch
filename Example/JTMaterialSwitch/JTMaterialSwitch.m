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
#import <QuartzCore/QuartzCore.h>

@implementation JTMaterialSwitch {
  float buttonOnPosition;
  float buttonOffPosition;
  float bouceOffset;
  CAShapeLayer *circleShape;
}

- (id)init {
  self = [super init];
  return self;
}

- (id)initWithSize:(JTMaterialSwitchSize)size WithState:(JTMaterialSwitchState)state {
  
  // initialize parameters
  self.buttonOnTintColor  = [UIColor colorWithRed:52./255. green:109./255. blue:241./255. alpha:1.0];
  self.buttonOffTintColor = [UIColor colorWithRed:249./255. green:249./255. blue:249./255. alpha:1.0];
  self.sliderOnTintColor = [UIColor colorWithRed:143./255. green:179./255. blue:247./255. alpha:1.0];
  self.sliderOffTintColor = [UIColor colorWithRed:193./255. green:193./255. blue:193./255. alpha:1.0];

  bouceOffset = 3.0f;
  
  CGRect frame;
  CGRect sliderFrame = CGRectZero;
  CGRect buttonFrame = CGRectZero;

  // Determine switch size
  switch (size) {
    case JTMaterialSwitchSizeBig:
      frame = CGRectMake(0, 0, 60, 45);
      self.sliderThickness = 20.0;
      self.buttonSize = 30.0;
      break;
    
    case JTMaterialSwitchSizeNormal:
      frame = CGRectMake(0, 0, 40, 30);
      self.sliderThickness = 13.0;
      self.buttonSize = 20.0;
      break;
      
    case JTMaterialSwitchSizeSmall:
      frame = CGRectMake(0, 0, 30, 25);
      self.sliderThickness = 10;
      self.buttonSize = 15.0;
      break;
      
    default:
      frame = CGRectMake(0, 0, 40, 30);
      self.sliderThickness = 13.0;
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
  self.sliderButton.layer.shadowOpacity = 1.5;
  self.sliderButton.layer.shadowOffset = CGSizeMake(0.0, 1.5);
  self.sliderButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
  [self.sliderButton addTarget:self action:@selector(onTouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
  [self.sliderButton addTarget:self action:@selector(onTouchUpOutside:withEvent:) forControlEvents:UIControlEventTouchUpOutside];
  [self.sliderButton addTarget:self action:@selector(switchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  [self.sliderButton addTarget:self action:@selector(onTouchDragInside:withEvent:) forControlEvents:UIControlEventTouchDragInside];
  
  [self addSubview:self.sliderButton];
  
  buttonOnPosition = self.frame.size.width - self.sliderButton.frame.size.width/* + bouceOffset*/;
  buttonOffPosition = self.sliderButton.frame.origin.x/* - bouceOffset*/;
  
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
                                          action:@selector(switchAreaTapped:)];
  [self addGestureRecognizer:singleTap];
  
  return self;
}

//- (id)initWithSize:(JTMaterialSwitchSize)size WithState:(JTMaterialSwitchState)state WithStyle:(JTMaterialSwitchStyle)style {
//  self = [self initWithSize:size WithState:state];
//  
//  // Determine switch size
//  switch (style) {
//    case JTMaterialSwitchSizeBig:
//      frame = CGRectMake(0, 0, 60, 45);
//      self.sliderThickness = 20.0;
//      self.buttonSize = 30.0;
//      break;
//      
//    case JTMaterialSwitchSizeNormal:
//      frame = CGRectMake(0, 0, 40, 30);
//      self.sliderThickness = 13.0;
//      self.buttonSize = 20.0;
//      break;
//      
//    case JTMaterialSwitchSizeSmall:
//      frame = CGRectMake(0, 0, 30, 25);
//      self.sliderThickness = 10;
//      self.buttonSize = 15.0;
//      break;
//      
//    default:
//      frame = CGRectMake(0, 0, 40, 30);
//      self.sliderThickness = 13.0;
//      self.buttonSize = 20.0;
//      break;
//  }
//  
//  return self;
//}


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
                                          action:@selector(switchAreaTapped:)];
  [self addGestureRecognizer:singleTap];
  
  return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
  [super willMoveToSuperview:newSuperview];
  if(self.isOn == true) {
    self.sliderButton.backgroundColor = self.buttonOnTintColor;
    self.slider.backgroundColor = self.sliderOnTintColor;
  }
  else {
    self.sliderButton.backgroundColor = self.buttonOffTintColor;
    self.slider.backgroundColor = self.sliderOffTintColor;
  }
  
}


- (void)switchButtonTapped: (id)sender
{
  NSLog(@"touch up inside");
  NSLog(@"Slider midPosX: %f", CGRectGetMidX(self.slider.frame));
  NSLog(@"%@", NSStringFromCGRect(self.sliderButton.frame));
  // Delegate method
  if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
    if (self.isOn == true) {
      [self.delegate switchStateChanged:JTMaterialSwitchStateOff];
    }
    else{
      [self.delegate switchStateChanged:JTMaterialSwitchStateOn];
    }
  }
  
  [self changeButtonPosition];
  
  [self sendActionsForControlEvents:UIControlEventValueChanged];

}

- (BOOL)getSwitchState
{
  return self.isOn;
}

//The event handling method
- (void)switchAreaTapped:(UITapGestureRecognizer *)recognizer
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
  [self sendActionsForControlEvents:UIControlEventValueChanged];
  

}

- (void)changeButtonPosition
{
  NSLog(@"Button origin pos: %@", NSStringFromCGRect(self.sliderButton.frame));
  if (self.isOn == true) {
    [self changeButtonStateOFFwithAnimation];
  }
  
  else {
    [self changeButtonStateONwithAnimation];
  }
  
  [self removeRippleShape];
}

- (void)changeButtonStateONwithAnimation
{
  // switch movement animation
  [UIView animateWithDuration:0.15f
                        delay:0.05f
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     //アニメーションで変化させたい値を設定する(最終的に変更したい値)
                     CGRect buttonFrame = self.sliderButton.frame;
                     buttonFrame.origin.x = buttonOnPosition+bouceOffset;
                     self.sliderButton.frame = buttonFrame;
                     self.sliderButton.backgroundColor = self.buttonOnTintColor;
                     self.slider.backgroundColor = self.sliderOnTintColor;
                   }
                   completion:^(BOOL finished){
                     // change state to true
                     self.isOn = true;
                     NSLog(@"now isOn: %d", self.isOn);
                     NSLog(@"Button end pos: %@", NSStringFromCGRect(self.sliderButton.frame));
                     // Bouncing effect: Move button a bit, for better UX
                     [UIView animateWithDuration:0.15f
                                      animations:^{
                                        // Bounce to the position
                                        CGRect buttonFrame = self.sliderButton.frame;
                                        buttonFrame.origin.x = buttonOnPosition;
                                        self.sliderButton.frame = buttonFrame;
                                      }];
                   }];
}

- (void)changeButtonStateOFFwithAnimation
{
  // switch movement animation
  [UIView animateWithDuration:0.15f
                        delay:0.05f
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     //アニメーションで変化させたい値を設定する(最終的に変更したい値)
                     CGRect buttonFrame = self.sliderButton.frame;
                     buttonFrame.origin.x = buttonOffPosition-bouceOffset;
                     self.sliderButton.frame = buttonFrame;
                     self.sliderButton.backgroundColor = self.buttonOffTintColor;
                     self.slider.backgroundColor = self.sliderOffTintColor;
                   }
                   completion:^(BOOL finished){
                     // change state to false
                     self.isOn = false;
                     NSLog(@"now isOn: %d", self.isOn);
                     NSLog(@"Button end pos: %@", NSStringFromCGRect(self.sliderButton.frame));
                     // Bouncing effect: Move button a bit, for better UX
                     [UIView animateWithDuration:0.15f
                                      animations:^{
                                        // Bounce to the position
                                        CGRect buttonFrame = self.sliderButton.frame;
                                        buttonFrame.origin.x = buttonOffPosition;
                                        self.sliderButton.frame = buttonFrame;
                                      }];
                   }];
}

- (void)createRippleShape
{
  float rippleScale = 2;
  CGRect pathFrame = CGRectZero;
  pathFrame.origin.x = -self.sliderButton.frame.size.width/(rippleScale * 2);
  pathFrame.origin.y = -self.sliderButton.frame.size.height/(rippleScale * 2);
  pathFrame.size.height = self.sliderButton.frame.size.height * rippleScale;
  pathFrame.size.width = pathFrame.size.height;
  //  NSLog(@"");
  //  NSLog(@"Button State: %d", self.isOn);
  //  NSLog(@"sliderButton pos: %@", NSStringFromCGRect(self.sliderButton.frame));
  
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.sliderButton.layer.cornerRadius*2];
  
  // accounts for left/right offset and contentOffset of scroll view
  circleShape = [CAShapeLayer layer];
  circleShape.path = path.CGPath;
  circleShape.frame = pathFrame;
  circleShape.opacity = .4;
  circleShape.strokeColor = [UIColor clearColor].CGColor;
  circleShape.fillColor = [UIColor blueColor].CGColor;
  circleShape.lineWidth = 0;
  //  NSLog(@"Ripple origin pos: %@", NSStringFromCGRect(circleShape.frame));
  [self.sliderButton.layer insertSublayer:circleShape atIndex:1];
  //  [self.layer insertSublayer:circleShape below:self.sliderButton.layer];
}


- (void)removeRippleShape
{
  if ( circleShape == nil) {
    [self createRippleShape];
  }
  
  circleShape.opacity = .0;
  [CATransaction begin];
  
  //remove layer after animation completed
  [CATransaction setCompletionBlock:^{
    [circleShape removeFromSuperlayer];
    circleShape = nil;
  }];
  
  CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scaleAnimation.fromValue = [NSNumber numberWithFloat:0.5];
  scaleAnimation.toValue = [NSNumber numberWithFloat:1.2];
  
  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  alphaAnimation.fromValue = @0.4;
  alphaAnimation.toValue = @0;
  
  CAAnimationGroup *animation = [CAAnimationGroup animation];
  animation.animations = @[scaleAnimation, alphaAnimation];
  animation.duration = 0.4f;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  [circleShape addAnimation:animation forKey:nil];
  
  [CATransaction commit];
  NSLog(@"Ripple removed");
}

- (void)setEnabled:(BOOL)enabled
{
  [super setEnabled:enabled];
  
  [UIView animateWithDuration:0.1 animations:^{
    if (enabled == YES) {
      if (self.isOn == true) {
        self.sliderButton.backgroundColor = self.buttonOnTintColor;
        self.slider.backgroundColor = self.sliderOnTintColor;
      }
      else {
        self.sliderButton.backgroundColor = self.buttonOffTintColor;
        self.slider.backgroundColor = self.sliderOffTintColor;
      }
    }
    // if disabled
    else {
      self.sliderButton.backgroundColor = [UIColor colorWithRed:174./255. green:174./255. blue:174./255. alpha:1.0];
      self.slider.backgroundColor = [UIColor colorWithRed:203./255. green:203./255. blue:203./255. alpha:1.0];
    }
  }completion:^(BOOL finished) {
    
  }];
  
  
}

- (void)onTouchDown:(UIButton*)btn withEvent:(UIEvent*)event{
  NSLog(@"touchDown called");
  
  [self createRippleShape];
  
  [CATransaction begin];
  
  CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
  scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
  
  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  alphaAnimation.fromValue = @0;
  alphaAnimation.toValue = @0.4;
  
  CAAnimationGroup *animation = [CAAnimationGroup animation];
  animation.animations = @[scaleAnimation, alphaAnimation];
  animation.duration = 0.4f;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  [circleShape addAnimation:animation forKey:nil];
  
  [CATransaction commit];
//  NSLog(@"Ripple end pos: %@", NSStringFromCGRect(circleShape.frame));
  
}

- (void)onTouchUpOutside:(UIButton*)btn withEvent:(UIEvent*)event{
  NSLog(@"Touch released at ouside");
  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  //Get the new origin after this motion
  float newXOrigin = btn.frame.origin.x + dX;
  NSLog(@"Released tap X pos: %f", newXOrigin);
  
  if (newXOrigin >= self.slider.frame.size.width/2) {
    NSLog(@"Button pos should be set *ON*");
    [self changeButtonStateONwithAnimation];
  }
  else {
    NSLog(@"Button pos should be set *OFF*");
    [self changeButtonStateOFFwithAnimation];
  }
  
  [self removeRippleShape];
}

- (void)onTouchDragInside:(UIButton*)btn withEvent:(UIEvent*)event{

  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  //Get the new origin after this motion
  float newXOrigin = btn.frame.origin.x + dX;
  
  if (newXOrigin > buttonOnPosition) {
//    NSLog(@"Needs to set button pos to ON");
//    [self changeButtonPosition];
  }
  else if (newXOrigin < buttonOffPosition) {
//    NSLog(@"Needs to set button pos to Off");
//    [self changeButtonPosition];
  }
  else {
    //Make sure it's within two bounds
    newXOrigin = MIN(newXOrigin,buttonOnPosition);
    newXOrigin = MAX(newXOrigin,buttonOffPosition);
    //Now get the new dX value staying in bounds
    dX = newXOrigin - btn.frame.origin.x;
    
    btn.center=CGPointMake(btn.center.x+dX, btn.center.y);
    
  }
}

@end
