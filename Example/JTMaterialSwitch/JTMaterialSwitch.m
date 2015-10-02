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

#pragma PROHIBITED method
/**
 *  Using init method is prohibited. Use above designated initializers instead.
 */
- (id)init __attribute__((unavailable("init is not available")));

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
  CAShapeLayer *rippleLayer;
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

// Designated initializer
- (id)initWithSize:(JTMaterialSwitchSize)size state:(JTMaterialSwitchState)state
{
  // initialize parameters
  self.buttonOnTintColor  = [UIColor colorWithRed:52./255. green:109./255. blue:241./255. alpha:1.0];
  self.buttonOffTintColor = [UIColor colorWithRed:249./255. green:249./255. blue:249./255. alpha:1.0];
  self.sliderOnTintColor = [UIColor colorWithRed:143./255. green:179./255. blue:247./255. alpha:1.0];
  self.sliderOffTintColor = [UIColor colorWithRed:193./255. green:193./255. blue:193./255. alpha:1.0];
  self.buttonDisabledTintColor = [UIColor colorWithRed:174./255. green:174./255. blue:174./255. alpha:1.0];
  self.sliderDisabledTintColor = [UIColor colorWithRed:203./255. green:203./255. blue:203./255. alpha:1.0];
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
  
  self.switchButton = [[UIButton alloc] initWithFrame:buttonFrame];
  self.switchButton.backgroundColor = [UIColor whiteColor];
  self.switchButton.layer.cornerRadius = self.switchButton.frame.size.height/2;
  self.switchButton.layer.shadowOpacity = 0.5;
  self.switchButton.layer.shadowOffset = CGSizeMake(0.0, 1.0);
  self.switchButton.layer.shadowColor = [UIColor blackColor].CGColor;
  self.switchButton.layer.shadowRadius = 2.0f;
  // Add events for user action
  [self.switchButton addTarget:self action:@selector(onTouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
  [self.switchButton addTarget:self action:@selector(onTouchUpOutside:withEvent:) forControlEvents:UIControlEventTouchUpOutside];
  [self.switchButton addTarget:self action:@selector(switchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  [self.switchButton addTarget:self action:@selector(onTouchDragInside:withEvent:) forControlEvents:UIControlEventTouchDragInside];
  
  [self addSubview:self.switchButton];
  
  buttonOnPosition = self.frame.size.width - self.switchButton.frame.size.width;
  buttonOffPosition = self.switchButton.frame.origin.x;
  
  // Set button's initial position from state property
  switch (state) {
    case JTMaterialSwitchStateOn:
      self.isOn = YES;
      self.switchButton.backgroundColor = self.buttonOnTintColor;
      CGRect buttonFrame = self.switchButton.frame;
      buttonFrame.origin.x = buttonOnPosition;
      self.switchButton.frame = buttonFrame;
      break;
      
    case JTMaterialSwitchStateOff:
      self.isOn = NO;
      self.switchButton.backgroundColor = self.buttonOffTintColor;
      break;
      
    default:
      self.isOn = NO;
      self.switchButton.backgroundColor = self.buttonOffTintColor;
      break;
  }
  
  UITapGestureRecognizer *singleTap =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(switchAreaTapped:)];
  [self addGestureRecognizer:singleTap];
  
  return self;
}

// Designated initializer with size, style and state
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

// When addSubview is called
- (void)willMoveToSuperview:(UIView *)newSuperview
{
  [super willMoveToSuperview:newSuperview];
  
  // Set colors for proper positions
  if(self.isOn == YES) {
    self.switchButton.backgroundColor = self.buttonOnTintColor;
    self.slider.backgroundColor = self.sliderOnTintColor;
  }
  else {
    self.switchButton.backgroundColor = self.buttonOffTintColor;
    self.slider.backgroundColor = self.sliderOffTintColor;
  }
  
  // Set bounce value, 3.0 if enabled and none for disabled
  if (self.isBounceEnabled == YES) {
    bounceOffset = 3.0f;
  }
  else {
    bounceOffset = 0.0f;
  }
}

// Just returns current switch state,
- (BOOL)getSwitchState
{
  return self.isOn;
}

// Change switch state if necessary, with the animated option parameter
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

// Override setEnabled: function for changing color to the correct style
- (void)setEnabled:(BOOL)enabled
{
  [super setEnabled:enabled];
  
  // Animation for better transfer, better UX
  [UIView animateWithDuration:0.1 animations:^{
    if (enabled == YES) {
      if (self.isOn == YES) {
        self.switchButton.backgroundColor = self.buttonOnTintColor;
        self.slider.backgroundColor = self.sliderOnTintColor;
      }
      else {
        self.switchButton.backgroundColor = self.buttonOffTintColor;
        self.slider.backgroundColor = self.sliderOffTintColor;
      }
    }
    // if disabled
    else {
      self.switchButton.backgroundColor = self.buttonDisabledTintColor;
      self.slider.backgroundColor = self.sliderDisabledTintColor;
    }
  }];
}

//The event handling method
- (void)switchAreaTapped:(UITapGestureRecognizer *)recognizer
{
  // Delegate method
  if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
    // sampleMethod2を呼び出す
    if (self.isOn == YES) {
      [self.delegate switchStateChanged:JTMaterialSwitchStateOff];
    }
    else{
      [self.delegate switchStateChanged:JTMaterialSwitchStateOn];
    }
  }
  
  [self changeButtonState];
}

- (void)changeButtonState
{
  // NSLog(@"Button origin pos: %@", NSStringFromCGRect(self.switchButton.frame));
  if (self.isOn == YES) {
    [self changeButtonStateOFFwithAnimation];
  }
  else {
    [self changeButtonStateONwithAnimation];
  }
  
  if (self.isRippleEnabled == YES) {
    [self animateRippleEffect];
  }
}

- (void)changeButtonStateONwithAnimation
{
  // switch movement animation
  [UIView animateWithDuration:0.15f
                        delay:0.05f
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     CGRect buttonFrame = self.switchButton.frame;
                     buttonFrame.origin.x = buttonOnPosition+bounceOffset;
                     self.switchButton.frame = buttonFrame;
                     if (self.isEnabled == YES) {
                       self.switchButton.backgroundColor = self.buttonOnTintColor;
                       self.slider.backgroundColor = self.sliderOnTintColor;
                     }
                     else {
                       self.switchButton.backgroundColor = self.buttonDisabledTintColor;
                       self.slider.backgroundColor = self.sliderDisabledTintColor;
                     }
                     self.userInteractionEnabled = NO;
                   }
                   completion:^(BOOL finished){
                     // change state to ON
                     if (self.isOn == NO) {
                       self.isOn = YES; // Expressly put this code here to change surely and send action correctly
                       [self sendActionsForControlEvents:UIControlEventValueChanged];
                     }
                     self.isOn = YES;
                     // NSLog(@"now isOn: %d", self.isOn);
                     // NSLog(@"Button end pos: %@", NSStringFromCGRect(self.switchButton.frame));
                     // Bouncing effect: Move button a bit, for better UX
                     [UIView animateWithDuration:0.15f
                                      animations:^{
                                        // Bounce to the position
                                        CGRect buttonFrame = self.switchButton.frame;
                                        buttonFrame.origin.x = buttonOnPosition;
                                        self.switchButton.frame = buttonFrame;
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
                     CGRect buttonFrame = self.switchButton.frame;
                     buttonFrame.origin.x = buttonOffPosition-bounceOffset;
                     self.switchButton.frame = buttonFrame;
                     if (self.isEnabled == YES) {
                       self.switchButton.backgroundColor = self.buttonOffTintColor;
                       self.slider.backgroundColor = self.sliderOffTintColor;
                     }
                     else {
                       self.switchButton.backgroundColor = self.buttonDisabledTintColor;
                       self.slider.backgroundColor = self.sliderDisabledTintColor;
                     }
                     self.userInteractionEnabled = NO;
                   }
                   completion:^(BOOL finished){
                     // change state to OFF
                     if (self.isOn == YES) {
                       self.isOn = NO; // Expressly put this code here to change surely and send action correctly
                       [self sendActionsForControlEvents:UIControlEventValueChanged];
                     }
                     self.isOn = NO;
                     // NSLog(@"now isOn: %d", self.isOn);
                     // NSLog(@"Button end pos: %@", NSStringFromCGRect(self.switchButton.frame));
                     // Bouncing effect: Move button a bit, for better UX
                     [UIView animateWithDuration:0.15f
                                      animations:^{
                                        // Bounce to the position
                                        CGRect buttonFrame = self.switchButton.frame;
                                        buttonFrame.origin.x = buttonOffPosition;
                                        self.switchButton.frame = buttonFrame;
                                      }
                                      completion:^(BOOL finished){
                                        self.userInteractionEnabled = YES;
                                      }];
                   }];
}

// Without animation
- (void)changeButtonStateONwithoutAnimation
{
  CGRect buttonFrame = self.switchButton.frame;
  buttonFrame.origin.x = buttonOnPosition;
  self.switchButton.frame = buttonFrame;
  if (self.isEnabled == YES) {
    self.switchButton.backgroundColor = self.buttonOnTintColor;
    self.slider.backgroundColor = self.sliderOnTintColor;
  }
  else {
    self.switchButton.backgroundColor = self.buttonDisabledTintColor;
    self.slider.backgroundColor = self.sliderDisabledTintColor;
  }
  
  if (self.isOn == NO) {
    self.isOn = YES;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
  self.isOn = YES;
}

// Without animation
- (void)changeButtonStateOFFwithoutAnimation
{
  CGRect buttonFrame = self.switchButton.frame;
  buttonFrame.origin.x = buttonOffPosition;
  self.switchButton.frame = buttonFrame;
  if (self.isEnabled == YES) {
    self.switchButton.backgroundColor = self.buttonOffTintColor;
    self.slider.backgroundColor = self.sliderOffTintColor;
  }
  else {
    self.switchButton.backgroundColor = self.buttonDisabledTintColor;
    self.slider.backgroundColor = self.sliderDisabledTintColor;
  }
  
  if (self.isOn == YES) {
    self.isOn = NO;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
  self.isOn = NO;
}

// Initialize and appear ripple effect
- (void)initializeRipple
{
  // Ripple size is twice as large as switch button
  float rippleScale = 2;
  CGRect rippleFrame = CGRectZero;
  rippleFrame.origin.x = -self.switchButton.frame.size.width/(rippleScale * 2);
  rippleFrame.origin.y = -self.switchButton.frame.size.height/(rippleScale * 2);
  rippleFrame.size.height = self.switchButton.frame.size.height * rippleScale;
  rippleFrame.size.width = rippleFrame.size.height;
  //  NSLog(@"");
  //  NSLog(@"Button State: %d", self.isOn);
  //  NSLog(@"switchButton pos: %@", NSStringFromCGRect(self.switchButton.frame));
  
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rippleFrame cornerRadius:self.switchButton.layer.cornerRadius*2];

  // Set ripple layer attributes
  rippleLayer = [CAShapeLayer layer];
  rippleLayer.path = path.CGPath;
  rippleLayer.frame = rippleFrame;
  rippleLayer.opacity = 0.2;
  rippleLayer.strokeColor = [UIColor clearColor].CGColor;
  rippleLayer.fillColor = self.rippleFillColor.CGColor;
  rippleLayer.lineWidth = 0;
  //  NSLog(@"Ripple origin pos: %@", NSStringFromCGRect(circleShape.frame));
  [self.switchButton.layer insertSublayer:rippleLayer below:self.switchButton.layer];
//    [self.layer insertSublayer:circleShape above:self.switchButton.layer];
}


- (void)animateRippleEffect
{
  // Create ripple layer
  if ( rippleLayer == nil) {
    [self initializeRipple];
  }
  
  // Animation begins from here
  rippleLayer.opacity = 0.0;
  [CATransaction begin];
  
  //remove layer after animation completed
  [CATransaction setCompletionBlock:^{
    [rippleLayer removeFromSuperlayer];
    rippleLayer = nil;
  }];
  
  // Scale ripple to the modelate size
  CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scaleAnimation.fromValue = [NSNumber numberWithFloat:0.5];
  scaleAnimation.toValue = [NSNumber numberWithFloat:1.25];
  
  // Alpha animation for smooth disappearing
  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  alphaAnimation.fromValue = @0.4;
  alphaAnimation.toValue = @0;
  
  // Do above animations at the same time with proper duration
  CAAnimationGroup *animation = [CAAnimationGroup animation];
  animation.animations = @[scaleAnimation, alphaAnimation];
  animation.duration = 0.4f;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  [rippleLayer addAnimation:animation forKey:nil];
  
  [CATransaction commit];
  // End of animation, then remove ripple layer
  // NSLog(@"Ripple removed");
}

- (void)onTouchDown:(UIButton*)btn withEvent:(UIEvent*)event
{
  // NSLog(@"touchDown called");
  if (self.isRippleEnabled == YES) {
    [self initializeRipple];
  }
  
  // Animate for appearing ripple circle when tap and hold the switch button
  [CATransaction begin];
  
  CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
  scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
  
  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  alphaAnimation.fromValue = @0;
  alphaAnimation.toValue = @0.2;
  
  // Do above animations at the same time with proper duration
  CAAnimationGroup *animation = [CAAnimationGroup animation];
  animation.animations = @[scaleAnimation, alphaAnimation];
  animation.duration = 0.4f;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  [rippleLayer addAnimation:animation forKey:nil];
  
  [CATransaction commit];
//  NSLog(@"Ripple end pos: %@", NSStringFromCGRect(circleShape.frame));
}

// Change button state when touchUPInside action is detected
- (void)switchButtonTapped: (id)sender
{
  // NSLog(@"touch up inside");
  // NSLog(@"Slider midPosX: %f", CGRectGetMidX(self.slider.frame));
  // NSLog(@"%@", NSStringFromCGRect(self.switchButton.frame));
  // Delegate method
  if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
    if (self.isOn == YES) {
      [self.delegate switchStateChanged:JTMaterialSwitchStateOff];
    }
    else{
      [self.delegate switchStateChanged:JTMaterialSwitchStateOn];
    }
  }
  
  [self changeButtonState];
}

// Change button state when touchUPOutside action is detected
- (void)onTouchUpOutside:(UIButton*)btn withEvent:(UIEvent*)event
{
  // NSLog(@"Touch released at ouside");
  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  //Get the new origin after this motion
  float newXOrigin = btn.frame.origin.x + dX;
   //NSLog(@"Released tap X pos: %f", newXOrigin);
  
  if (newXOrigin > (self.frame.size.width - self.switchButton.frame.size.width)/2) {
     //NSLog(@"Button pos should be set *ON*");
    [self changeButtonStateONwithAnimation];
  }
  else {
     //NSLog(@"Button pos should be set *OFF*");
    [self changeButtonStateOFFwithAnimation];
  }
  
  if (self.isRippleEnabled == YES) {
    [self animateRippleEffect];
  }
}

// Drag the switch button
- (void)onTouchDragInside:(UIButton*)btn withEvent:(UIEvent*)event
{
  //This code can go awry if there is more than one finger on the screen
  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  //Get the original position of the button
  CGRect buttonFrame = btn.frame;
  
  buttonFrame.origin.x += dX;
  //Make sure it's within two bounds
  buttonFrame.origin.x = MIN(buttonFrame.origin.x,buttonOnPosition);
  buttonFrame.origin.x = MAX(buttonFrame.origin.x,buttonOffPosition);
  
  //Set the button's new frame if need to
  if(buttonFrame.origin.x != btn.frame.origin.x) {
    btn.frame = buttonFrame;
  }
}

@end
