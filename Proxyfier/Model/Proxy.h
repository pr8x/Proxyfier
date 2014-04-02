//
//  Proxy.h
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Proxy : NSObject
@property NSString*host;
@property NSString*port;
@property NSString*type;
@property NSInteger reliability;
@property NSString * country;

@end
