//
//  ProxyListCurler.h
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Proxy.h"



@interface ProxyListFetcher : NSObject <NSTableViewDataSource>{
    NSMutableArray*Proxies;
}

@property (nonatomic,strong) NSMutableArray*Proxies;

/* Starts fetching proxies */
-(void)Fetch;

@end
