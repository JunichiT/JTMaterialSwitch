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
/** A CGFloat value to represent the track thickness of this switch */
@property (nonatomic) CGFloat trackThickness;
/** A CGFloat value to represent the switch thumb size(width and height) */
@property (nonatomic) CGFloat thumbSize;

@end

@implementation JTMaterialSwitch {
  float thumbOnPosition;
  float thumbOffPosition;
  float bounceOffset;
  JTMaterialSwitchStyle thumbStyle;
  CAShapeLayer *rippleLayer;
}

// the easiest initializing way
- (id)init
{
  self = [self initWithSize:JTMaterialSwitchSizeNormal
                      style:JTMaterialSwitchStyleDefault
                      state:JTMaterialSwitchStateOn];
  
  return self;
}

// Designated initializer
- (id)initWithSize:(JTMaterialSwitchSize)size state:(JTMaterialSwitchState)state
{
  // initialize parameters
  self.thumbOnTintColor  = [UIColor colorWithRed:52./255. green:109./255. blue:241./255. alpha:1.0];
  self.thumbOffTintColor = [UIColor colorWithRed:249./255. green:249./255. blue:249./255. alpha:1.0];
  self.trackOnTintColor = [UIColor colorWithRed:143./255. green:179./255. blue:247./255. alpha:1.0];
  self.trackOffTintColor = [UIColor colorWithRed:193./255. green:193./255. blue:193./255. alpha:1.0];
  self.thumbDisabledTintColor = [UIColor colorWithRed:174./255. green:174./255. blue:174./255. alpha:1.0];
  self.trackDisabledTintColor = [UIColor colorWithRed:203./255. green:203./255. blue:203./255. alpha:1.0];
  self.isEnabled = YES;
  self.isRippleEnabled = YES;
  self.isBounceEnabled = YES;
  self.rippleFillColor = [UIColor blueColor];
  bounceOffset = 3.0f;
  
  CGRect frame;
  CGRect trackFrame = CGRectZero;
  CGRect thumbFrame = CGRectZero;
  
  // Determine switch size
  switch (size) {
    case JTMaterialSwitchSizeBig:
      frame = CGRectMake(0, 0, 50, 40);
      self.trackThickness = 23.0;
      self.thumbSize = 31.0;
      break;
      
    case JTMaterialSwitchSizeNormal:
      frame = CGRectMake(0, 0, 40, 30);
      self.trackThickness = 17.0;
      self.thumbSize = 24.0;
      break;
      
    case JTMaterialSwitchSizeSmall:
      frame = CGRectMake(0, 0, 30, 25);
      self.trackThickness = 13.0;
      self.thumbSize = 18.0;
      break;
      
    default:
      frame = CGRectMake(0, 0, 40, 30);
      self.trackThickness = 13.0;
      self.thumbSize = 20.0;
      break;
  }
  
  trackFrame.size.height = self.trackThickness;
  trackFrame.size.width = frame.size.width;
  trackFrame.origin.x = 0.0;
  trackFrame.origin.y = (frame.size.height-trackFrame.size.height)/2;
  thumbFrame.size.height = self.thumbSize;
  thumbFrame.size.width = thumbFrame.size.height;
  thumbFrame.origin.x = 0.0;
  thumbFrame.origin.y = (frame.size.height-thumbFrame.size.height)/2;
  
  // Actual initialization with selected size
  self = [super initWithFrame:frame];
  
  self.track = [[UIView alloc] initWithFrame:trackFrame];
  self.track.backgroundColor = [UIColor grayColor];
  self.track.layer.cornerRadius = MIN(self.track.frame.size.height, self.track.frame.size.width)/2;
  [self addSubview:self.track];
  
  self.switchThumb = [[UIButton alloc] initWithFrame:thumbFrame];
  self.switchThumb.backgroundColor = [UIColor whiteColor];
  self.switchThumb.layer.cornerRadius = self.switchThumb.frame.size.height/2;
  self.switchThumb.layer.shadowOpacity = 0.5;
  self.switchThumb.layer.shadowOffset = CGSizeMake(0.0, 1.0);
  self.switchThumb.layer.shadowColor = [UIColor blackColor].CGColor;
  self.switchThumb.layer.shadowRadius = 2.0f;
  // Add events for user action
  [self.switchThumb addTarget:self action:@selector(onTouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
  [self.switchThumb addTarget:self action:@selector(onTouchUpOutsideOrCanceled:withEvent:) forControlEvents:UIControlEventTouchUpOutside];
  [self.switchThumb addTarget:self action:@selector(switchThumbTapped:) forControlEvents:UIControlEventTouchUpInside];
  [self.switchThumb addTarget:self action:@selector(onTouchDragInside:withEvent:) forControlEvents:UIControlEventTouchDragInside];
  [self.switchThumb addTarget:self action:@selector(onTouchUpOutsideOrCanceled:withEvent:) forControlEvents:UIControlEventTouchCancel];
  
  
  [self addSubview:self.switchThumb];
  
  thumbOnPosition = self.frame.size.width - self.switchThumb.frame.size.width;
  thumbOffPosition = self.switchThumb.frame.origin.x;
  
  // Set thumb's initial position from state property
  switch (state) {
    case JTMaterialSwitchStateOn:
      self.isOn = YES;
      self.switchThumb.backgroundColor = self.thumbOnTintColor;
      CGRect thumbFrame = self.switchThumb.frame;
      thumbFrame.origin.x = thumbOnPosition;
      self.switchThumb.frame = thumbFrame;
      break;
      
    case JTMaterialSwitchStateOff:
      self.isOn = NO;
      self.switchThumb.backgroundColor = self.thumbOffTintColor;
      break;
      
    default:
      self.isOn = NO;
      self.switchThumb.backgroundColor = self.thumbOffTintColor;
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
  thumbStyle = style;
  // Determine switch style from preset colour set
  // Light and Dark color styles come from Google's design guidelines
  // https://www.google.com/design/spec/components/selection-controls.html
  switch (style) {
    case JTMaterialSwitchStyleLight:
      self.thumbOnTintColor  = [UIColor colorWithRed:0./255. green:134./255. blue:117./255. alpha:1.0];
      self.thumbOffTintColor = [UIColor colorWithRed:237./255. green:237./255. blue:237./255. alpha:1.0];
      self.trackOnTintColor = [UIColor colorWithRed:90./255. green:178./255. blue:169./255. alpha:1.0];
      self.trackOffTintColor = [UIColor colorWithRed:129./255. green:129./255. blue:129./255. alpha:1.0];
      self.thumbDisabledTintColor = [UIColor colorWithRed:175./255. green:175./255. blue:175./255. alpha:1.0];
      self.trackDisabledTintColor = [UIColor colorWithRed:203./255. green:203./255. blue:203./255. alpha:1.0];
      self.rippleFillColor = [UIColor grayColor];
      break;
      
    case JTMaterialSwitchStyleDark:
      self.thumbOnTintColor  = [UIColor colorWithRed:109./255. green:194./255. blue:184./255. alpha:1.0];
      self.thumbOffTintColor = [UIColor colorWithRed:175./255. green:175./255. blue:175./255. alpha:1.0];
      self.trackOnTintColor = [UIColor colorWithRed:72./255. green:109./255. blue:105./255. alpha:1.0];
      self.trackOffTintColor = [UIColor colorWithRed:94./255. green:94./255. blue:94./255. alpha:1.0];
      self.thumbDisabledTintColor = [UIColor colorWithRed:50./255. green:51./255. blue:50./255. alpha:1.0];
      self.trackDisabledTintColor = [UIColor colorWithRed:56./255. green:56./255. blue:56./255. alpha:1.0];
      self.rippleFillColor = [UIColor grayColor];
      break;
      
    default:
      self.thumbOnTintColor  = [UIColor colorWithRed:52./255. green:109./255. blue:241./255. alpha:1.0];
      self.thumbOffTintColor = [UIColor colorWithRed:249./255. green:249./255. blue:249./255. alpha:1.0];
      self.trackOnTintColor = [UIColor colorWithRed:143./255. green:179./255. blue:247./255. alpha:1.0];
      self.trackOffTintColor = [UIColor colorWithRed:193./255. green:193./255. blue:193./255. alpha:1.0];
      self.thumbDisabledTintColor = [UIColor colorWithRed:174./255. green:174./255. blue:174./255. alpha:1.0];
      self.trackDisabledTintColor = [UIColor colorWithRed:203./255. green:203./255. blue:203./255. alpha:1.0];
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
    self.switchThumb.backgroundColor = self.thumbOnTintColor;
    self.track.backgroundColor = self.trackOnTintColor;
  }
  else {
    self.switchThumb.backgroundColor = self.thumbOffTintColor;
    self.track.backgroundColor = self.trackOffTintColor;
    // set initial position
    [self changeThumbStateOFFwithoutAnimation];
  }
  
  if (self.isEnabled == NO) {
    self.switchThumb.backgroundColor = self.thumbDisabledTintColor;
    self.track.backgroundColor = self.trackDisabledTintColor;
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
      [self changeThumbStateONwithAnimation];
    }
    else {
      // set on without animation
      [self changeThumbStateONwithoutAnimation];
    }
  }
  else {
    if (animated == YES) {
      // set off with animation
      [self changeThumbStateOFFwithAnimation];
    }
    else {
      // set off without animation
      [self changeThumbStateOFFwithoutAnimation];
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
        self.switchThumb.backgroundColor = self.thumbOnTintColor;
        self.track.backgroundColor = self.trackOnTintColor;
      }
      else {
        self.switchThumb.backgroundColor = self.thumbOffTintColor;
        self.track.backgroundColor = self.trackOffTintColor;
      }
      self.isEnabled = YES;
    }
    // if disabled
    else {
      self.switchThumb.backgroundColor = self.thumbDisabledTintColor;
      self.track.backgroundColor = self.trackDisabledTintColor;
      self.isEnabled = NO;
    }
  }];
}

//The event handling method
- (void)switchAreaTapped:(UITapGestureRecognizer *)recognizer
{
  // Delegate method
  if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
    if (self.isOn == YES) {
      [self.delegate switchStateChanged:JTMaterialSwitchStateOff];
    }
    else{
      [self.delegate switchStateChanged:JTMaterialSwitchStateOn];
    }
  }
  
  [self changeThumbState];
}

- (void)changeThumbState
{
  // NSLog(@"thumb origin pos: %@", NSStringFromCGRect(self.switchThumb.frame));
  if (self.isOn == YES) {
    [self changeThumbStateOFFwithAnimation];
  }
  else {
    [self changeThumbStateONwithAnimation];
  }
  
  if (self.isRippleEnabled == YES) {
    [self animateRippleEffect];
  }
}

- (void)changeThumbStateONwithAnimation
{
  // switch movement animation
  [UIView animateWithDuration:0.15f
                        delay:0.05f
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     CGRect thumbFrame = self.switchThumb.frame;
                     thumbFrame.origin.x = thumbOnPosition+bounceOffset;
                     self.switchThumb.frame = thumbFrame;
                     if (self.isEnabled == YES) {
                       self.switchThumb.backgroundColor = self.thumbOnTintColor;
                       self.track.backgroundColor = self.trackOnTintColor;
                     }
                     else {
                       self.switchThumb.backgroundColor = self.thumbDisabledTintColor;
                       self.track.backgroundColor = self.trackDisabledTintColor;
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
                     // NSLog(@"thumb end pos: %@", NSStringFromCGRect(self.switchThumb.frame));
                     // Bouncing effect: Move thumb a bit, for better UX
                     [UIView animateWithDuration:0.15f
                                      animations:^{
                                        // Bounce to the position
                                        CGRect thumbFrame = self.switchThumb.frame;
                                        thumbFrame.origin.x = thumbOnPosition;
                                        self.switchThumb.frame = thumbFrame;
                                      }
                                      completion:^(BOOL finished){
                                        self.userInteractionEnabled = YES;
                                      }];
                   }];
}

- (void)changeThumbStateOFFwithAnimation
{
  // switch movement animation
  [UIView animateWithDuration:0.15f
                        delay:0.05f
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     CGRect thumbFrame = self.switchThumb.frame;
                     thumbFrame.origin.x = thumbOffPosition-bounceOffset;
                     self.switchThumb.frame = thumbFrame;
                     if (self.isEnabled == YES) {
                       self.switchThumb.backgroundColor = self.thumbOffTintColor;
                       self.track.backgroundColor = self.trackOffTintColor;
                     }
                     else {
                       self.switchThumb.backgroundColor = self.thumbDisabledTintColor;
                       self.track.backgroundColor = self.trackDisabledTintColor;
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
                     // NSLog(@"thumb end pos: %@", NSStringFromCGRect(self.switchThumb.frame));
                     // Bouncing effect: Move thumb a bit, for better UX
                     [UIView animateWithDuration:0.15f
                                      animations:^{
                                        // Bounce to the position
                                        CGRect thumbFrame = self.switchThumb.frame;
                                        thumbFrame.origin.x = thumbOffPosition;
                                        self.switchThumb.frame = thumbFrame;
                                      }
                                      completion:^(BOOL finished){
                                        self.userInteractionEnabled = YES;
                                      }];
                   }];
}

// Without animation
- (void)changeThumbStateONwithoutAnimation
{
  CGRect thumbFrame = self.switchThumb.frame;
  thumbFrame.origin.x = thumbOnPosition;
  self.switchThumb.frame = thumbFrame;
  if (self.isEnabled == YES) {
    self.switchThumb.backgroundColor = self.thumbOnTintColor;
    self.track.backgroundColor = self.trackOnTintColor;
  }
  else {
    self.switchThumb.backgroundColor = self.thumbDisabledTintColor;
    self.track.backgroundColor = self.trackDisabledTintColor;
  }
  
  if (self.isOn == NO) {
    self.isOn = YES;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
  self.isOn = YES;
}

// Without animation
- (void)changeThumbStateOFFwithoutAnimation
{
  CGRect thumbFrame = self.switchThumb.frame;
  thumbFrame.origin.x = thumbOffPosition;
  self.switchThumb.frame = thumbFrame;
  if (self.isEnabled == YES) {
    self.switchThumb.backgroundColor = self.thumbOffTintColor;
    self.track.backgroundColor = self.trackOffTintColor;
  }
  else {
    self.switchThumb.backgroundColor = self.thumbDisabledTintColor;
    self.track.backgroundColor = self.trackDisabledTintColor;
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
  // Ripple size is twice as large as switch thumb
  float rippleScale = 2;
  CGRect rippleFrame = CGRectZero;
  rippleFrame.origin.x = -self.switchThumb.frame.size.width/(rippleScale * 2);
  rippleFrame.origin.y = -self.switchThumb.frame.size.height/(rippleScale * 2);
  rippleFrame.size.height = self.switchThumb.frame.size.height * rippleScale;
  rippleFrame.size.width = rippleFrame.size.height;
  //  NSLog(@"");
  //  NSLog(@"thumb State: %d", self.isOn);
  //  NSLog(@"switchThumb pos: %@", NSStringFromCGRect(self.switchThumb.frame));
  
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rippleFrame cornerRadius:self.switchThumb.layer.cornerRadius*2];
  
  // Set ripple layer attributes
  rippleLayer = [CAShapeLayer layer];
  rippleLayer.path = path.CGPath;
  rippleLayer.frame = rippleFrame;
  rippleLayer.opacity = 0.2;
  rippleLayer.strokeColor = [UIColor clearColor].CGColor;
  rippleLayer.fillColor = self.rippleFillColor.CGColor;
  rippleLayer.lineWidth = 0;
  //  NSLog(@"Ripple origin pos: %@", NSStringFromCGRect(circleShape.frame));
  [self.switchThumb.layer insertSublayer:rippleLayer below:self.switchThumb.layer];
  //    [self.layer insertSublayer:circleShape above:self.switchThumb.layer];
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
  
  // Animate for appearing ripple circle when tap and hold the switch thumb
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

// Change thumb state when touchUPInside action is detected
- (void)switchThumbTapped: (id)sender
{
  // NSLog(@"touch up inside");
  // NSLog(@"track midPosX: %f", CGRectGetMidX(self.track.frame));
  // NSLog(@"%@", NSStringFromCGRect(self.switchThumb.frame));
  // Delegate method
  if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
    if (self.isOn == YES) {
      [self.delegate switchStateChanged:JTMaterialSwitchStateOff];
    }
    else{
      [self.delegate switchStateChanged:JTMaterialSwitchStateOn];
    }
  }
  
  [self changeThumbState];
}

// Change thumb state when touchUPOutside action is detected
- (void)onTouchUpOutsideOrCanceled:(UIButton*)btn withEvent:(UIEvent*)event
{
  // NSLog(@"Touch released at ouside");
  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  //Get the new origin after this motion
  float newXOrigin = btn.frame.origin.x + dX;
  //NSLog(@"Released tap X pos: %f", newXOrigin);
  
  if (newXOrigin > (self.frame.size.width - self.switchThumb.frame.size.width)/2) {
    //NSLog(@"thumb pos should be set *ON*");
    [self changeThumbStateONwithAnimation];
  }
  else {
    //NSLog(@"thumb pos should be set *OFF*");
    [self changeThumbStateOFFwithAnimation];
  }
  
  if (self.isRippleEnabled == YES) {
    [self animateRippleEffect];
  }
}

// Drag the switch thumb
- (void)onTouchDragInside:(UIButton*)btn withEvent:(UIEvent*)event
{
  //This code can go awry if there is more than one finger on the screen
  UITouch *touch = [[event touchesForView:btn] anyObject];
  CGPoint prevPos = [touch previousLocationInView:btn];
  CGPoint pos = [touch locationInView:btn];
  float dX = pos.x-prevPos.x;
  
  //Get the original position of the thumb
  CGRect thumbFrame = btn.frame;
  
  thumbFrame.origin.x += dX;
  //Make sure it's within two bounds
  thumbFrame.origin.x = MIN(thumbFrame.origin.x,thumbOnPosition);
  thumbFrame.origin.x = MAX(thumbFrame.origin.x,thumbOffPosition);
  
  //Set the thumb's new frame if need to
  if(thumbFrame.origin.x != btn.frame.origin.x) {
    btn.frame = thumbFrame;
  }
}

@end
