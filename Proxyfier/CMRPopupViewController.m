//
//  CMRPopupViewController.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import "CMRPopupViewController.h"


@interface CMRPopupViewController ()

@end

@implementation CMRPopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        
        
    }
    
    return self;
}


- (void)viewDidLoad {
    PM = [[EPProxyModifiy alloc] init];
    
    PLF = [ProxyListFetcher new];
    //[self RefreshProxies:nil];

    
    NSLog(@"%@",@"Start App. ()");
}
- (void)loadView {
   
    [super loadView];
    
    [self viewDidLoad];
}


- (IBAction)ToggleProxy:(id)sender {
    
    Proxy*p =  [PLF.Proxies objectAtIndex:self.ProxyList.selectedRow];
    if (p==nil)
        return;
    
    if (proxyEnabled) {
        [PM changeProxySettingsWithAddress:p.host Port:p.port isON:NO];
        proxyEnabled = NO;
        
        [_ProxyList setEnabled:YES];
        [self.status setTitleWithMnemonic:@"Proxy deactivated."];
        
        [_lightgr setImage:[NSImage imageNamed:@"red_status"]];
    }else{
    
        [PM changeProxySettingsWithAddress:p.host Port:p.port isON:YES];
        
        [self.status setTitleWithMnemonic:[NSString stringWithFormat:@"%@:%@",p.host,p.port]];
        [self.light setState:1];
        
        proxyEnabled = YES;
        
//        NSSound*x = [NSSound soundNamed:@"Pop"];
//        [x play];
        
        [_ProxyList setEnabled:NO];
        [_lightgr setImage:[NSImage imageNamed:@"green_status"]];
        
    }
    
    
}

- (IBAction)RefreshProxies:(id)sender {
    
    [_no_p_layer setHidden:YES];
    [PLF Fetch];
    
    _ProxyList.dataSource = PLF;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_ProxyList selectRowIndexes:indexSet byExtendingSelection:NO];
    

}



@end
