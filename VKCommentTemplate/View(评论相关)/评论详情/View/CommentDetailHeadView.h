//
//  CommentDetailHeadView.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageInfoModel.h"


typedef void (^TapIconBlock)(MessageInfoModel *model); //点击头像
typedef void (^TapLikeBlock)(MessageInfoModel *model); //点赞
typedef void (^TapSelfBlock)(void); //点击了自己

@interface CommentDetailHeadView : UIView

@property (nonatomic,strong)MessageInfoModel *messageModel;
@property (nonatomic,copy)TapIconBlock tapIconBlock; //点击头像
@property (nonatomic,copy)TapLikeBlock likeBlock; //点赞
@property (nonatomic,copy)TapSelfBlock tapSelfBlock; //点自己


+(instancetype)DetailView;


@end
