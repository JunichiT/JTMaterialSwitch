//
//  JTMaterialSwitch.m
//  JTMaterialSwitch
//
//  Created by Junichi Tsurukawa on 2015/09/06.
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

@interface JTMaterialSwitch()
#pragma Size
/** A CGFloat value to represent the slider thickness of this switch */
@property (nonatomic) CGFloat sliderThickness;
/** A CGFloat value to represent the switch button size(width and height) */
@property (nonatomic) CGFloat buttonSize;

@end

@implementation JTMaterialSwitch {
  float buttonOnPosition;
  float buttonOffPosition;
  float bounceOffset;
  JTMaterialSwitchStyle buttonStyle;
  CAShapeLayer *circleShape;
}

// init is prohibited for designated initializer
- (id)init
{
  [NSException raise:NSGenericException
              format:@"Disabled to call init method. Use +[[%@ alloc] %@] instead",
   NSStringFromClass([self class]),
   NSStringFromSelector(@selector(initWithSize:state:))];
  return nil;
}

- (id)initWithSize:(JTMaterialSwitchSize)size state:(JTMaterialSwitchState)state
{
  // initialize parameters
  self.buttonOnTintColor  = [UIColor colorWithRed:52./255. green:109./255. blue:241./255. alpha:1.0];
  self.buttonOffTintColor = [UIColor colorWithRed:249./255. green:249./255. blue:249./255. alpha:1.0];
  self.sliderOnTintColor = [UIColor colorWithRed:143./255. green:179./255. blue:247./255. alpha:1.0];
  self.sliderOffTintColor = [UIColor colorWithRed:193./255. green:193./255. blue:193./255. alpha:1.0];
  self.buttonDisabledTintColor = [UIColor colorWithRed:174./255. green:174./255. blue:174./255. alpha:1.0];
  self.sliderDisabledTintColor = [UIColor colorWithRed:203./255. green:203./255. blue:203./255. alpha:1.0];
  self.isRaised = YES;
  self.isRippleEnabled = YES;
  self.isBounceEnabled = YES;
  self.rippleFillColor = [UIColor blueColor];
  bounceOffset = 3.0f;
  
  CGRect frame;
  CGRect sliderFrame = CGRectZero;
  CGRect buttonFrame = CGRectZero;

  // Determine switch size
  switch (size) {
    case JTMaterialSwitchSizeBig:
      frame = CGRectMake(0, 0, 50, 40);
      self.sliderThickness = 23.0;
      self.buttonSize = 31.0;
      break;
    
    case JTMaterialSwitchSizeNormal:
      frame = CGRectMake(0, 0, 40, 30);
      self.sliderThickness = 17.0;
      self.buttonSize = 24.0;
      break;
      
    case JTMaterialSwitchSizeSmall:
      frame = CGRectMake(0, 0, 30, 25);
      self.sliderThickness = 13.0;
      self.buttonSize = 18.0;
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
  self.sliderButton.layer.shadowOpacity = 0.5;
  self.sliderButton.layer.shadowOffset = CGSizeMake(0.0, 1.0);
  self.sliderButton.layer.shadowColor = [UIColor blackColor].CGColor;
  self.sliderButton.layer.shadowRadius = 2.0f;
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

- (id)initWithSize:(JTMaterialSwitchSize)size style:(JTMaterialSwitchStyle)style state:(JTMaterialSwitchState)state
{
  self = [self initWithSize:size state:state];
  buttonStyle = style;
  // Determine switch style from preset colour set
  // Light and Dark color styles come from Google's design guidelines
  // https://www.google.com/design/spec/components/selection-controls.html
  switch (style) {
    case JTMaterialSwitchStyleLight:
      self.buttonOnTintColor  = [UIColor colorWithRed:0./255. green:134./255. blue:117./255. alpha:1.0];
      self.buttonOffTintColor = [UIColor colorWithRed:237./255. green:237./255. blue:237./255. alpha:1.0];
      self.sliderOnTintColor = [UIColor colorWithRed:90./255. green:178./255. blue:169./255. alpha:1.0];
      self.sliderOffTintColor = [UIColor colorWithRed:129./255. green:129./255. blue:129./255. alpha:1.0];
      self.buttonDisabledTintColor = [UIColor colorWithRed:175./255. green:175./255. blue:175./255. alpha:1.0];
      self.sliderDisabledTintColor = [UIColor colorWithRed:203./255. green:203./255. blue:203./255. alpha:1.0];
      self.rippleFillColor = [UIColor grayColor];
      break;
      
    case JTMaterialSwitchStyleDark:
      self.buttonOnTintColor  = [UIColor colorWithRed:109./255. green:194./255. blue:184./255. alpha:1.0];
      self.buttonOffTintColor = [UIColor colorWithRed:175./255. green:175./255. blue:175./255. alpha:1.0];
      self.sliderOnTintColor = [UIColor colorWithRed:72./255. green:109./255. blue:105./255. alpha:1.0];
      self.sliderOffTintColor = [UIColor colorWithRed:94./255. green:94./255. blue:94./255. alpha:1.0];
      self.buttonDisabledTintColor = [UIColor colorWithRed:50./255. green:51./255. blue:50./255. alpha:1.0];
      self.sliderDisabledTintColor = [UIColor colorWithRed:56./255. green:56./255. blue:56./255. alpha:1.0];
      self.rippleFillColor = [UIColor grayColor];
      break;
      
    default:
      self.buttonOnTintColor  = [UIColor colorWithRed:52./255. green:109./255. blue:241./255. alpha:1.0];
      self.buttonOffTintColor = [UIColor colorWithRed:249./255. green:249./255. blue:249./255. alpha:1.0];
      self.sliderOnTintColor = [UIColor colorWithRed:143./255. green:179./255. blue:247./255. alpha:1.0];
      self.sliderOffTintColor = [UIColor colorWithRed:193./255. green:193./255. blue:193./255. alpha:1.0];
      self.buttonDisabledTintColor = [UIColor colorWithRed:174./255. green:174./255. blue:174./255. alpha:1.0];
      self.sliderDisabledTintColor = [UIColor colorWithRed:203./255. green:203./255. blue:203./255. alpha:1.0];
      self.rippleFillColor = [UIColor blueColor];
      break;
  }
  
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
  
  if (self.isBounceEnabled == YES) {
    bounceOffset = 3.0f;
  }
  else {
    bounceOffset = 0.0f;
  }
  
}

- (void)switchButtonTapped: (id)sender
{
  // NSLog(@"touch up inside");
  // NSLog(@"Slider midPosX: %f", CGRectGetMidX(self.slider.frame));
  // NSLog(@"%@", NSStringFromCGRect(self.sliderButton.frame));
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

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
  if (on == YES) {
    if (animated == YES) {
      // set on with animation
      [self changeButtonStateONwithAnimation];
    }
    else {
      // set on without animation
      [self changeButtonStateONwithoutAnimation];
    }
  }
  else {
    if (animated == YES) {
      // set off with animation
      [self changeButtonStateOFFwithAnimation];
    }
    else {
      // set off without animation
      [self changeButtonStateOFFwithoutAnimation];
    }
  }
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
  // NSLog(@"Button origin pos: %@", NSStringFromCGRect(self.sliderButton.frame));
  if (self.isOn == true) {
    [self changeButtonStateOFFwithAnimation];
  }
  else {
    [self changeButtonStateONwithAnimation];
  }
  
  if (self.isRippleEnabled == YES) {
    [self removeRippleShape];
  }
}

- (void)changeButtonStateONwithAnimation
{
  // switch movement animation
  [UIView animateWithDuration:0.15f
                        delay:0.05f
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     // animation which is to be
                     CGRect buttonFrame = self.sliderButton.frame;
                     buttonFrame.origin.x = buttonOnPosition+bounceOffset;
                     self.sliderButton.frame = buttonFrame;
                     if (self.isEnabled == YES) {
                       self.sliderButton.backgroundColor = self.buttonOnTintColor;
                       self.slider.backgroundColor = self.sliderOnTintColor;
                     }
                     else {
                       self.sliderButton.backgroundColor = self.buttonDisabledTintColor;
                       self.slider.backgroundColor = self.sliderDisabledTintColor;
                     }
                     self.userInteractionEnabled = NO;
                   }
                   completion:^(BOOL finished){
                     // change state to true
                     self.isOn = true;
                     // NSLog(@"now isOn: %d", self.isOn);
                     // NSLog(@"Button end pos: %@", NSStringFromCGRect(self.sliderButton.frame));
                     // Bouncing effect: Move button a bit, for better UX
                     [UIView animateWithDuration:0.15f
                                      animations:^{
                                        // Bounce to the position
                                        CGRect buttonFrame = self.sliderButton.frame;
                                        buttonFrame.origin.x = buttonOnPosition;
                                        self.sliderButton.frame = buttonFrame;
                                      }
                                      completion:^(BOOL finished){
                                        self.userInteractionEnabled = YES;
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
                     buttonFrame.origin.x = buttonOffPosition-bounceOffset;
                     self.sliderButton.frame = buttonFrame;
                     if (self.isEnabled == YES) {
                       self.sliderButton.backgroundColor = self.buttonOffTintColor;
                       self.slider.backgroundColor = self.sliderOffTintColor;
                     }
                     else {
                       self.sliderButton.backgroundColor = self.buttonDisabledTintColor;
                       self.slider.backgroundColor = self.sliderDisabledTintColor;
                     }
                     self.userInteractionEnabled = NO;
                   }
                   completion:^(BOOL finished){
                     // change state to false
                     self.isOn = false;
                     // NSLog(@"now isOn: %d", self.isOn);
                     // NSLog(@"Button end pos: %@", NSStringFromCGRect(self.sliderButton.frame));
                     // Bouncing effect: Move button a bit, for better UX
                     [UIView animateWithDuration:0.15f
                                      animations:^{
                                        // Bounce to the position
                                        CGRect buttonFrame = self.sliderButton.frame;
                                        buttonFrame.origin.x = buttonOffPosition;
                                        self.sliderButton.frame = buttonFrame;
                                      }
                                      completion:^(BOOL finished){
                                        self.userInteractionEnabled = YES;
                                      }];
                   }];
}

- (void)changeButtonStateONwithoutAnimation
{
  CGRect buttonFrame = self.sliderButton.frame;
  buttonFrame.origin.x = buttonOnPosition;
  self.sliderButton.frame = buttonFrame;
  if (self.isEnabled == YES) {
    self.sliderButton.backgroundColor = self.buttonOnTintColor;
    self.slider.backgroundColor = self.sliderOnTintColor;
  }
  else {
    self.sliderButton.backgroundColor = self.buttonDisabledTintColor;
    self.slider.backgroundColor = self.sliderDisabledTintColor;
  }
  self.isOn = true;
}

- (void)changeButtonStateOFFwithoutAnimation
{
  CGRect buttonFrame = self.sliderButton.frame;
  buttonFrame.origin.x = buttonOffPosition;
  self.sliderButton.frame = buttonFrame;
  if (self.isEnabled == YES) {
    self.sliderButton.backgroundColor = self.buttonOffTintColor;
    self.slider.backgroundColor = self.sliderOffTintColor;
  }
  else {
    self.sliderButton.backgroundColor = self.buttonDisabledTintColor;
    self.slider.backgroundColor = self.sliderDisabledTintColor;
  }
  self.isOn = false;
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
  circleShape.opacity = 0.2;
  circleShape.strokeColor = [UIColor clearColor].CGColor;
  circleShape.fillColor = self.rippleFillColor.CGColor;
  circleShape.lineWidth = 0;
  //  NSLog(@"Ripple origin pos: %@", NSStringFromCGRect(circleShape.frame));
  [self.sliderButton.layer insertSublayer:circleShape below:self.sliderButton.layer];
//    [self.layer insertSublayer:circleShape above:self.sliderButton.layer];
}


- (void)removeRippleShape
{
  if ( circleShape == nil) {
    [self createRippleShape];
  }
  
  circleShape.opacity = 0.0;
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
  // NSLog(@"Ripple removed");
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
      self.sliderButton.backgroundColor = self.buttonDisabledTintColor;
      self.slider.backgroundColor = self.sliderDisabledTintColor;
    }
  }];
}

- (void)onTouchDown:(UIButton*)btn withEvent:(UIEvent*)event
{
  // NSLog(@"touchDown called");
  if (self.isRippleEnabled == YES) {
    [self createRippleShape];
  }
  
  [CATransaction begin];
  
  CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
  scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
  
  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  alphaAnimation.fromValue = @0;
  alphaAnimation.toValue = @0.2;
  
  CAAnimationGroup *animation = [CAAnimationGroup animation];
  animation.animations = @[scaleAnimation, alphaAnimation];
  animation.duration = 0.4f;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  [circleShape addAnimation:animation forKey:nil];
  
  [CATransaction commit];
//  NSLog(@"Ripple end pos: %@", NSStringFromCGRect(circleShape.frame));
}

- (void)onTouchUpOutside:(UIButton*)btn withEvent:(UIEvent*)event
{
  // NSLog(@"Touch released at ouside");
  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  //Get the new origin after this motion
  float newXOrigin = btn.frame.origin.x + dX;
  // NSLog(@"Released tap X pos: %f", newXOrigin);
  
  if (newXOrigin >= self.slider.frame.size.width/2) {
    // NSLog(@"Button pos should be set *ON*");
    [self changeButtonStateONwithAnimation];
  }
  else {
    // NSLog(@"Button pos should be set *OFF*");
    [self changeButtonStateOFFwithAnimation];
  }
  
  if (self.isRippleEnabled == YES) {
    [self removeRippleShape];
  }
}

- (void)onTouchDragInside:(UIButton*)btn withEvent:(UIEvent*)event
{
  //This code can go awry if there is more than one finger on the screen, careful
  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  //Get the original position of the button
  CGRect buttonFrame = btn.frame;
  
  buttonFrame.origin.x += dX;
  //Make sure it's within your two bounds
  buttonFrame.origin.x = MIN(buttonFrame.origin.x,buttonOnPosition);
  buttonFrame.origin.x = MAX(buttonFrame.origin.x,buttonOffPosition);
  
  //Set the button's new frame if we need to
  if(buttonFrame.origin.x != btn.frame.origin.x) {
    btn.frame = buttonFrame;
  }
}

@end
