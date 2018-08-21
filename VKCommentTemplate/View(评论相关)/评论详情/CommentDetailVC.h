//
//  CommentDetailVC.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "BaseCommentVC.h"
#import "MessageFrameModel.h"

@protocol CommentDetailDelegate <NSObject>
-(void)sendCommentSuccess; //发送评论成功 刷新评论页面的cell
@end
@interface CommentDetailVC : BaseCommentVC

@property (nonatomic,strong)MessageFrameModel *frameModel;

@property (nonatomic,weak)id<CommentDetailDelegate> delegate;

-(void)showReplyViewWithModel:(CommentInfoModel *)commentModel;
-(void)showReplyOwner:(NSString *)ownerName;
@end

