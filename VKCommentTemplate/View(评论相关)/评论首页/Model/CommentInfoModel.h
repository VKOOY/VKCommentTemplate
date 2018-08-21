//
//  CommentInfoModel.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommentInfoModel : NSObject

@property(nonatomic,copy)NSString *replyId;
@property(nonatomic,copy)NSString *commentId;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *toUserId;
@property(nonatomic,copy)NSString *replyContent;
@property(nonatomic,copy)NSString *replyTime;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *toNickName;

@property(nonatomic,copy)NSString *toUserImageUrl;
@property(nonatomic,copy)NSString *userImageUrl; 


@property(nonatomic,copy)NSAttributedString *attributedText;



@end
