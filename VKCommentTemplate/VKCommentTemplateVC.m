//
//  VKCommentTemplateVC.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "VKCommentTemplateVC.h"
#import "MessageInfoModel.h"
#import "CommentInfoModel.h"

@interface VKCommentTemplateVC ()

@end

@implementation VKCommentTemplateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = VKColorRGB(50, 50, 50);
    
    [self build];
}

- (void)build {
    
    NSMutableArray *modelData = [NSMutableArray array];
    for (int i = 0;i < 20;i++) {
        MessageInfoModel *messageModel = [[MessageInfoModel alloc] init];
        messageModel.userId = [NSString stringWithFormat:@"100%d",i];
        messageModel.content = @"这里是评论内容哦";
        messageModel.commentTime = @"2018-02-03";
        messageModel.praiseCount = [NSString stringWithFormat:@"%d",i];
        messageModel.nickName = [NSString stringWithFormat:@"我是昵称%d",i];
        messageModel.photo = @"vk_avatar";  //  头像图片
        messageModel.praised = @"1";
        messageModel.commentId = [NSString stringWithFormat:@"200%d",i];
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int j = 0;j < i;j++) {
            CommentInfoModel *mod = [[CommentInfoModel alloc] init];
            
            mod.replyId = [NSString stringWithFormat:@"400%d",j];
            mod.commentId = @"32265";
            mod.userId = [NSString stringWithFormat:@"300%d",j];
            mod.toUserId = [NSString stringWithFormat:@"100%d",i];
            mod.replyContent = @"我是测试小酱油，测试回复评论的哦，你猜我回复了什么？";
            mod.replyTime = @"2018-08-13";
            mod.nickName = [NSString stringWithFormat:@"一个昵称酱%d",j];
            mod.toNickName = @"昵称有点666";
            mod.toUserImageUrl = @"vk_avatar";
            mod.userImageUrl = @"vk_avatar";
            
            [arr addObject:mod];
        }
        
        messageModel.replyList = arr;
        
        [modelData addObject:messageModel];
    }
    [self.frameArr addObjectsFromArray:[self statusFramesWithStatuses:modelData]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.commentTableView reloadData];
    });
}


@end
