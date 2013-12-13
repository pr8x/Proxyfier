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

}
@property (unsafe_unretained) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTableView *ProxyList;
@property (weak) IBOutlet NSButton *reachability;

- (IBAction)RefreshProxies:(id)sender;
- (IBAction)ToggleProxy:(id)sender;
@property (weak) IBOutlet NSButton *ActivateButton;

@property   (strong) GCNetworkReachability*nreach;

@property (weak) IBOutlet NSTextField *status;
@property (weak) IBOutlet NSButton *light;

@end
