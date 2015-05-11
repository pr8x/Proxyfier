//
//  EPProxyModifiy.m
//  EasyProxy
//
//  Created by Tony on 2013-7-28.
//  Copyright (c) 2013 PJW@LZUOSS. All rights reserved.
//

#import "EPProxyModifiy.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface EPProxyModifiy ()

@property AuthorizationRef authRef;
@property AuthorizationFlags authFlags;

@end

@implementation EPProxyModifiy
@synthesize authRef = _authRef;
@synthesize authFlags = _authFlags;

- (id)init{
 
    if (self = [super init]) {
        
        [self getAuthorization];
    }
    return self;
}

- (BOOL)getAuthorization{
    
    _authFlags = kAuthorizationFlagDefaults
    | kAuthorizationFlagExtendRights
    | kAuthorizationFlagInteractionAllowed
    | kAuthorizationFlagPreAuthorize;
    OSStatus authErr = AuthorizationCreate(nil, kAuthorizationEmptyEnvironment, _authFlags, &_authRef);
    if (authErr != noErr) {
        
        return NO;
    }
    return YES;
}



- (BOOL)changeProxySettingsWithAddress: (NSString *)address
                                 Port :(NSString *)port
                                  isON: (BOOL)isOn{
    
    SCPreferencesRef prefRef = SCPreferencesCreateWithAuthorization(nil, CFSTR("Proxy"), nil, _authRef);
    
    
    if (_authRef == NULL) {
        
        if (![self getAuthorization])
            return NO;
    }
    
    
    NSDictionary *sets = (__bridge NSDictionary *)SCPreferencesGetValue(prefRef, kSCPrefNetworkServices);
    NSMutableDictionary *proxySettings = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in [sets allKeys]) {
        NSMutableDictionary *dict = [sets objectForKey:key];
        NSString *hardware = [dict valueForKeyPath:@"Interface.Hardware"];
        if ([hardware isEqualToString:@"AirPort"] || [hardware isEqualToString:@"Ethernet"]) {
            NSDictionary *proxies = [dict objectForKey:(NSString *)kSCEntNetProxies];
            if (proxies != nil) {
                [proxySettings setObject:[proxies mutableCopy] forKey:key];
            }
        }
    }
    

    NSNumber *enable;
    
    if (isOn) {
        enable = [NSNumber numberWithInt:1];
    } else {
        enable = [NSNumber numberWithInt:0];
    }

    
    for (NSString *deviceId in proxySettings) {

        NSMutableDictionary *dict = [proxySettings objectForKey:deviceId];

        [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCFNetworkProxiesHTTPEnable];
        [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCFNetworkProxiesHTTPSEnable];
        [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCFNetworkProxiesProxyAutoConfigEnable];
        [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCFNetworkProxiesSOCKSEnable];
        
        [dict setObject:address forKey:(NSString *)kCFNetworkProxiesHTTPProxy];
        [dict setObject:[NSNumber numberWithInteger:[port integerValue]] forKey:(NSString *)kCFNetworkProxiesHTTPPort];
        [dict setObject:enable forKey:(NSString *)kCFNetworkProxiesHTTPEnable];
        
        [dict setObject:address forKey:(NSString *)kCFNetworkProxiesHTTPSProxy];
        [dict setObject:[NSNumber numberWithInteger:[port integerValue]] forKey:(NSString *)kCFNetworkProxiesHTTPSPort];
        [dict setObject:enable forKey:(NSString *)kCFNetworkProxiesHTTPSEnable];
        
        
        SCPreferencesPathSetValue(prefRef, (__bridge CFStringRef) [NSString stringWithFormat:@"/%@/%@/%@", kSCPrefNetworkServices, deviceId, kSCEntNetProxies], (__bridge CFDictionaryRef)dict);
    }
    
    SCPreferencesCommitChanges(prefRef);
    SCPreferencesApplyChanges(prefRef);
    SCPreferencesSynchronize(prefRef);
    
    return YES;
}

@end
