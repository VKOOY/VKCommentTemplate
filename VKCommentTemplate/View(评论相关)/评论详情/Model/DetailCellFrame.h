//
//  DetailCellFrame.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommentInfoModel.h"
@interface DetailCellFrame : NSObject

@property (nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,strong)CommentInfoModel *commentModel;
@end
