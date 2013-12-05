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
   
}
- (void)loadView {
   
    [super loadView];
    
    [self viewDidLoad];
}

-(void)SetStatus_:(NSString*)f {
    [self.status setTitleWithMnemonic:f];
}



@end
