//
//  NameAndColorCell.h
//  TableCells
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NameAndColorCell : UITableViewCell

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *color;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *colorLabel;


@end

NS_ASSUME_NONNULL_END
