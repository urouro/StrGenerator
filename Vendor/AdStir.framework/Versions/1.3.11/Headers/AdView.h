//
//  AD-STA for iOS SDK
//  AdView.h
//
//  Created by ngi group inc. on 11/05/26.
//  Copyright 2011 ngi group inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define AdResultDelegate AdstaResultDelegate
#define AdView AdstaView
#define AdRotation AdstaRotation

@protocol AdResultDelegate
//広告が取得出来た際に呼ばれます
- (void)onReceived;
//広告が取得出来なかった際に呼ばれます
- (void)onFailed;
@end

@interface AdView : UIImageView {
	UIImage *bmp;
	UIImageView *icon;
	UILabel *lbl;
//	int adInterval;
	bool debug, testMode;
	NSString *mediaId, *slotId, *uid, *mccmnc;
	NSString *link_url, *ipAddress;
	int idx;
	bool isInitialized;
	NSOperationQueue *queue;
	NSString *json_ua;
	id <AdResultDelegate> delegate;
}

@property(nonatomic, assign) id<AdResultDelegate> delegate;
@property(nonatomic, retain) UIImage *tempBanner;
@property(nonatomic, retain) UIImage *tempIcon;
@property(nonatomic, retain) NSString *tempImageUrl, *tempLinkUrl, *tempFulltext;

- (void) _init;
- (void)startTimer;
- (void)stopTimer;
- (void)getBackGround;
- (void)onTimer/*:(NSTimer*)timer*/;
- (void)onTimerDraw/*:(NSTimer*)timer*/;
- (UIImage*)loadImageFromUrl:(NSString*)url;
- (NSString*)loadStringFromUrl:(NSString*)url;
- (NSString *)jsonUnescape:(NSString *)str;
- (void)debug:(NSString *)str;
- (void)setParam:(NSString *)mediaid slotId:(NSString *)slotid debugFlag:(bool)debugflag;
- (void)setViewController:(UIViewController *)ctrl_;

@end
