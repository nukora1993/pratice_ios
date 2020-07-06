//
//  NameAndColorCell.m
//  TableCells
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "NameAndColorCell.h"

@implementation NameAndColorCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    if (self) {
//        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
//        UILabel *nameMarker = [[UILabel alloc] initWithFrame:nameLabelRect];
//        nameMarker.textAlignment = NSTextAlignmentRight;
//        nameMarker.text = @"Name:";
//        nameMarker.font = [UIFont boldSystemFontOfSize:12];
//        [self.contentView addSubview:nameMarker];
//        
//        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
//        UILabel *colorMarker = [[UILabel alloc] initWithFrame:colorLabelRect];
//        colorMarker.textAlignment = NSTextAlignmentRight;
//        colorMarker.text = @"Color:";
//        colorMarker.font = [UIFont boldSystemFontOfSize:12];
//        [self.contentView addSubview:colorMarker];
//        
//        CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
//        _nameLabel = [[UILabel alloc] initWithFrame:nameValueRect];
//        [self.contentView addSubview:_nameLabel];
//        
//        CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
//        _colorLabel = [[UILabel alloc] initWithFrame:colorValueRect];
//        [self.contentView addSubview:_colorLabel];
//    }
//    
//    return self;
//}

- (void)setName:(NSString *)name{
    _nameLabel.text = name;
}

- (void)setColor:(NSString *)color{
    _colorLabel.text = color;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
