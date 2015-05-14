//
//  CMRWindowController.h
//  Proxyfier
//
//  Created by Luis von der Eltz on 14.05.15.
//  Copyright (c) 2015 Luis von der Eltz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ProxyListFetcher.h"

#import "CMRHighlightTableView.h"
#import "EPProxyModifiy.h"


@interface CMRWindowController : NSWindowController <NSApplicationDelegate,NSWindowDelegate,NSTableViewDelegate> {
    BOOL proxyEnabled;
    EPProxyModifiy*PM;
    ProxyListFetcher*PLF;
    Proxy* currentProxy;
}

#pragma mark - @UI: Outlets

@property (strong) IBOutlet CMRHighlightTableView *ProxyList;
@property (weak) IBOutlet NSButton *ActivateButton;
@property (weak) IBOutlet NSTextField *updateLabel;


- (IBAction)ToggleProxy:(id)sender;
- (void)RefreshProxies;
@end
