//
//  RFTapEditCell.m
//  RFTapEditLabelDemo
//
//  Created by Rex Finn on 11/25/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import "RFTapEditCell.h"

@interface RFTapEditCell ()

@property (nonatomic, readwrite) BOOL secureTextEntry;

@end

@implementation RFTapEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier secureTextEntry:(BOOL)secureTextEntry
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellWasTapped)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        
        _secureTextEntry = secureTextEntry;
        
        _tapTextLabel = [[RFTapEditLabel alloc] initWithFrame:CGRectMake(15, 9, self.bounds.size.width-30, self.bounds.size.height-18) secureTextEntry:secureTextEntry];
        
        self.accessoryView = _tapTextLabel;
    }
    return self;
}

-(void)updateTextForMask {
    if (_secureTextEntry == YES) {
        _tapTextLabel.labelText = _tapTextLabel.text;
        [_tapTextLabel toggleMask];
    }
}

-(void)cellWasTapped {
    [_tapTextLabel simulateTap];
}

-(void)setPlaceholderText:(NSString *)placeholder {
    [_tapTextLabel setPlaceholderText:placeholder];
}

-(void)setLabelTextCustom:(NSString *)labelText {
    [_tapTextLabel setLabelTextCustom:labelText];
}

@end
