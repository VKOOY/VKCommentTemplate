//
//  CommentCell2.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//
//  对评论回复
//

#import <UIKit/UIKit.h>
#import "CommentInfoModel.h"

typedef void(^ReplayBlock)(NSString *name);

@interface CommentCell2 : UITableViewCell
@property(nonatomic,strong)CommentInfoModel *model;

@property (nonatomic,copy)ReplayBlock block;

@end
