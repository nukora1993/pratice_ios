//
//  TinyPixDocument.h
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TinyPixDocument : UIDocument

- (BOOL)stateAtRow:(int)row Column:(int)column;
- (void)setState:(BOOL)state atRow:(int)row atColumn:(int)column;

- (void)toggleStateAtRow:(int)row Column:(int)column;

@end

NS_ASSUME_NONNULL_END
