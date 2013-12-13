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
        
        NSColor*c = [NSColor colorWithPatternImage:[NSImage imageNamed:@"mac_title_bar"]];
        [c set];
        NSRectFill(drawingRect);
    }];
    
    
    
    [self.ProxyList setDoubleAction:@selector(ToggleProxy:)];

    self.window.delegate = self;
    
}

-(void)awakeFromNib {
        [self StartReachability];
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
        [self.status setTitleWithMnemonic:@"localhost"];
        self.light.image = [NSImage imageNamed:@"red_status"];

    }else{
        [PM changeProxySettingsWithAddress:p.host Port:p.port isON:YES];
        
        proxyEnabled = YES;
        [self.ActivateButton setTitle:@"Deactivate"];
        [self.status setTitleWithMnemonic:[NSString stringWithFormat:@"%@:%@",p.host,p.port]];
        self.light.image = [NSImage imageNamed:@"green_status"];
    }
    
 
}

-(void)StartReachability{
    self.nreach = [GCNetworkReachability reachabilityForInternetConnection];
    [self.nreach startMonitoringNetworkReachabilityWithHandler:^(GCNetworkReachabilityStatus status) {
        
        if ([self.nreach isReachable]) {
            self.reachability.image = [NSImage imageNamed:@"121 Cloud"];
            
            switch (status) {
                case GCNetworkReachabilityStatusWWAN:
                    
                    [self.reachability setToolTip:@"WWAN Connection."];
                    
                    break;
                case GCNetworkReachabilityStatusWiFi:
                    [self.reachability setToolTip:@"WLAN Connection."];
                    break;
                    
                default:
                    [self.reachability setToolTip:@"Error determining current network status."];
                    break;
            }
            
            
        }else{
            self.reachability.image = [NSImage imageNamed:@"126 CloudError"];
            [self.reachability setToolTip:@"No Connection."];
        }

    }];
    
    
}


- (IBAction)RefreshProxies:(id)sender {

    [PLF Fetch];
    
    _ProxyList.dataSource = PLF;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_ProxyList selectRowIndexes:indexSet byExtendingSelection:NO];
    
}


@end
