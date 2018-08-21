//
//  BaseCommentVC.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "BaseCommentVC.h"
#import "CommentCell2.h"
#import "CommentFooterView.h"
#import "MessageFrameModel.h"
#import "CommentDetailVC.h"
#import "CommentHeaderView.h"
@interface BaseCommentVC ()<UITableViewDelegate,UITableViewDataSource,CommentHeaderViewDelegate,CommentDetailDelegate>
@end

@implementation BaseCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
    
    [self addTableView];
}

-(NSMutableArray *)frameArr
{
    if (!_frameArr) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}

-(void)addTableView
{
    _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight) style:UITableViewStyleGrouped];
    
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_commentTableView];
    
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentTableView.backgroundColor = [UIColor clearColor];
    
    [_commentTableView registerClass:NSClassFromString(@"CommentHeaderView") forHeaderFooterViewReuseIdentifier:@"CommentHeaderView"];
    [_commentTableView registerClass:NSClassFromString(@"CommentFooterView") forHeaderFooterViewReuseIdentifier:@"CommentFooterView"];
    [_commentTableView registerClass:NSClassFromString(@"CommentCell2") forCellReuseIdentifier:@"CommentCell2"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.frameArr.count;
}
//显示评论的数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.frameArr.count >0) {
        MessageFrameModel *frame = self.frameArr[section];
        MessageInfoModel *eachModel = frame.model;
        
        if (eachModel.replyList.count > 2) {
            return 2;
        }else{
            return eachModel.replyList.count;
        }
        return 0;
    }else
        return 0;
}

//headerView高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.frameArr.count > 0) {
        MessageFrameModel *frame = self.frameArr[section];
        return frame.selfHeight;
    }else
        return 0;
}

//返回section的headerView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.frameArr.count > 0) {
        CommentHeaderView *headerView = (CommentHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CommentHeaderView"];
        MessageFrameModel *frame = self.frameArr[section];
        headerView.frameModel = frame;
        headerView.delegate = self;
        return headerView;
    }else
        return nil;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    __weak typeof(self) weakSelf = self;
    if (self.frameArr.count >0) {
        MessageFrameModel *frame = self.frameArr[section];
        MessageInfoModel *eachModel = frame.model;
        if (eachModel.replyList.count >2) {
            CommentFooterView *footView = (CommentFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CommentFooterView"];
            footView.model = eachModel;
            footView.block = ^{
                
                CommentDetailVC *detailvc = [[CommentDetailVC alloc]init];
                detailvc.delegate = self;
                detailvc.frameModel = frame;
                [detailvc setHidesBottomBarWhenPushed:YES];
                [weakSelf.navigationController pushViewController:detailvc animated:YES];
                
            };
            return footView;
        }else
            return nil;
    }else
        return nil;
}

//footerView高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.frameArr.count >0) {
        MessageFrameModel *frame = self.frameArr[section];
        MessageInfoModel *eachModel = frame.model;
        if (eachModel.replyList.count >2) {
            return k750AdaptationWidth(60);
        }else
            return CGFLOAT_MIN;
    }else
        return CGFLOAT_MIN;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.frameArr.count >0) {
        CommentCell2 *cell2 = (CommentCell2 *)[tableView dequeueReusableCellWithIdentifier:@"CommentCell2"];
        MessageFrameModel *frame = self.frameArr[indexPath.section];
        CommentInfoModel  *commentModel =  frame.model.replyList[indexPath.row];
        cell2.model = commentModel;
        cell2.block = ^(NSString *name) {
            NSLog(@"1====name:%@",name);
        };
        return cell2;
    }else
        return [[UITableViewCell alloc]init];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    if (self.frameArr.count >0) {
        MessageFrameModel *frame = self.frameArr[indexPath.section];
        MessageInfoModel *eachModel = frame.model;
        CommentDetailVC *detailvc = [[CommentDetailVC alloc]init];
        detailvc.delegate = self;
        detailvc.frameModel = frame;
//            detailvc.playingModel = self.currentModel;
        [detailvc showReplyViewWithModel:eachModel.replyList[indexPath.row]];
        [detailvc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:detailvc animated:YES];
    }else{
        NSLog(@"数据为空");
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.frameArr.count >0) {
        MessageFrameModel *frame = self.frameArr[indexPath.section];
        YYTextLayout *layout = frame.cellFrmaes[indexPath.row];
        return layout.textBoundingSize.height + k750AdaptationWidth(30);
    }else
        return 0;
}

#pragma mark --
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (MessageInfoModel *messageModel in statuses) {
        MessageFrameModel *frame = [[MessageFrameModel alloc] init];
        frame.model = messageModel;
        [frames addObject:frame];
    }
    return frames;
}


#pragma mark -- CommentHeaderViewDelegate 点击头的代理 回复主人
-(void)clickTextViewWith:(MessageFrameModel *)frameModel
{
    NSLog(@"======点击头的代理 回复主人");
    
    CommentDetailVC *detailvc = [[CommentDetailVC alloc]init];
    detailvc.delegate = self;
    detailvc.frameModel = frameModel;
    [detailvc showReplyOwner:frameModel.model.nickName]; //点击了头部
    [detailvc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailvc animated:YES];

}

#pragma mark --点赞了
-(void)TapLikeWith:(MessageFrameModel *)model
{
    NSLog(@"======点赞了");
}

#pragma mark --CommentDetailDelegate
-(void)sendCommentSuccess
{
    [self sendSuccessReloadData];
}
-(void)sendSuccessReloadData
{
    
}


#pragma mark --键盘将要出现
- (void)keyBoardWillAppear:(NSNotification *)note
{
}
#pragma mark --键盘将要消失
-(void)keyBoardWillDisAppear:(NSNotification *)notification
{

}

@end
