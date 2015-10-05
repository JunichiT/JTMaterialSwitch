//
//  JTMaterialSwitch.h
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
/** A Boolean value that represents switch's current state(ON/OFF). YES to ON, NO to OFF the switch */
@property (nonatomic) BOOL isOn;
/** A Boolean value that represents switch's interaction mode. YES to set enabled, No to set disabled*/
@property (nonatomic) BOOL isEnabled;
/** A Boolean value whether the bounce animation effect is enabled when state change movement */
@property (nonatomic) BOOL isBounceEnabled;
/** A Boolean value whether the ripple animation effect is enabled or not */
@property (nonatomic) BOOL isRippleEnabled;

#pragma Colour
/** An UIColor property to represent the colour of the switch thumb when position is ON */
@property (nonatomic, strong) UIColor *thumbOnTintColor;
/** An UIColor property to represent the colour of the switch thumb when position is OFF */
@property (nonatomic, strong) UIColor *thumbOffTintColor;
/** An UIColor property to represent the colour of the track when position is ON */
@property (nonatomic, strong) UIColor *trackOnTintColor;
/** An UIColor property to represent the colour of the track when position is OFF */
@property (nonatomic, strong) UIColor *trackOffTintColor;
/** An UIColor property to represent the colour of the switch thumb when position is DISABLED */
@property (nonatomic, strong) UIColor *thumbDisabledTintColor;
/** An UIColor property to represent the colour of the track when position is DISABLED */
@property (nonatomic, strong) UIColor *trackDisabledTintColor;
/** An UIColor property to represent the fill colour of the ripple only when ripple effect is enabled */
@property (nonatomic, strong) UIColor *rippleFillColor;

#pragma UI components
/** An UIButton object that represents current state(ON/OFF) */
@property (nonatomic, strong) UIButton *switchThumb;
/** An UIView object that represents the track for the thumb */
@property (nonatomic, strong) UIView *track;

#pragma mark - Initializer
/**
 *  Initializes a JTMaterialSwitch in the easiest way with default parameters.
 *
 *  @JTMaterialSwitchStyle: JTMaterialSwitchStyleDefault,
 *  @JTMaterialSwitchState: JTMaterialSwitchStateOn,
 *  @JTMaterialSwitchSize: JTMaterialSwitchSizeNormal
 *
 *  @return A JTFadingInfoView with above parameters
 */
- (id)init;

/**
 *  Initializes a JTMaterialSwitch with a initial switch state position and size.
 *
 *  @param size A JTMaterialSwitchSize enum as this view's size(big, normal, small)
 *  @param state A JTMaterialSwitchState enum as this view's initial switch pos(ON/OFF)
 *
 *  @return A JTFadingInfoView with size and initial position
 */
- (id)initWithSize:(JTMaterialSwitchSize)size state:(JTMaterialSwitchState)state;

/**
 *  Initializes a JTMaterialSwitch with a initial switch size, style and state.
 *
 *  @param size A JTMaterialSwitchSize enum as this view's size(big, normal, small)
 *  @param state A JTMaterialSwitchStyle enum as this view's initial style
 *  @param state A JTMaterialSwitchState enum as this view's initial switch pos(ON/OFF)
 *
 *  @return A JTFadingInfoView with size, style and initial position
 */
- (id)initWithSize:(JTMaterialSwitchSize)size style:(JTMaterialSwitchStyle)style state:(JTMaterialSwitchState)state;

#pragma setter/getter
/**
 *  Initializes a JTMaterialSwitch with a initial switch size, style and state.
 *
 *  @return A boolean value. Yes if the current switch state is ON, NO if OFF.
 */
- (BOOL)getSwitchState;

/**
 *  Set switch state with or without moving animation of switch thumb
 *
 *  @param on The switch state you want to set
 *  @param animated Yes to set with animation, NO to do without.
 */
- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
