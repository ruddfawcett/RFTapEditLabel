//
//  RFTapEditCell.m
//  RFTapEditLabelDemo
//
//  Created by Rudd Fawcett on 11/25/13.
//  Copyright (c) 2013 Rudd Fawcett. All rights reserved.
//

#import "RFTapEditCell.h"

@interface RFTapEditCell ()

@property (nonatomic, readwrite) BOOL secureTextEntry;
@property (nonatomic, readwrite, strong) NSString *customLabelText;
@property(nonatomic, readwrite, strong) NSString *customPlaceHolderText;

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
        
        _tapTextLabel = [[RFTapEditLabel alloc] initWithFrame:CGRectMake(15, 9, self.bounds.size.width-30, self.bounds.size.height-18) title:@"Edit Label" secureTextEntry:secureTextEntry];
        
        self.accessoryView = _tapTextLabel;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellWasTapped)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)awakeFromNib
{
    if(!_tapTextLabel){
        _tapTextLabel = [[RFTapEditLabel alloc] initWithFrame:CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y, self.contentView.bounds.size.width - 30, self.contentView.bounds.size.height) title:@"Edit Label" secureTextEntry:_secureTextEntry];
        //Set label text
        [_tapTextLabel setLabelTextCustom:_customLabelText];

        //Add the label to the cell's content view
        [self.contentView addSubview:_tapTextLabel];
        
        //Setup layout constraints
        _tapTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *viewsDictionary = [NSDictionary dictionaryWithObject:_tapTextLabel forKey:@"tapTextLabel"];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[tapTextLabel]|" options:0 metrics:nil views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tapTextLabel]|" options:0 metrics:nil views:viewsDictionary]];
        [self.contentView setNeedsUpdateConstraints];
    }
    
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
    _customPlaceHolderText = placeholder;
    [_tapTextLabel setPlaceholderText:_customPlaceHolderText];
}

-(void)setLabelTextCustom:(NSString *)labelText {
    _customLabelText = labelText;
    [_tapTextLabel setLabelTextCustom:_customLabelText];
}

@end
