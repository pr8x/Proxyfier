//
//  NSTextFieldCell+Focus.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 13.08.14.
//  Copyright (c) 2014 Luis von der Eltz. All rights reserved.
//

#import "NSTextFieldCell+Focus.h"

@implementation NSTextFieldCell (Focus)

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView*)controlView
{
    self.drawsBackground = NO;
    

    if (!self.isHighlighted) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObjects:
                                    @[self.textColor]
                                                               forKeys:
                                    @[NSForegroundColorAttributeName]];
        [[self title] drawInRect:cellFrame withAttributes:attributes];
    }else{
        NSDictionary *attributes = [NSDictionary dictionaryWithObjects:
                                    @[[NSColor whiteColor]]
                                                               forKeys:
                                    @[NSForegroundColorAttributeName]];
        [[self title] drawInRect:cellFrame withAttributes:attributes];
        
    }
}

@end
