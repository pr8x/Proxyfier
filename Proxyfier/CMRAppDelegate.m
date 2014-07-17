//
//  CMRAppDelegate.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import "CMRAppDelegate.h"
#import "EPProxyModifiy.h"
#import "INAppStoreWindow.h"

@implementation CMRAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    PM = [EPProxyModifiy new];
    PLF = [ProxyListFetcher new];

    NSLog(@"%@",@"Start App. ()");
    
    
    [self.ProxyList setDoubleAction:@selector(ToggleProxy:)];
    self.ProxyList.dataSource = PLF;
    
    [self RefreshProxies];

    INAppStoreWindow *aWindow = (INAppStoreWindow*)[self window];
    aWindow.titleBarHeight = 55;
    aWindow.showsBaselineSeparator = NO;
    aWindow.titleBarStartColor     = [NSColor colorWithCalibratedRed:0.995 green:0.990 blue:0.990 alpha:1.000];
    aWindow.titleBarEndColor       = [NSColor whiteColor];

    
    aWindow.inactiveTitleBarEndColor       = [NSColor colorWithCalibratedWhite: 0.95 alpha: 1.0];
    aWindow.inactiveTitleBarStartColor     = [NSColor colorWithCalibratedWhite: 0.8  alpha: 1.0];
    aWindow.showsTitle = YES;
    aWindow.showsBaselineSeparator = NO;
    self.window.delegate = self;
    
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
        
        currentProxy = p;
        

    }else{
        [PM changeProxySettingsWithAddress:p.host Port:p.port isON:YES];
        
        proxyEnabled = YES;
        [self.ActivateButton setTitle:@"Deactivate"];
        [self.window setTitle:[NSString stringWithFormat:@"%@:%@",p.host,p.port]];

        currentProxy = nil;
    }
 
}

#pragma mark - Refresh
- (void)RefreshProxies {

    [PLF Fetch];

    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.ProxyList selectRowIndexes:indexSet byExtendingSelection:NO];
    [self.ProxyList reloadData];
    
}

#pragma mark - @NSWindowDelegate
-(void)windowWillClose:(NSNotification *)notification {
    if (currentProxy)
        [PM changeProxySettingsWithAddress:currentProxy.host Port:currentProxy.port isON:NO];
}


@end
