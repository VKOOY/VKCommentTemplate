//
//  CommentHeaderView.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "CommentHeaderView.h"

@interface CommentHeaderView (){

}
@property(nonatomic,strong)UIImageView *avatarIV; //头像
@property(nonatomic,strong)UILabel *userNameLabel; //昵称
@property(nonatomic,strong)UILabel *timeLable; //时间
@property(nonatomic,strong)YYLabel *messageTextLabel; //发布的内容
@property(nonatomic,strong)UIButton *likeBtn; //点赞

@end

@implementation CommentHeaderView

/**
 *  self
 *
 *  @param reuseIdentifier 复用标示。一定要用这个初始化方法，HeaderView才会复用
 *
 */
- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        //头像
        self.avatarIV = [[UIImageView alloc]init];
        self.avatarIV.layer.cornerRadius = kAvatar_Size/2;
        self.avatarIV.layer.masksToBounds = YES;
        [self addSubview:self.avatarIV];
        
        
        UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIcons:)];
        self.avatarIV.userInteractionEnabled = YES;
        [self.avatarIV addGestureRecognizer:tapIcon];
        //昵称
        self.userNameLabel = [[UILabel alloc]init];
        self.userNameLabel.font = [UIFont systemFontOfSize:14];

        self.userNameLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.userNameLabel];
        
        
        //时间
        self.timeLable = [[UILabel alloc]init];
        self.timeLable.textColor = [UIColor whiteColor];
        self.timeLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.timeLable];
        
        
        //发布的评论
        self.messageTextLabel = [[YYLabel alloc]init];
        self.messageTextLabel.numberOfLines = 0;
        self.messageTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.messageTextLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.messageTextLabel];

        
        _likeBtn = [[UIButton alloc]init];
        [_likeBtn setImage:[UIImage imageNamed:@"vk_comment_like"] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = k750AdaptationFont(12);
        [self addSubview:_likeBtn];
        [_likeBtn addTarget:self action:@selector(clickLike:) forControlEvents:UIControlEventTouchUpInside];
//        [_likeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:4];
        
        UITapGestureRecognizer *tapSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMessage:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapSelf];
        
    }
    return self;
}

-(void)setFrameModel:(MessageFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    MessageInfoModel *messageModel = frameModel.model;
    
    [self.avatarIV setImage:[UIImage imageNamed:messageModel.photo]];
    
    self.avatarIV.frame = frameModel.iconFrame;
    
    self.userNameLabel.text = messageModel.nickName;
    self.userNameLabel.frame = frameModel.nameFrame;
    
    self.timeLable.text = messageModel.commentTime;
    self.timeLable.frame = frameModel.timeFrame;
    
    self.messageTextLabel.attributedText = frameModel.bigCommentAttrString;
    self.messageTextLabel.frame = frameModel.bigCommentFrame;
    self.messageTextLabel.textLayout = frameModel.textLayout;
    
    self.likeBtn.frame = frameModel.lickBtnFrame;
    [self.likeBtn setTitle:messageModel.praiseCount forState:UIControlStateNormal];
    
    if ([messageModel.praised isEqualToString:@"0"]) { //未点赞
        [_likeBtn setImage:[UIImage imageNamed:@"vk_comment_like"] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{ //已点赞
        [_likeBtn setImage:[UIImage imageNamed:@"vk_comment_like_selected"] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

-(void)tapIcons:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击了头像");
    
//    if (self.block) {
//        self.block();
//    }
}

-(void)clickLike:(UIButton *)btn
{
//    if (self.likeBlock) {
//        self.likeBlock(self.frameModel);
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(TapLikeWith:)]) {
        [self.delegate TapLikeWith:self.frameModel];
    }
}

-(void)tapMessage:(UITapGestureRecognizer *)tap
{
//    if (self.textViewBlock) {
//        self.textViewBlock(self.frameModel);
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTextViewWith:)]) {
        [self.delegate clickTextViewWith:self.frameModel];
    }
}

@end
