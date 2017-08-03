//
//  ViewController.h
//  youtubetesting
//
//  Created by Nicky on 7/24/17.
//  Copyright © 2017 Nicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import "YoutubeStreamingLayer.h"
#import "listViewCOntrollerViewController.h"

@interface ViewController : UIViewController<GIDSignInUIDelegate,GIDSignInDelegate>

- (IBAction)createEvent:(id)sender;
- (IBAction)upcomingEvnets:(id)sender;

@property (weak, nonatomic) IBOutlet GIDSignInButton *signButton;

@end

