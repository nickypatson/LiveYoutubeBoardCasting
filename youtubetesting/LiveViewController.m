//
//  LiveViewController.m
//  youtubetesting
//
//  Created by Nicky on 7/31/17.
//  Copyright © 2017 Nicky. All rights reserved.
//

#import "LiveViewController.h"

@interface LiveViewController (){
    NSTimer *timmer;
}

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    NSLog(@"watch live video at https://www.youtube.com/watch?v=%@",_dict[@"id"]);
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [_livePreview prepareForUsing];
    });
}

-(void)startTimmerStatus{
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                                      target: self
                                                    selector:@selector(liveVideoStatusRequestTickTimer)
                                                    userInfo: nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:t forMode:NSRunLoopCommonModes];
        [self liveVideoStatusRequestTickTimer];
    });
    
    
    
    
}


-(void)stopTimmerStatus {
    [timmer invalidate];
    timmer = nil;
}



- (IBAction)liveAction:(id)sender {
    
    if (_liveButton.isSelected) {
        [_liveButton setSelected:FALSE];
        [_liveButton setTitle:@"Start live broadcast" forState:UIControlStateNormal];
        [_livePreview stopPublishing];
        [self completeLiveBoardCast];
        [self stopTimmerStatus];
       
        
    }else{
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"watch live video at https://www.youtube.com/watch?v=%@",_dict[@"id"]] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        [_liveButton setSelected:TRUE];
        [_liveButton setTitle:@"Finish live broadcast" forState:UIControlStateNormal];
        [self startLiveBoarCast];
    }
}

-(void)startLiveBoarCast{
    
    [[YoutubeStreamingLayer getInstance] getBroadCasstRequest:_dict[@"id"] with:_dict[@"contentDetails"][@"boundStreamId"] with:^(BOOL success, NSDictionary *broadCastDict, NSDictionary *streamDict) {
        
        NSString *streamName = streamDict[@"cdn"][@"ingestionInfo"][@"streamName"];
        NSString *streamUrl = [NSString stringWithFormat:@"%@/%@",streamDict[@"cdn"][@"ingestionInfo"][@"ingestionAddress"],streamDict[@"cdn"][@"ingestionInfo"][@"streamName"]];
        NSString *scheduledStartTime = broadCastDict[@"snipped"][@"scheduledStartTime"];
        
        NSString *sreamId = streamDict[@"id"];
        NSString *monitorStream = broadCastDict[@"contentDetails"][@"monitorStream"][@"embedHtml"];
        NSString *streamTitle = streamDict[@"snipped"][@"title"];
        
        [self startTimmerStatus];
        
        [_livePreview startPublishingWithStreamURL:streamUrl];
        
    }];
}


-(void)liveVideoStatusRequestTickTimer{
    
    [[YoutubeStreamingLayer getInstance] getBroadCasstRequest:_dict[@"id"] with:_dict[@"contentDetails"][@"boundStreamId"] with:^(BOOL success, NSDictionary *broadCastDict, NSDictionary *streamDict) {
        

        NSString* broadcastStatus = broadCastDict[@"status"][@"lifeCycleStatus"];
        NSString* streamStatus = streamDict[@"status"][@"streamStatus"];
        NSString* healthStatus = streamDict[@"status"][@"healthStatus"][@"status"];
        
        NSLog(broadcastStatus,streamStatus,healthStatus);
        
        dispatch_async(dispatch_get_main_queue(), ^{
          [self updateStatus:broadcastStatus];
        });
        
        if ([broadcastStatus isEqualToString: @"live"] || [broadcastStatus isEqualToString: @"liveStarting"]) {
            

            
            NSLog(@"live now man");
        }else{
            [self transitionStatusCheck];
        }
        
    }];
    
    
}



-(void)transitionStatusCheck{
    
    [[YoutubeStreamingLayer getInstance] transitionBroadcastdictionary:_dict[@"id"] withStatus:@"live" with:^(BOOL success, NSDictionary *transistionDict) {
        
        if (success) {
        }else{
            
            [[YoutubeStreamingLayer getInstance] transitionBroadcastdictionary:_dict[@"id"] withStatus:@"testing" with:^(BOOL success, NSDictionary *transistionDict) {
                
                if (success) {
                }else{
                }
            }];
        }
    }];
}



-(void)completeLiveBoardCast{
    
[[YoutubeStreamingLayer getInstance] transitionBroadcastdictionary:_dict[@"id"] withStatus:@"complete" with:^(BOOL success, NSDictionary *transistionDict) {
    
    if (success) {
        _labelStatus.text = @"completed";
    }else{
        
    }
}];
}

-(void)updateStatus:(NSString*)value{
    _labelStatus.text = value;
}




@end
