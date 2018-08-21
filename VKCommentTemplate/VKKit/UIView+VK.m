//
//  UIView+VK.m
//  VKOOY_iOS
//
//  Created by Mike on 15/8/21.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "UIView+VK.h"
#import <objc/runtime.h>

@implementation UIView (VK)

+ (instancetype)Frame:(CGRect)frame color:(UIColor*)color{
    UIView *_ = [[self alloc]initWithFrame:frame];
    _.backgroundColor = color;
    return _;
}

//origin
- (CGPoint)origin{  return self.frame.origin;}
- (void)setOrigin: (CGPoint) aPoint{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

//size
- (CGSize)je_size{     return self.frame.size;}
- (void)setJe_size: (CGSize) aSize{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

//height
- (CGFloat)height{ return CGRectGetHeight(self.frame);}
- (void)setHeight: (CGFloat) newheight{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

//width
- (CGFloat)width{  return CGRectGetWidth(self.frame);}
- (void)setWidth: (CGFloat) newwidth{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

//x
- (CGFloat) x{return CGRectGetMinX(self.frame);}
-(void)setX:(CGFloat)newleft{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

//y
- (CGFloat) y{ return CGRectGetMinY(self.frame);}
-(void)setY:(CGFloat)newtop{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (void)setMaxX:(CGFloat)maxX
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = maxX - self.width;
    self.frame = tempFrame;
}

- (CGFloat)maxX
{
    return self.x+self.width;
}

- (void)setMaxY:(CGFloat)maxY
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = maxY - self.height;
    self.frame = tempFrame;
}
- (CGFloat)maxY
{
    return self.y+self.height;
}

//bottom
- (CGFloat) bottom{ return CGRectGetMaxY(self.frame);}
- (void) setBottom: (CGFloat) newbottom{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.height;
    self.frame = newframe;
}

//right
- (CGFloat)right{ return CGRectGetMaxX(self.frame);}
- (void)setRight: (CGFloat) newright{
    CGFloat delta = newright - (self.x + self.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

#pragma mark - 设值

//边框宽
-(CGFloat)bor{ return self.layer.borderWidth;}
-(void)setBor:(CGFloat)bor{
    self.layer.borderWidth = bor;
}

//边框颜色
-(UIColor *)borCol{return [UIColor colorWithCGColor:self.layer.borderColor];}
-(void)setBorCol:(UIColor *)borCol{
    self.layer.borderColor = borCol.CGColor;
}

//倒角
-(CGFloat)rad{ return self.layer.cornerRadius;}
-(void)setRad:(CGFloat)rad{
    if(rad<=0) {rad = self.height * 0.5f;}
    self.layer.cornerRadius = rad;
    self.layer.masksToBounds = YES;
}


#pragma mark - 效果
//变圆
-(BOOL)beRound{
    [self layoutIfNeeded];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.height/2;
    return YES;
}
-(void)setBeRound:(BOOL)beRound{
    [self layoutIfNeeded];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.height/2;
}

//加阴影
-(void)addShdow{
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.height - 1, self.width == 320 ? [UIScreen mainScreen].bounds.size.width : self.width, 1)].CGPath;
}

//添加边框
-(void)border:(UIColor *)color width:(CGFloat)width;{
    if (color != nil) {
        self.layer.borderColor = color.CGColor;
    }
    self.layer.borderWidth = width;
}

//调试
-(void)je_Debug:(UIColor *)color width:(CGFloat)width{
#ifdef DEBUG
    if (color == nil) {
        [self border:[UIColor colorWithRed:(arc4random()%255)/255.0f green:(arc4random()%255)/255.0f blue:(arc4random()%255)/255.0f alpha:1] width:width];
        return;
    }
    [self border:color width:width];
#endif
}

/** 移除对应的view */
-(void)je_RemoveClassView:(Class)classV{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:classV]) {
            [view removeFromSuperview];
        }
    }
}

- (instancetype)setTag_:(NSInteger)tag{
    [self setTag:tag];
    return self;
}

- (UILabel *)labelWithTag:(NSInteger)tag{
    return [self viewWithTag:tag];
}

- (UIButton *)buttonWithTag:(NSInteger)tag{
    return [self viewWithTag:tag];
}

- (UIImageView *)ImageViewWithTag:(NSInteger)tag{
    return [self viewWithTag:tag];
}

/** cell view 根据nextResponder 获得 当前的TableView */
- (UITableView*)superTableView{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]]) {
            return (UITableView*)nextResponder;
        }
    }
    return nil;
}

/** view 根据nextResponder 获得 所在的viewcontroler */
- (UIViewController*)superVC{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

#pragma mark -

//画线
+(CAShapeLayer *)je_DrawLine:(CGPoint)points To:(CGPoint)pointe color:(UIColor*)color{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:points];
    [path addLineToPoint:pointe];
    [path closePath];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [color CGColor];
    shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth = 0.35;
    return shapeLayer;
}

//画框框线
+(CAShapeLayer *)je_drawRect:(CGRect)rect Radius:(CGFloat)redius color:(UIColor*)color{
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    UIBezierPath *solidPath =  [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:redius];
    solidLine.lineWidth = 0.35 ;
    solidLine.strokeColor = color.CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    solidLine.path = solidPath.CGPath;
    return solidLine;
}

//添加虚线
- (void)je_addSquareDottedLine:(NSArray*)lineDashPattern Radius:(CGFloat)Radius{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor lightGrayColor].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:Radius].CGPath;
    border.frame = self.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = lineDashPattern;
    [self.layer addSublayer:border];
}

#pragma mark - 手势

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

//单点击手势
- (void)tapGesture:(GestureActionBlock)block{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture){
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateRecognized){
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block){ block(gesture); }
    }
}

//长按手势
- (void)longPressGestrue:(GestureActionBlock)block{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture)  {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan){
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block){  block(gesture);}
    }
}



@end


