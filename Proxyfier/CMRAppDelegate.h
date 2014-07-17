//
//  CMRAppDelegate.h
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ProxyListFetcher.h"

#import "ProxyListFetcher.h"
#import "EPProxyModifiy.h"
#import "GCNetworkReachability.h"

@interface CMRAppDelegate : NSObject <NSApplicationDelegate,NSWindowDelegate> {
    BOOL proxyEnabled;
    EPProxyModifiy*PM;
    ProxyListFetcher*PLF;
    Proxy* currentProxy;
}

#pragma mark - @UI: Outlets
@property (unsafe_unretained) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTableView *ProxyList;
@property (weak) IBOutlet NSButton *ActivateButton;

- (void)RefreshProxies;
- (IBAction)ToggleProxy:(id)sender;

@end
