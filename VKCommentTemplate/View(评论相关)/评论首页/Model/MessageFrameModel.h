//
//  MessageFrameModel.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageInfoModel.h"
@interface MessageFrameModel : NSObject

@property (nonatomic,assign)CGRect  iconFrame; //图片frame
@property (nonatomic,assign)CGRect  nameFrame; //评论人名字frame
@property (nonatomic,assign)CGRect  timeFrame; //时间frame
@property (nonatomic,assign)CGRect  bigCommentFrame; //大评论frame
@property (nonatomic,assign)CGRect  lickBtnFrame; //点赞的frame

@property (nonatomic,strong)NSMutableAttributedString  *bigCommentAttrString; //大评论attrString
@property (nonatomic,strong)YYTextLayout  *textLayout; //大评论layout

@property (nonatomic,assign)CGFloat  selfHeight; //自己（头）的高度 header的高度
@property (nonatomic,strong)NSMutableArray<YYTextLayout *>  *cellFrmaes; //当前评论对应下所有子评论的frame模型数据
@property (nonatomic,strong)MessageInfoModel *model;

@end
