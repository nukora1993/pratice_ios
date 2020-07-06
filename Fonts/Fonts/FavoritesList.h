//
//  FavoritesList.h
//  Fonts
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesList : NSObject
@property (nonatomic, readonly) NSMutableArray *favorites;


+ (FavoritesList *)sharedFavoriteList;
- (void)addFavorite:(NSString *)fontName;
- (void)removeFavorite:(NSString *)fontName;
- (void)moveItemFromIndex:(int)from ToIndex:(int)to;


@end

NS_ASSUME_NONNULL_END
