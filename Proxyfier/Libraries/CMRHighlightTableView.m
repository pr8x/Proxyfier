//
//  CMRHighlightTableView.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 11.05.15.
//  Copyright (c) 2015 Luis von der Eltz. All rights reserved.
//

#import "CMRHighlightTableView.h"

@implementation CMRHighlightTableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)drawRow:(NSInteger)row clipRect:(NSRect)clipRect
{
    NSColor* bgColor = Nil;
    
    if (self == [[self window] firstResponder] && [[self window] isMainWindow] && [[self window] isKeyWindow])
    {
        bgColor = [NSColor colorWithCalibratedRed:1.000 green:0.303 blue:0.324 alpha:1.000];
    }
    else
    {
        bgColor = [NSColor colorWithCalibratedRed:1.000 green:0.303 blue:0.324 alpha:0.820];
    }
    
    
    NSIndexSet* selectedRowIndexes = [self selectedRowIndexes];
    if ([selectedRowIndexes containsIndex:row])
    {
        [bgColor setFill];
        NSRectFill([self rectOfRow:row]);
    }
  
    [super drawRow:row clipRect:clipRect];
}
@end
