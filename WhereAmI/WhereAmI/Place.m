//
//  Place.m
//  WhereAmI
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "Place.h"

@implementation Place

- (instancetype)initWithTitle:(NSString *)title WithSubtitle:(NSString *)subtitle WithCoordinate:(CLLocationCoordinate2D)coordinate{
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
    }
   
    return self;
}



@end
