//
//  PProxyModifier.h
//  Proxyfier
//
//  Created by Luis von der Eltz on 27.04.14.
//  Copyright (c) 2014 Luis von der Eltz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PProxyModifier : NSObject {
    AuthorizationRef authRef;
    AuthorizationFlags authFlags;
    NSMutableDictionary* proxySettings;
}


@property (readonly) BOOL hasProxy;
@property (readonly) NSDictionary* currentProxy;

- (BOOL) changeProxySettingsWith:(NSString*)host andPort:(NSInteger)port;
- (void) clearProxySettings;

@end
