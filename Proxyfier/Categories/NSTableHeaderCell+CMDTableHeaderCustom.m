//
//  NSTableHeaderCell+CMDTableHeaderCustom.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 31.03.14.
//  Copyright (c) 2014 Luis von der Eltz. All rights reserved.
//

#import "NSTableHeaderCell+CMDTableHeaderCustom.h"

@implementation NSTableHeaderCell (CMDTableHeaderCustom)
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    
    NSMutableParagraphStyle * aParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [aParagraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [aParagraphStyle setAlignment:NSCenterTextAlignment];
    
   
    
    NSMutableDictionary *attrs = [NSMutableDictionary new];
    [attrs setObject:aParagraphStyle forKey:NSParagraphStyleAttributeName];
    
   
    NSShadow *dropShadow = [[NSShadow alloc] init];
    [dropShadow setShadowColor:[NSColor redColor]];
    [dropShadow setShadowOffset:NSMakeSize(0, -10.0)];
    [dropShadow setShadowBlurRadius:10.0];
    
    [controlView setShadow:dropShadow];

    
    [[NSColor whiteColor]setFill];
    NSRectFill(cellFrame);
    
    
    [[self stringValue] drawInRect:cellFrame withAttributes:attrs];
}

@end
