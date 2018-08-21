//
//  CommentFooterView.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//
// 查看更多
//

#import <UIKit/UIKit.h>
#import "MessageInfoModel.h"
typedef void (^TapMoreBlock)(void);

@interface CommentFooterView : UITableViewHeaderFooterView

@property (nonatomic,copy)TapMoreBlock block;
@property (nonatomic,strong)MessageInfoModel *model;

@end
