//
//  CommentHeaderView.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//
//  评论
//

#import <UIKit/UIKit.h>
#import "MessageFrameModel.h"

@protocol CommentHeaderViewDelegate <NSObject>
-(void)clickTextViewWith:(MessageFrameModel *)frameModel;
-(void)TapLikeWith:(MessageFrameModel *)model;
@end

@interface CommentHeaderView : UITableViewHeaderFooterView

@property(nonatomic,strong)MessageFrameModel *frameModel;
@property (nonatomic,weak)id<CommentHeaderViewDelegate> delegate;

@end
