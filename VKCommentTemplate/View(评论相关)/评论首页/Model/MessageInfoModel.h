//
//  MessageInfoModel.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentInfoModel.h"

@interface MessageInfoModel : NSObject

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *commentTime;
@property(nonatomic,copy)NSString *praiseCount;//点赞数
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *photo;
@property(nonatomic,strong)NSArray<CommentInfoModel *> *replyList;
@property(nonatomic,copy)NSString *praised; //是否点赞
@property(nonatomic,copy)NSString *commentId;

@end
