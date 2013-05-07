//
//  FavoriteCell.m
//  Wasel
//
//  Created by Abdelrahman Mohamed on 5/7/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

@synthesize title;
@synthesize subtitle;

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

    // Configure the view for the selected state
}

@end
