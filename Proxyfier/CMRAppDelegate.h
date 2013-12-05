//
//  CMRAppDelegate.h
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ProxyListFetcher.h"
#import "CMRPopupViewController.h"
#import "ProxyListFetcher.h"
#import "EPProxyModifiy.h"
#import "PullToRefreshScrollView.h"
#import "PullToRefreshDelegate.h"

@interface CMRAppDelegate : NSObject <NSApplicationDelegate,PullToRefreshDelegate> {
 
    BOOL proxyEnabled;
    EPProxyModifiy*PM;
    ProxyListFetcher*PLF;
    
    CMRPopupViewController*PVC;
}
@property (unsafe_unretained) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTableView *ProxyList;

- (IBAction)RefreshProxies:(id)sender;
- (IBAction)ToggleProxy:(id)sender;
@property (weak) IBOutlet NSButton *ActivateButton;
@property (weak) IBOutlet PullToRefreshScrollView *ListRefreshView;
@property (weak) IBOutlet NSProgressIndicator *spin;

@end
