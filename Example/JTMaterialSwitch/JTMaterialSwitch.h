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
  JTMaterialSwitchTypeDefault
} JTMaterialSwitchType;

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
/** A Boolean value whether the switch is set ON */
@property (nonatomic) BOOL isOn;
/** A Boolean value whether the shadow of this switch button is floating */
@property (nonatomic) BOOL isRaised;
/** A Boolean value whether the slider of this switch button has rounded corner */
@property (nonatomic) BOOL isSliderRounded;

#pragma Size
/** A CGFloat value to represent the slider thickness of this switch */
@property (nonatomic) CGFloat sliderThickness;
/** A CGFloat value to represent the switch button size(width and height) */
@property (nonatomic) CGFloat buttonSize;

#pragma Colour
/** A UIColor property to represent the colour of the switch button when position is ON */
@property (nonatomic, strong) UIColor *buttonOnTintColor;
/** A UIColor property to represent the colour of the switch button when position is OFF */
@property (nonatomic, strong) UIColor *buttonOffTintColor;

@property (nonatomic, strong) UIColor *sliderOnTintColor;
@property (nonatomic, strong) UIColor *sliderOffTintColor;

@property (nonatomic, strong) UIButton *sliderButton;
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

- (void)setButtonOnTintColor: (UIColor *)tintColor;
- (void)setButtonOffTintColor: (UIColor *)tintColor;

@end
