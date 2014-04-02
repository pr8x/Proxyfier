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
#import "INAppStoreWindow.h"



@implementation CMRAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    
    PM = [EPProxyModifiy new];
    PLF = [ProxyListFetcher new];


    NSLog(@"%@",@"Start App. ()");
    [self RefreshProxies:nil];

    INAppStoreWindow *aWindow = (INAppStoreWindow*)[self window];
    aWindow.titleBarHeight = 65.0;
    aWindow.showsBaselineSeparator = NO;
    [aWindow setTitleBarDrawingBlock:^(BOOL drawsAsMainWindow, CGRect drawingRect, CGPathRef clippingPath){
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextAddPath(context, clippingPath);
        CGContextClip(context);
        
        [[NSColor whiteColor] set];
        NSRectFill(drawingRect);
        
        
        NSMutableParagraphStyle * aParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        [aParagraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        [aParagraphStyle setAlignment:NSCenterTextAlignment];
        [aParagraphStyle setMinimumLineHeight:30];
    
        
        NSMutableDictionary *attrs = [NSMutableDictionary new];
        [attrs setObject:aParagraphStyle forKey:NSParagraphStyleAttributeName];
        [attrs setObject:[NSFont fontWithName:@"Lato-Regular" size:14.0f] forKey:NSFontAttributeName];
        
        [self.window.title drawInRect:drawingRect withAttributes:attrs];
        
        
        CGRect description = CGRectOffset(drawingRect, 0.0f, -13.0f);
        NSMutableDictionary*attrs2 = [NSMutableDictionary dictionaryWithDictionary:attrs];
        [attrs2 setObject:[NSFont fontWithName:@"Lato-Regular" size:9.0f] forKey:NSFontAttributeName];
        [attrs2 setObject:[NSColor grayColor] forKey:NSForegroundColorAttributeName];
    
        // ?!: [[NSColor grayColor] set];
        [@"provided by http://www.xroxy.com/proxyrss.xml" drawInRect:description withAttributes:attrs2];
        
    }];
    
    
    
    [self.ProxyList setDoubleAction:@selector(ToggleProxy:)];

    self.window.delegate = self;
    
}

- (void)ptrScrollViewDidTriggerRefresh:(id)sender {
    [self RefreshProxies:nil];
}

- (IBAction)ToggleProxy:(id)sender {
    
    Proxy*p = [PLF.Proxies objectAtIndex:self.ProxyList.selectedRow];
    if (p==nil)
        return;
    
    if (proxyEnabled) {
        [PM changeProxySettingsWithAddress:p.host Port:p.port isON:NO];
        proxyEnabled = NO;
        
        [self.ActivateButton setTitle:@"Activate"];
        [self.window setTitle:@"localhost"];
        

    }else{
        [PM changeProxySettingsWithAddress:p.host Port:p.port isON:YES];
        
        proxyEnabled = YES;
        [self.ActivateButton setTitle:@"Deactivate"];
        [self.window setTitle:[NSString stringWithFormat:@"%@:%@",p.host,p.port]];

    }
    
 
}




- (IBAction)RefreshProxies:(id)sender {

    [PLF Fetch];
    
    _ProxyList.dataSource = PLF;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_ProxyList selectRowIndexes:indexSet byExtendingSelection:NO];
    
}


@end
