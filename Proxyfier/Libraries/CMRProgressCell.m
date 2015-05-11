//
//  CMRProgressCell.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 11.05.15.
//  Copyright (c) 2015 Luis von der Eltz. All rights reserved.
//

#import "CMRProgressCell.h"

@implementation CMRProgressCell

-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
    
     [[NSGraphicsContext currentContext]saveGraphicsState];
     [[NSColor greenColor]set];
     [NSBezierPath fillRect:cellFrame];
    [[NSGraphicsContext currentContext]restoreGraphicsState];
}





@end
