//
//  TinyPixView.h
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
struct GridIndex{
    int row;
    int column;
};

@class TinyPixDocument;

@interface TinyPixView : UIView

@property (nonatomic) TinyPixDocument *document;
@property (nonatomic) CGSize lastSize;
@property (nonatomic) CGRect gridRect;
@property (nonatomic) CGSize blockSize;
@property (nonatomic) CGFloat gap;
@property (nonatomic) struct GridIndex selectedBlockIndex;

@end

NS_ASSUME_NONNULL_END
