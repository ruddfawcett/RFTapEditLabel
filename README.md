RFTapEditLabel
===============

UILabel subclass with UIAlertView editing. Support for masked passwords and placeholders..

##Installation

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like RFTapEditLabel in your projects.

#### Podfile

```ruby
platform :ios, '7.0'
pod "RFTapEditLabel", "~> 1.2"
```

### Installation without CocoaPods

Just drag the RFTapEditLabel folder into your project and import it.

```
#import 'RFTapEditLabel.h'
// #import "RFTapEditCell.h" (a simple cell extension)
```

## Use programmatically

RFTapEditLabel is very simple to install and use.  Just init the `RFTapEditLabel` with or without securTextEntry, and with a frame (the way you normally would).


```objective-c
    RFTapEditLabel *tapLabel = [[RFTapEditLabel alloc] initWithFrame:CGRectMake(20, 100, 180, 31) secureTextEntry:NO];
```

## Use in Storyboard

You can either use RFTabEditCell or RFTapEditLabel inside of Storyboard. 

To use RFTabEditCell you'll change UITableViewCell the Custom Class to RFTabEditCell

To use RFTabEditLabel, you'll change the UILabel Custom Class to RFTabEditLabel

You'll want to set User Defined Runtime Attributes to control things like label text, placeholder text and secure if you use multiple prototype cells. The values will be picked up in the RFTabEditCell or RFTabEditLabel awakeFromNib

* secureTextEntry   Boolean
* customLabelText   String
* customPlaceHolderText     String

To reuse prototype cells with different content then populate the fields from a property file plist.

RFTabEditCell uses the following constraints for alignment within the UITableView

```objective-c
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[tapTextLabel]|" options:0 metrics:nil views:viewsDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tapTextLabel]|" options:0 metrics:nil views:viewsDictionary]];
    [self.contentView setNeedsUpdateConstraints];
```


That's really it, you can then use some of the methods below.  You can also always grab any of the text as well.  Also, you can initialize the `RFTapEditCell`, which just sets the textLabel of the cell to a custom label.

Hope you enjoy it!

## Methods

```objective-c
- (id)initWithFrame:(CGRect)frame secureTextEntry:(BOOL)secureTextEntry;
    // standard init, except with an option for a password text field.

- (void)simulateTap;
    // tapLabel programatically

- (void)toggleEditable;
    // if editable, set uneditable, if uneditable, set editable

- (void)setEditable:(BOOL)editable;
    // set editable without toggling

- (void)setLabelTextCustom:(NSString *)labelText;
    // use this when setting text AND a placeholder (otherwise unnecessary)

- (void)setPlaceholderText:(NSString *)placeholderText;
    // use this for setting a placeholder

- (void)toggleMask;
    // toggle mask, show dots or hide them

- (void)toggleMaskForTime:(NSTimeInterval)time;
    // toggle mask for time, show dots for x seconds, then hide

- (void)toggleMaskForTime:(NSTimeInterval)time onToggle:(void (^)(void))whileToggled completion:(void (^)(void))completionBlock;
    // I have never really used blocks before, and am new to controls, so this works, but may not be implemented properly
    // this allows you to set some properties while the label is being toggled, but then you can reset them

- (void)setMaskWithLength:(NSUInteger)maskLength;
    // change length of mask for security (by default label sets mask to length of text)

- (NSString*)maskString:(NSUInteger)maskLength;
    // return a masked string with the string length (set maskLength) or with  a custom maskLength (like setMaskWithLength)
```

##Screenshots

![Screenshot 1](http://i.imgur.com/WB5mvGC.png) 
![Screenshot 2](http://i.imgur.com/Fqiu1KX.png)

##License

The MIT License (MIT)

Copyright (c) 2013 Rudd Fawcett

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
