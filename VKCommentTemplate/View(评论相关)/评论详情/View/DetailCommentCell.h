//
//  DetailCommentCell.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentInfoModel.h"
typedef void(^DetailReplyBlock)(NSString *name);
typedef void (^DetailTapIconBlock)(CommentInfoModel *model); //点击头像

@interface DetailCommentCell : UITableViewCell

@property(nonatomic,strong)CommentInfoModel *model;

@property (nonatomic,copy)DetailReplyBlock block;
@property (nonatomic,copy)DetailTapIconBlock tapIconBlock; //点击头像

@end
