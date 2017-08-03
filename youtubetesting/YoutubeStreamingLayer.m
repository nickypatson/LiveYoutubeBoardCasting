//
//  YoutubeStreamingLayer.m
//  
//
//  Created by Nicky on 7/24/17.
//

#import "YoutubeStreamingLayer.h"

#define APIKEY @"AIzaSyBXh3tD5g8BekHeg0kIaL8Q2hkGUNp5IyM"

static YoutubeStreamingLayer *sharedInstance = nil;
@implementation YoutubeStreamingLayer


static id extracted() {
    return [[YoutubeStreamingLayer alloc] init];
}

+(YoutubeStreamingLayer *) getInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = extracted();
    });
    return sharedInstance;
}


-(id) init
{
    self=[super init];
    if (self)
    {
        tokenValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    }
    return self;
}

-(void)createBroadCastwith:(void (^)(BOOL success, NSDictionary *dict))completion{
    
    [self makeBroadCasstRequestwith:^(BOOL success, NSDictionary *broadCastDict) {
        
        if (success) {
            
            NSLog(@"sucess braodcast 1 ");
            NSString *boardingcastId = broadCastDict[@"id"];
            
            [self makeLiveStreamwith:^(BOOL success, NSDictionary *liveStreamDict) {
                
                if (success) {
                    
                    NSLog(@"sucess livestream 2");
                    NSString *streamingId = liveStreamDict[@"id"];
                    
                    [self blindLiveStreamdictionaryboardCastId:boardingcastId streamid:streamingId with:^(BOOL success, NSDictionary *liveStreamDict) {
                        
                        if (success) {
                            
                            NSLog(@"sucess blinelive 3 ");
                            completion(true,liveStreamDict);
                        }else{
                            
                            NSLog(@"blind live stream failed 3");
                            completion(false,nil);
                        }
                    }];
                }else{
                    
                    NSLog(@"live stream failed 2");
                }
            }];
        }else{
            
            NSLog(@"live boardcastFailed 1");
        }
    }];
}


-(void)makeBroadCasstRequestwith:(void (^)(BOOL success, NSDictionary *broadCastDict))completion{
    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"Bearer %@",tokenValue]};
    
    NSDictionary *parameters = @{ @"snippet": @{ @"title": @"nicky", @"scheduledStartTime":     @"2017-08-02T11:59:15+05:00", @"description": @"dsfsdfs" },
                                  @"status": @{ @"privacyStatus": @"public" } };
    
    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/liveBroadcasts?part=id,snippet,contentDetails,status&key=%@",APIKEY];
    
    [self makeApiRequestwith:url withParmaters:parameters withHeaders:headers Completion:^(BOOL success, NSDictionary *dict) {
        
        if (success) {
            completion(true,dict);
        }else{
            completion(false,nil);
        }

    }];
}


-(void)makeLiveStreamwith:(void (^)(BOOL success, NSDictionary *liveStreamDict))completion{
    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"Bearer %@",tokenValue]};
    

    
    NSDictionary *parameters = @{ @"snippet": @{ @"title": @"nicky", @"description": @"dsfsdfs" },
                                  @"cdn": @{ @"resolution": @"480p", @"frameRate": @"30fps" , @"ingestionType":@"rtmp" }, @"ingestionInfo": @{ @"streamName": @"Nicky" }
                                };
    
    
    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/liveStreams?part=id,snippet,cdn,status&key=%@",APIKEY];
    
    [self makeApiRequestwith:url withParmaters:parameters withHeaders:headers Completion:^(BOOL success, NSDictionary *dict) {
    
        if (success) {
            completion(true,dict);
        }else{
            completion(false,nil);
        }
        

        
    }];
}


-(void)blindLiveStreamdictionaryboardCastId:(NSString*)boardCastId streamid:(NSString*)streamid with:(void (^)(BOOL success, NSDictionary *liveStreamDict))completion{
    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"Bearer %@",tokenValue]};
    


    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/liveBroadcasts/bind?id=%@&streamId=%@&part=id,snippet,contentDetails,status&key=%@",boardCastId,streamid,APIKEY];
    

    
    [self makeApiRequestwith:url withParmaters:@{}
                 withHeaders:headers Completion:^(BOOL success, NSDictionary *dict) {
                     if (success) {
                         completion(true,dict);
                     }else{
                         completion(false,nil);
                     }
        
    }];
}




-(void)getBroadCasstRequest:(NSString*)broadCastId with:(NSString *)streamIdValue with:(void (^)(BOOL success, NSDictionary *broadCastDict,NSDictionary *streamDict))completion{
    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"Bearer %@",tokenValue]};
    
    
    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/liveBroadcasts?part=id,snippet,contentDetails,status&key=%@&id=%@",APIKEY,broadCastId];
    
    
    [self makePutApiRequestwith:url withParmaters:@{} withHeaders:headers Completion:^(BOOL success, NSDictionary *dict1) {
        if (success) {
            
            
            NSDictionary *headers = @{ @"Content-Type": @"application/json",
                                       @"Authorization": [NSString stringWithFormat:@"Bearer %@",tokenValue]};
            
            NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/liveStreams?part=id,snippet,cdn,status&key=%@&id=%@",APIKEY,streamIdValue];
            
            
            [self makePutApiRequestwith:url withParmaters:@{} withHeaders:headers Completion:^(BOOL success, NSDictionary *dict2) {
                if (success) {
                    
                    if ([dict1[@"items"] count] >0 && [dict2[@"items"] count] >0) {
                       completion(TRUE,dict1[@"items"][0],dict2[@"items"][0]);
                    }else{
                        completion(FALSE,nil,nil);
                    }
                    
                }
            }];
        }
        
    }];
    
}


-(void)transitionBroadcastdictionary:(NSString*)broadCastId withStatus:(NSString*)status with:(void (^)(BOOL success, NSDictionary *transistionDict))completion{
    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"Bearer %@",tokenValue]};

    
    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/liveBroadcasts/transition?part=id,snippet,contentDetails,status&key=%@&id=%@&broadcastStatus=%@",APIKEY,broadCastId,status];
    
    
    [self makeApiRequestwith:url withParmaters:@{}
                 withHeaders:headers Completion:^(BOOL success, NSDictionary *dict) {
                     
                     if (success) {
                         completion(TRUE,dict);
                     }else{
                         completion(FALSE,nil);
                     }
                     
                 }];
}




-(void)listUpcomingVideosCompletion:(void (^)(BOOL success, NSDictionary *dict))completion{
    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Authorization": [NSString stringWithFormat:@"Bearer %@",tokenValue]};
    
    
    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/liveBroadcasts?broadcastStatus=upcoming&maxResults=50&part=id,snippet,contentDetails&key=%@",APIKEY];
    
    
    
    [self makePutApiRequestwith:url withParmaters:@{} withHeaders:headers Completion:^(BOOL success, NSDictionary *dict) {
        
        completion(true,dict);
    }];
}








-(void)makeApiRequestwith:(NSString*)url withParmaters:(NSDictionary*)parameters withHeaders:(NSDictionary*)headers Completion:(void (^)(BOOL success, NSDictionary *dict))completion{
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        int statusCode = (int)[httpResponse statusCode];
                                                        NSDictionary *responseJson;
                                                        if (data)
                                                        {
                                                            responseJson  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        }
                                                        
                                                        if (error || (statusCode != 200 )){
                                                            completion(FALSE,nil);
                                                        }
                                                        else
                                                        {
                                                            completion(TRUE,responseJson);
                                                        }
                                                    
                                                    }
                                                }];
    [dataTask resume];
    
}


-(void)makePutApiRequestwith:(NSString*)url withParmaters:(NSDictionary*)parameters withHeaders:(NSDictionary*)headers Completion:(void (^)(BOOL success, NSDictionary *dict))completion{
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];

    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        int statusCode = (int)[httpResponse statusCode];
                                                        NSDictionary *responseJson;
                                                        if (data)
                                                        {
                                                            responseJson  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        }
                                                        
                                                        if (error || (statusCode != 200 )){
                                                            completion(FALSE,nil);
                                                        }
                                                        else
                                                        {
                                                            completion(TRUE,responseJson);
                                                        }
                                                        
                                                    }

                                                }];
    [dataTask resume];
    
}






@end

