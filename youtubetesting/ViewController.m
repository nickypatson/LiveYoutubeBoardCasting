//
//  ViewController.m
//  youtubetesting
//
//  Created by Nicky on 7/24/17.
//  Copyright © 2017 Nicky. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate= self;
    
    NSArray *driveScope = @[@"https://www.googleapis.com/auth/youtube.upload",
                            @"https://www.googleapis.com/auth/youtube",
                            @"https://www.googleapis.com/auth/youtube.force-ssl",
                            @"https://www.googleapis.com/auth/youtube.readonly"];
    NSArray *currentScopes = [GIDSignIn sharedInstance].scopes;
    [GIDSignIn sharedInstance].scopes = [currentScopes arrayByAddingObjectsFromArray:driveScope];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
}


- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
   
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
                     // For client-side use only!
    NSString *idToken = user.authentication.accessToken; // Safe to send to the server
    if ([idToken length] >0) {
        [[NSUserDefaults standardUserDefaults] setObject:idToken forKey:@"token"];
    }
    
}



- (IBAction)createEvent:(id)sender {
    [[YoutubeStreamingLayer getInstance] createBroadCastwith:^(BOOL success, NSDictionary *dict) {
        
        NSString *staus;
        
        if (success) {
            staus = @"success";
        }else{
            staus = @"failed";
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:staus preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
}

- (IBAction)upcomingEvnets:(id)sender {
    
    listViewCOntrollerViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"listViewCOntrollerViewController"];
    [self.navigationController pushViewController:view animated:YES];
}





@end
