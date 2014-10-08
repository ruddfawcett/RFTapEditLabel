//
//  RFTapEditLabel.m
//  RFTapEditLabelDemo
//
//  Created by Rudd Fawcett on 11/25/13.
//  Copyright (c) 2013 Rudd Fawcett. All rights reserved.
//

#import "RFTapEditLabel.h"

@interface RFTapEditLabel ()



@property (strong, nonatomic) UIAlertView *alertView;

@property (nonatomic, readwrite) BOOL secureTextEntry;
@property (nonatomic, readwrite) BOOL placeholder;
@property (nonatomic, readwrite) BOOL inPlaceholderState;
@property (nonatomic, readwrite) BOOL editable;

@end

@implementation RFTapEditLabel

- (id)initWithFrame:(CGRect)frame title:(NSString *)title secureTextEntry:(BOOL)secureTextEntry
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelWasTapped)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        
        _alertView = [[UIAlertView alloc] initWithTitle:title
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:@"Save", nil];
        _alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

        _secureTextEntry = secureTextEntry;
        _editable = YES;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelWasTapped)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"Edit Label"
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:@"Save", nil];
        _alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        _editable = YES;
    }
    return self;
}


-(void)awakeFromNib
{
    //More than likely was configured through
    if(!_alertView){
        
    }
}

-(void)setPlaceholderText:(NSString*)placeholder {
    _placeholderText = placeholder;
    _placeholder = YES;
    _inPlaceholderState = YES;
    
    self.text = _placeholderText;
    self.textColor = [UIColor grayColor];
}

-(void)setLabelTextCustom:(NSString *)labelText {
    _inPlaceholderState = NO;
    
    self.text = labelText;
    self.textColor = [UIColor blackColor];
}

-(void)labelWasTapped {
    if (_editable) {
        _textField = [_alertView textFieldAtIndex:0];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        if (_secureTextEntry) {
            _textField.secureTextEntry = YES;
            _textField.text = nil;
        }
        else {
            if (!_placeholder || (_placeholder && self.text.length != 0 && !_inPlaceholderState)) {
                _textField.text = self.text;
            }
                _textField.placeholder = self.text;
        }
        
        [_alertView show];
    }
}

-(void)simulateTap {
    [self labelWasTapped];
}

-(void)toggleMask {
    if (_isMasked) {
        _isMasked = NO;
        
        self.text = _labelText;
    }
    else {
        _isMasked = YES;
        
        if (_maskLength) {
            self.text = [self maskString:_maskLength];
        }
        else {
            self.text = [self maskString:_labelText.length];
        }
    }
}

-(void)toggleMaskForTime:(NSTimeInterval)time {
    [self toggleMask];
        
    [self performSelector:@selector(toggleMask) withObject:self afterDelay:time];
}

-(void)toggleMaskForTime:(NSTimeInterval)time onToggle:(void (^)(void))whileToggledBlock completion:(void (^)(void))completionBlock {
    whileToggledBlock();
    
    [self toggleMask];
    
    [self performSelector:@selector(toggleMask) withObject:self afterDelay:time];
    [self performSelector:@selector(fireCompletionBlockAfterDelay:) withObject:completionBlock afterDelay:time];
}

- (void)fireCompletionBlockAfterDelay:(void (^)(void))completionBlock {
    completionBlock();
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == _alertView) {
        if (buttonIndex == 1) {
            _labelText = _textField.text;
            if ([self.delegate respondsToSelector:@selector(didEditLabel:)]) {
                [self.delegate didEditLabel:self];
            }
            
            if (_labelText.length != 0) {
                self.textColor = [UIColor blackColor];
                _inPlaceholderState = NO;
                
                [self saveString:NO];
            }
            else {
                self.textColor = [UIColor grayColor];
                self.text = _placeholderText;
                _inPlaceholderState = YES;
                
                [self saveString:YES];
            }
        }
        else nil;
    }
}

-(void)saveString:(BOOL)setLabelPlaceholder {
    if (_secureTextEntry) {
        if (setLabelPlaceholder) {
            self.text = _placeholderText;
        }
        else {
            _isMasked = YES;
            
            if (_maskLength) {
                self.text = [self maskString:_maskLength];
            }
            else {
                self.text = [self maskString:_labelText.length];
            }
        }
    }
    else {
        if (setLabelPlaceholder) {
            self.text = _placeholderText;
        }
        else self.text = _labelText;
    }

}

-(void)setEditable:(BOOL)editable {
    _editable = editable;
}

-(void)toggleEditable {
    if (_editable) {
        _editable = NO;
    }
    else _editable = YES;
}

-(void)setMaskWithLength:(NSUInteger)maskLength {
    _maskLength = maskLength;
    self.text = [self maskString:maskLength];
}

-(NSString*)maskString:(NSUInteger)maskLength {
    NSMutableString *maskString = [NSMutableString new];
    
    for (int i = 0; i < maskLength; i++)
    {
        [maskString appendString:@"●"];
    }
    
    return maskString;
}


@end
