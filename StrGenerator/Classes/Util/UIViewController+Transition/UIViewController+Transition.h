#import <UIKit/UIKit.h>

/**
 *  @brief  遷移アニメーション
 *
 *  UIViewControllerにトランジションを追加
 *  (UIViewController).navigationController pushViewController:での遷移を
 *  実装している場合に限る
 *
 *  @code
 *  ViewController *controller = [[[ViewController alloc] init] autorelease];
 *  [self transitionToController:controller];
 *  @endcode
 */
@interface UIViewController (Transition)

/**
 *  @brief  クラス名を指定して遷移
 *
 *  渡されたクラス名からクラスを生成し、pushViewControllerする
 *  @param  className   遷移先UIViewControllerのクラス名
 */
- (void)transitionWithClassName:(NSString *)className;

/**
 *  @brief  クラス名を指定して遷移
 *
 *  @param  className   遷移先UIViewControllerのクラス名
 *  @param  animated    遷移スライドアニメーションの有無
 */
- (void)transitionWithClassName:(NSString *)className animated:(BOOL)animated;

/**
 *  @brief  通常の遷移
 *
 *  渡されたクラスをpushViewControllerする
 *  @param  controller  遷移先UIViewController
 */
- (void)transitionToController:(id)controller;

/**
 *  @brief  通常の遷移
 *
 *  @param  controller  遷移先UIViewController
 *  @param  animated    遷移スライドアニメーションの有無
 */
- (void)transitionToController:(id)controller animated:(BOOL)animated;

/**
 *  @brief  左から右へスライド
 *
 *  @param  controller  遷移先UIViewController
 */
- (void)transitionFromRightToController:(UIViewController *)controller;

/**
 *  @brief  フェードアウト・フェードイン
 *
 *  @param  controller  遷移先UIViewController
 */
- (void)fadeToController:(UIViewController *)controller;

/**
 *  @brief  フェードアウト・フェードイン
 *
 *  @param  controller  遷移先UIViewController
 *  @param  duration    フェード時間(フェードアウト〜フェードインの合計時間)
 */
- (void)fadeToController:(UIViewController *)controller fadeDuration:(float)duration;

@end

@interface NSObject (UIViewControllerTransitionDelegate)
@end

