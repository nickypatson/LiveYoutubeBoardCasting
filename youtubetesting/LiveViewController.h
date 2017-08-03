//
//  LiveViewController.h
//  youtubetesting
//
//  Created by Nicky on 7/31/17.
//  Copyright © 2017 Nicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeStreamingLayer.h"
#import "LFLivePreview.h"


@interface LiveViewController : UIViewController
- (IBAction)liveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *liveButton;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) NSDictionary *dict;

@property (weak, nonatomic) IBOutlet LFLivePreview *livePreview;
@end
