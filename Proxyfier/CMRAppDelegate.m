//
//  CMRAppDelegate.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import "CMRAppDelegate.h"
#import "AXStatusItemPopup.h"
#import "EPProxyModifiy.h"



@implementation CMRAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    
    // init content view controller
    // its contents will be shown inside the popover
    CMRPopupViewController *contentViewController = [[CMRPopupViewController alloc] initWithNibName:@"CMRPopupViewController" bundle:nil];
    
    PVC = contentViewController;
    
    // create icon images shown in statusbar
    NSImage *image = [NSImage imageNamed:@"cloud"];
    NSImage *alternateImage = [NSImage imageNamed:@"cloudgrey"];
    
    AXStatusItemPopup *statusItemPopup = [[AXStatusItemPopup alloc] initWithViewController:contentViewController image:image alternateImage:alternateImage];
    
    
   
}

@end
