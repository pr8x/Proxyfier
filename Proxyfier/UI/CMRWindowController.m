//
//  CMRWindowController.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 14.05.15.
//  Copyright (c) 2015 Luis von der Eltz. All rights reserved.
//

#import "CMRWindowController.h"
#import "NSDate+TimeAgo.h"

@implementation CMRWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"UI"];
    
    if (self)
    {
        //...
    }
    
    return self;
}

#pragma mark - @NSWindowDelegate
-(void)windowWillClose:(NSNotification *)notification {
    if (currentProxy) {
        [PM changeProxySettingsWithAddress:currentProxy.host Port:currentProxy.port isON:NO];
    }
}


- (void)windowDidLoad {
    [super windowDidLoad];
    
    PM = [[EPProxyModifiy alloc] init];
    PLF = [[ProxyListFetcher alloc] init];
    
    NSLog(@"%@",@"Start App. ()");
    
    [self.ProxyList setDoubleAction:@selector(ToggleProxy:)];
    self.ProxyList.dataSource = PLF;
    self.ProxyList.delegate =self;
    
    [self RefreshProxies];
    
    self.window.delegate = self;
    
    // Force to show a titlebar icon
    [self.window setRepresentedURL:[NSURL URLWithString:@"."]];
    [[self.window standardWindowButton:NSWindowDocumentIconButton] setImage:[NSImage imageNamed:@"red_status"]];
}




// Implement window delegate method to prevent to popup document (which do not exist) path menu when cmd+clicked
- (BOOL)window:(NSWindow *)window shouldPopUpDocumentPathMenu:(NSMenu *)menu
{
    return NO;
}


- (IBAction)ToggleProxy:(id)sender {
    
    Proxy*p = PLF.Proxies[self.ProxyList.selectedRow];
    if (p==nil)
        return;
    
    if (proxyEnabled) {
        if ([PM changeProxySettingsWithAddress:p.host Port:p.port isON:NO]) {
            proxyEnabled = NO;
            
            [self.ActivateButton setTitle:@"Activate"];
            [self.window setTitle:@"Proxyfier"];
            
            [[self.window standardWindowButton:NSWindowDocumentIconButton] setImage:[NSImage imageNamed:@"red_status"]];
            
            currentProxy = p;
        }
        
    }else{
        if ([PM changeProxySettingsWithAddress:p.host Port:p.port isON:YES]) {
            proxyEnabled = YES;
            [self.ActivateButton setTitle:@"Deactivate"];
            [self.window setTitle:[NSString stringWithFormat:@"%@:%@",p.host,p.port]];
            
            [[self.window standardWindowButton:NSWindowDocumentIconButton] setImage:[NSImage imageNamed:@"green_status"]];
            
            currentProxy = nil;
        }
    }
    
}


#pragma mark - Refresh
- (void)RefreshProxies {
    
    [PLF Fetch];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    NSDate* update = [formatter dateFromString:PLF.lastUpdated];
    
    self.updateLabel.stringValue = [update timeAgo];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.ProxyList selectRowIndexes:indexSet byExtendingSelection:NO];
    [self.ProxyList reloadData];
    
}


@end
