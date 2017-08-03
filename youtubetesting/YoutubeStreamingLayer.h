//
//  YoutubeStreamingLayer.h
//  
//
//  Created by Nicky on 7/24/17.
//

#import <Foundation/Foundation.h>

@interface YoutubeStreamingLayer : NSObject{
    
    NSString *tokenValue;
}

+(YoutubeStreamingLayer *) getInstance;
-(void)createBroadCastwith:(void (^)(BOOL success, NSDictionary *dict))completion;


-(void)getBroadCasstRequest:(NSString*)broadCastId with:(NSString *)streamIdValue with:(void (^)(BOOL success, NSDictionary *broadCastDict,NSDictionary *streamDict))completion;
-(void)transitionBroadcastdictionary:(NSString*)broadCastId withStatus:(NSString*)status with:(void (^)(BOOL success, NSDictionary *transistionDict))completion;

-(void)listUpcomingVideosCompletion:(void (^)(BOOL success, NSDictionary *dict))completion;
@end
