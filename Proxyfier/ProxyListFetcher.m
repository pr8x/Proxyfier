//
//  ProxyListCurler.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import "ProxyListFetcher.h"
#import "XMLDictionary.h"



NSString* rss = @"http://www.xroxy.com/proxyrss.xml";


@implementation ProxyListFetcher

@synthesize Proxies;

-(void)Fetch {
    
    NSURL *feedURL = [NSURL URLWithString:rss];
    NSString *raw = [[NSString alloc] initWithContentsOfURL:feedURL encoding:NSUTF8StringEncoding error:NULL];
 
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:raw];

    NSArray* proxies = [xmlDoc arrayValueForKeyPath:@"channel.item.prx:proxy"];
   
    NSMutableArray*bind = [[NSMutableArray alloc] init];
    
    //anonymous
    [bind addObjectsFromArray:[self ParseArrayIntoProxyArray:proxies[0]]];
    //distorting
    [bind addObjectsFromArray:[self ParseArrayIntoProxyArray:proxies[1]]];
    //transparent
    [bind addObjectsFromArray:[self ParseArrayIntoProxyArray:proxies[2]]];
    //socks5
     [bind addObjectsFromArray:[self ParseArrayIntoProxyArray:proxies[3]]];
    //socks5
    [bind addObjectsFromArray:[self ParseArrayIntoProxyArray:proxies[4]]];
    //socks5
    [bind addObjectsFromArray:[self ParseArrayIntoProxyArray:proxies[5]]];
    //socks5
    [bind addObjectsFromArray:[self ParseArrayIntoProxyArray:proxies[6]]];

    self.Proxies = bind;
    
}


-(NSArray*)ParseArrayIntoProxyArray:(NSArray*)proxies {
    
    NSMutableArray*ret = [NSMutableArray new];
    for (id object__ in proxies) {

        //NSLog(@"%@",[object__ valueForKey:@"prx:ip"]);
        
        //mapping
        Proxy*p = [Proxy new];
        p.host = [object__ valueForKey:@"prx:ip"];
        p.port = [object__ valueForKey:@"prx:port"];
        p.type = [object__ valueForKey:@"prx:type"];
        p.reliability = [[object__ valueForKey:@"prx:reliability"] integerValue];
        p.country = [object__ valueForKey:@"prx:country_code"];
        
        [ret addObject:p];
        
    }
    
    return ret;
    
}



-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.Proxies.count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    Proxy *p = [self.Proxies objectAtIndex:row];
    return [p valueForKey: [tableColumn identifier]];
    
}


@end
