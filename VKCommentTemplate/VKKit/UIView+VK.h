//
//  UIView+VK.h
//  VKOOY_iOS
//
//  Created by Mike on 15/8/21.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VK)

+ (instancetype)Frame:(CGRect)frame color:(UIColor*)color;/**< UIView */

@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize je_size;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat centerX;

@property (nonatomic,assign) IBInspectable CGFloat   bor;    /**< 边框宽 */
@property (nonatomic,strong) IBInspectable UIColor  *borCol; /**< 边框颜色 */
@property (nonatomic,assign) IBInspectable CGFloat rad;/**< 倒角 */
@property (nonatomic,assign) IBInspectable BOOL beRound;/**< 变圆 */

- (void)addShdow;/**< 加阴影 */
-(void)border:(UIColor *)color width:(CGFloat)width;/**< 添加边框 */
-(void)je_Debug:(UIColor *)color width:(CGFloat)width;/**< Debug添加边框 */
-(void)je_RemoveClassView:(Class)classV;/**< 移除对应的view */

- (instancetype)setTag_:(NSInteger)tag;/**< setTag & return self */
- (UILabel *)labelWithTag:(NSInteger)tag;/**< viewWithTag */
- (UIButton *)buttonWithTag:(NSInteger)tag;/**< viewWithTag */
- (UIImageView *)ImageViewWithTag:(NSInteger)tag;/**< viewWithTag */

@property (nonatomic,strong,readonly) UITableView *superTableView;/**< cell view 根据nextResponder 获得 当前的TableView */
@property (nonatomic,strong,readonly) UIViewController *superVC;/**< view 根据nextResponder 获得 所在的viewcontroler */

+(CAShapeLayer *)je_DrawLine:(CGPoint)points To:(CGPoint)pointe color:(UIColor*)color;/**< 画线 */
+(CAShapeLayer *)je_drawRect:(CGRect)rect Radius:(CGFloat)redius color:(UIColor*)color;/**< 画框框线 */
- (void)je_addSquareDottedLine:(NSArray*)lineDashPattern Radius:(CGFloat)Radius;/**< 添加虚线 */

#pragma mark - 手势

typedef void (^GestureActionBlock)(UIGestureRecognizer *Ges);
- (void)tapGesture:(GestureActionBlock)block;/**< 单点击手势 */
- (void)longPressGestrue:(GestureActionBlock)block;/**< 长按手势 */

@end




