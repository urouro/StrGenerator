#import <UIKit/UIKit.h>

/**
 *  @brief  タップアクションを伴う
 */
@interface TouchLabel : UILabel

@property(nonatomic,assign) id delegate;

@end

@interface NSObject (TouchLabelDelegate)

/**
 *  @brief  タッチ開始
 *
 *  @param  label   TouchLabelの参照
 *  @param  point   タッチ座標
 */
- (void)touchLabelTouchesDidBegan:(TouchLabel *)label point:(CGPoint)point;

/**
 *  @brief  タッチ終了
 *
 *  @param  label   TouchLabelの参照
 *  @param  point   タッチ座標
 */
- (void)touchLabelTouchesDidEnded:(TouchLabel *)label point:(CGPoint)point;

- (void)touchLabelTouchesDidCanceled:(TouchLabel *)label point:(CGPoint)point;

@end