//
//  CMRPopupViewController.h
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EPProxyModifiy.h"
#import "ProxyListFetcher.h"


@interface CMRPopupViewController : NSViewController  {
    BOOL proxyEnabled;
    EPProxyModifiy*PM;
     ProxyListFetcher*PLF;
    
}

- (IBAction)RefreshProxies:(id)sender;
@property (weak) IBOutlet NSTableView *ProxyList;
@property (weak) IBOutlet NSTextField *status;

@property (weak) IBOutlet NSButton *light;
@property (weak) IBOutlet NSImageView *no_p_layer;
@property (weak) IBOutlet NSImageView *lightgr;


@end
