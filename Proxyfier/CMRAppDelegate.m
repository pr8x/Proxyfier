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
    
    
    PM = [[EPProxyModifiy alloc] init];
    
    PLF = [ProxyListFetcher new];
    //[self RefreshProxies:nil];
    
    
    NSLog(@"%@",@"Start App. ()");
    
    [self RefreshProxies:nil];
    self.ListRefreshView.delegate = self;
    
}

- (void)ptrScrollViewDidTriggerRefresh:(id)sender {
    [self RefreshProxies:nil];
}

- (IBAction)ToggleProxy:(id)sender {
    
    Proxy*p =  [PLF.Proxies objectAtIndex:self.ProxyList.selectedRow];
    if (p==nil)
        return;
    
    if (proxyEnabled) {
        [PM changeProxySettingsWithAddress:p.host Port:p.port isON:NO];
        proxyEnabled = NO;
        
        [_ProxyList setEnabled:YES];
        [self.ActivateButton setTitle:@"Activate"];
        [self.window setTitle:@"Proxyfier (Ready)"];

    }else{
        [PM changeProxySettingsWithAddress:p.host Port:p.port isON:YES];
        [self.window setTitle:[NSString stringWithFormat:@"%@:%@",p.host,p.port]];
        
        proxyEnabled = YES;
        [self.ActivateButton setTitle:@"Deactivate"];
    }
    
    [PVC SetStatus_:self.window.title];
    
}

- (IBAction)RefreshProxies:(id)sender {
  
    [self.spin startAnimation:nil];
    [PLF Fetch];
    
    _ProxyList.dataSource = PLF;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_ProxyList selectRowIndexes:indexSet byExtendingSelection:NO];
    
    [self.spin stopAnimation:nil];
}


@end
