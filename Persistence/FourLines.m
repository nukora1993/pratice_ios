//
//  FourLines.m
//  Persistence
//
//  Created by nuko on 2020/6/29.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "FourLines.h"
static NSString * const linesKey = @"linesKey";
@implementation FourLines

- (instancetype)init{
    self = [super init];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self.lines = [coder decodeObjectForKey:linesKey];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder{
    NSArray *saveLines = self.lines;
    if (saveLines) {
        [coder encodeObject:saveLines forKey:linesKey];
    }
}

- (id)copyWithZone:(NSZone *)zone{
    FourLines *copy = [[FourLines alloc] init];
    NSArray *linesToCopy = self.lines;
    if (linesToCopy) {
        NSMutableArray *newLines = [NSMutableArray array];
        for (NSString *line in newLines) {
            [newLines addObject:line];
        }
        copy.lines = newLines;
    }
    
    
    return copy;
}

@end
