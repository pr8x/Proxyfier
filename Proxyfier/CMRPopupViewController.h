//
//  CMRPopupViewController.h
//  Proxyfier
//
//  Created by Luis von der Eltz on 04.09.13.
//  Copyright (c) 2013 Luis von der Eltz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CMRPopupViewController : NSViewController  {
  
}


@property (weak) IBOutlet NSTextField *status;
-(void)SetStatus_:(NSString*)f;

@end
