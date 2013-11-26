//
//  RFTapEditCell.h
//  RFTapEditLabelDemo
//
//  Created by Rudd Fawcett on 11/25/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFTapEditLabel.h"

@interface RFTapEditCell : UITableViewCell

@property (nonatomic, strong) RFTapEditLabel *tapTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier secureTextEntry:(BOOL)secureTextEntry;

- (void)updateTextForMask;

- (void)setPlaceholderText:(NSString*)placeholder;
- (void)setLabelTextCustom:(NSString *)labelText;

@end
