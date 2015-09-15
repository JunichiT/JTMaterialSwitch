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



@interface JTMaterialSwitch : UIView


@property (nonatomic) BOOL isOn;
@property (nonatomic) BOOL isRaised;
@property (nonatomic) BOOL isSliderRounded;

@property (nonatomic) CGFloat sliderThickness;
@property (nonatomic) CGFloat buttonSize;

@property (nonatomic, strong) UIColor *buttonOnTintColor;
@property (nonatomic, strong) UIColor *buttonOffTintColor;

@property (nonatomic, strong) UIColor *sliderOnTintColor;
@property (nonatomic, strong) UIColor *sliderOffTintColor;

@property (nonatomic, strong) UIButton *sliderButton;
@property (nonatomic, strong) UIView *slider;


- (id)initWithFrame:(CGRect)frame withState:(JTMaterialSwitchState)state;
  
@end
