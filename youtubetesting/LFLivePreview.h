//
//  LFLivePreview.m
//
//
//  Created by Nicky on 7/24/17.
//

#import <UIKit/UIKit.h>

@interface LFLivePreview : UIView

- (void) prepareForUsing;
- (void) changeCameraPosition;
- (BOOL) changeBeauty;
- (void) startPublishingWithStreamURL: (NSString*) streamURL;
- (void) stopPublishing;

@end
