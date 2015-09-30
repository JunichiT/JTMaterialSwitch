//
//  JTMaterialSwitch.h
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

#import <UIKit/UIKit.h>

#pragma mark - Switch type
typedef enum {
  JTMaterialSwitchStyleLight,
  JTMaterialSwitchStyleDark,
  JTMaterialSwitchStyleDefault
} JTMaterialSwitchStyle;

#pragma mark - Initial state (on or off)
typedef enum {
  JTMaterialSwitchStateOn,
  JTMaterialSwitchStateOff
} JTMaterialSwitchState;

#pragma mark - Initial JTMaterialSwitch size (big, normal, small)
typedef enum {
  JTMaterialSwitchSizeBig,
  JTMaterialSwitchSizeNormal,
  JTMaterialSwitchSizeSmall
} JTMaterialSwitchSize;


@protocol JTMaterialSwitchDelegate <NSObject>
// Delegate method
- (void)switchStateChanged:(JTMaterialSwitchState)currentState;
@end

@interface JTMaterialSwitch : UIControl

#pragma mark - Properties
#pragma Delegate
@property (nonatomic, assign) id<JTMaterialSwitchDelegate> delegate;

#pragma State
/** A Boolean value that represents switch's current state(ON/OFF) */
@property (nonatomic) BOOL isOn;
/** A Boolean value whether the shadow of this switch button is floating */
@property (nonatomic) BOOL isRaised;
/** A Boolean value whether the bounce animation effect is enabled when state change movement */
@property (nonatomic) BOOL isBounceEnabled;
/** A Boolean value whether the ripple animation effect is enabled or not */
@property (nonatomic) BOOL isRippleEnabled;

#pragma Size
/** A CGFloat value to represent the slider thickness of this switch */
@property (nonatomic) CGFloat sliderThickness;
/** A CGFloat value to represent the switch button size(width and height) */
@property (nonatomic) CGFloat buttonSize;

#pragma Colour
/** An UIColor property to represent the colour of the switch button when position is ON */
@property (nonatomic, strong) UIColor *buttonOnTintColor;
/** An UIColor property to represent the colour of the switch button when position is OFF */
@property (nonatomic, strong) UIColor *buttonOffTintColor;
/** An UIColor property to represent the colour of the slider when position is ON */
@property (nonatomic, strong) UIColor *sliderOnTintColor;
/** An UIColor property to represent the colour of the slider when position is OFF */
@property (nonatomic, strong) UIColor *sliderOffTintColor;
/** An UIColor property to represent the colour of the switch button when position is DISABLED */
@property (nonatomic, strong) UIColor *buttonDisabledTintColor;
/** An UIColor property to represent the colour of the slider when position is DISABLED */
@property (nonatomic, strong) UIColor *sliderDisabledTintColor;
/** An UIColor property to represent the fill colour of the ripple only when ripple effect is enabled */
@property (nonatomic, strong) UIColor *rippleFillColor;

#pragma UI components
/** An UIButton object that represents current state(ON/OFF) */
@property (nonatomic, strong) UIButton *sliderButton;
/** An UIView object that represents the rail for the button */
@property (nonatomic, strong) UIView *slider;

#pragma mark - Initializer
/**
 *  Initializes a JTMaterialSwitch with a initial switch position(on or off).
 *
 *  @param frame A CGRect value for this view's frame
 *  @param state A JTMaterialSwitchState enum as this view's initial switch pos
 *
 *  @return A JTFadingInfoView with frame and initial position
 */
- (id)initWithFrame:(CGRect)frame withState:(JTMaterialSwitchState)state;

- (id)initWithSize:(JTMaterialSwitchSize)size WithState:(JTMaterialSwitchState)state;

- (id)initWithSize:(JTMaterialSwitchSize)size style:(JTMaterialSwitchStyle)style state:(JTMaterialSwitchState)state;

  
- (id)init __attribute__((unavailable("init is not available")));



@end
