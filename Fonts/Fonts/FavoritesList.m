//
//  FavoritesList.m
//  Fonts
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "FavoritesList.h"

@interface FavoritesList ()


@end

@implementation FavoritesList
- (void)moveItemFromIndex:(int)from ToIndex:(int)to{
    NSString *item = _favorites[from];
    [_favorites removeObjectAtIndex:from];
    [_favorites insertObject:item atIndex:to];
    [self saveFavorites];
}

+ (instancetype)sharedFavoriteList{
    static FavoritesList *favoritesList = nil;
    if (!favoritesList) {
        favoritesList = [[self alloc] initPrivate];
    }
    return favoritesList;
}

- (instancetype)init{
    @throw [NSException exceptionWithName:@"fatal" reason:@"please use sharedFavoriteList" userInfo:nil];
}

- (instancetype)initPrivate{
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // must call
        NSMutableArray *storedFavorites = [[defaults objectForKey:@"favorites"] mutableCopy];

        _favorites = storedFavorites != nil ? storedFavorites : [NSMutableArray array];
        
        
    }
    
    return self;
}

- (void)addFavorite:(NSString *)fontName{
    if (![_favorites containsObject:fontName]) {
        [_favorites addObject:fontName];
        // save
        [self saveFavorites];
    }
}

- (void)removeFavorite:(NSString *)fontName{
    NSInteger index = [_favorites indexOfObject:fontName];
    if (index >= 0) {
        [_favorites removeObjectAtIndex:index];
        // save
        [self saveFavorites];
    }
}

- (void)saveFavorites{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_favorites forKey:@"favorites"];
    [defaults synchronize];
}



@end
