//
//  ViewController.h
//  Authorizetest
//
//  Created by Heart on 11/11/13.
//  Copyright (c) 2013 BlewsoftTECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthNet.h"

@interface ViewController : UIViewController<AuthNetDelegate>

@property (nonatomic, retain) NSString *sessionToken;

@end
