//
//  EPProxyModifiy.h
//  EasyProxy
//
//  Created by Tony on 2013-7-28.
//  Copyright (c) 2013 PJW@LZUOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPProxyModifiy : NSObject

- (void)changeProxySettingsWithAddress: (NSString *)address
                                 Port :(NSString *)port
                                  isON: (BOOL)isOn;

@end
