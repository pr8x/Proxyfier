//
//  PProxyModifier.m
//  Proxyfier
//
//  Created by Luis von der Eltz on 27.04.14.
//  Copyright (c) 2014 Luis von der Eltz. All rights reserved.
//

#import "PProxyModifier.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation PProxyModifier

/* requests required authentication */
- (BOOL)requestAuthorization{
    
    authFlags = kAuthorizationFlagDefaults
    | kAuthorizationFlagExtendRights
    | kAuthorizationFlagInteractionAllowed
    | kAuthorizationFlagPreAuthorize;
    OSStatus authErr = AuthorizationCreate(nil, kAuthorizationEmptyEnvironment, authFlags, &authRef);
    if (authErr != noErr) {
        return NO;
    }
    return YES;
}

-(BOOL)hasProxy {
    return YES;
}


-(NSDictionary *)currentProxy {
    if ([self hasProxy]) {
        
        
        
    }
}





-(BOOL)changeProxySettingsWith:(NSString *)host andPort:(NSInteger)port {
    
    SCPreferencesRef prefRef = SCPreferencesCreateWithAuthorization(nil, CFSTR("Proxy"), nil, authRef);
    
    if (!authRef) {
        if (![self requestAuthorization])
            return NO;
    }
    
    
  
    
    for (NSString *deviceId in proxySettings) {
        
        NSMutableDictionary *dict = [proxySettings objectForKey:deviceId];
        
        [dict setObject:@0 forKey:(NSString *)kCFNetworkProxiesHTTPEnable];
        [dict setObject:@0 forKey:(NSString *)kCFNetworkProxiesHTTPSEnable];
        [dict setObject:@0 forKey:(NSString *)kCFNetworkProxiesProxyAutoConfigEnable];
        [dict setObject:@0 forKey:(NSString *)kCFNetworkProxiesSOCKSEnable];
        
        [dict setObject:host forKey:(NSString *)kCFNetworkProxiesHTTPProxy];
        [dict setObject:[NSNumber numberWithInteger:port] forKey:(NSString *)kCFNetworkProxiesHTTPPort];
        [dict setObject:@1 forKey:(NSString *)kCFNetworkProxiesHTTPEnable];
        
        [dict setObject:host forKey:(NSString *)kCFNetworkProxiesHTTPSProxy];
        [dict setObject:[NSNumber numberWithInteger:port] forKey:(NSString *)kCFNetworkProxiesHTTPSPort];
        [dict setObject:@1 forKey:(NSString *)kCFNetworkProxiesHTTPSEnable];
        
        
        SCPreferencesPathSetValue(prefRef, (__bridge CFStringRef) [NSString stringWithFormat:@"/%@/%@/%@", kSCPrefNetworkServices, deviceId, kSCEntNetProxies], (__bridge CFDictionaryRef)dict);
    }
    
    SCPreferencesCommitChanges(prefRef);
    SCPreferencesApplyChanges(prefRef);
    SCPreferencesSynchronize(prefRef);
    
    
    return YES;
    
}

-(void)clearProxySettings {
    
    
}


@end


