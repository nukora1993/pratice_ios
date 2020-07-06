//
//  ContentCell.h
//  DialogViewer
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentCell : UICollectionViewCell

@property (nonatomic) UILabel *label;
@property (nonatomic) NSString *text;
@property (nonatomic) CGFloat maxWidth;

+ (UIFont *)defaultFont;
+ (CGSize)sizeForContentString:(NSString *)s forMaxWidth:(CGFloat)maxWidth;
@end

NS_ASSUME_NONNULL_END
