//
//  TinyPixDocument.m
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "TinyPixDocument.h"

static uint8_t bitmap[] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};

@interface TinyPixDocument ()



@end

@implementation TinyPixDocument

-(instancetype)initWithFileURL:(NSURL *)url{
    return [super initWithFileURL:url];
}

- (BOOL)stateAtRow:(int)row Column:(int)column{
    Byte rowByte = bitmap[row];
    uint8_t result = (uint8_t)(1 << column) & rowByte;
    return result != 0;
}

- (void)setState:(BOOL)state atRow:(int)row atColumn:(int)column{
    Byte rowByte = bitmap[row];
    if (state) {
        rowByte |= (uint8_t)(1 << column);
    }else{
        rowByte &= ~(uint8_t)(1 << column);
    }
    bitmap[row] = rowByte;
}

-(void)toggleStateAtRow:(int)row Column:(int)column{
    BOOL state = [self stateAtRow:row Column:column];
    [self setState:!state atRow:row atColumn:column];
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError{
    NSLog(@"Saving document to URL %@", self.fileURL);
    NSData *bitmapData = [NSData dataWithBytes:bitmap length:8];
    return bitmapData;
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError{
    NSData *bitmapData = contents;
    if (bitmapData) {
        [bitmapData getBytes:bitmap length:8];
        return YES;
    }
    
    return NO;
    
}




@end
