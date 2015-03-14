//
//  Cell.m
//  SaveME
//
//  Created by Lu1s_Armandho0 on 26/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected == YES) {
        _nombreLabel.text = @"User Name";
    }

}

@end
