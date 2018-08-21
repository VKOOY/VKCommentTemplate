//
//  BaseCommentVC.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

@interface BaseCommentVC : UIViewController

@property (strong, nonatomic)UITableView *commentTableView;
@property (nonatomic,strong)NSMutableArray *frameArr;

- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses;//根据数据模型 生成frame模型
-(void)sendSuccessReloadData;//发送评论成功

@end
