//
//  CommentDetailHeadView.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "CommentDetailHeadView.h"

@interface CommentDetailHeadView()
@property(nonatomic,strong)UIImageView *avatarIV; //头像
@property(nonatomic,strong)UILabel *userNameLabel; //昵称
@property(nonatomic,strong)UILabel *timeLable; //时间
@property(nonatomic,strong)YYLabel *messageTextLabel; //发布的内容
@property (nonatomic,strong)UIButton *likeBtn;//点赞

@property (nonatomic,strong)UIImageView *line;
@property (nonatomic,strong)UILabel *commnetsNumber;//回复(123)


@end
@implementation CommentDetailHeadView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#4B4B53"];
        //头像
        self.avatarIV = [[UIImageView alloc]initWithFrame:CGRectMake(k750AdaptationWidth(30), k750AdaptationWidth(30), kAvatar_Size, kAvatar_Size)];
        self.avatarIV.layer.cornerRadius = kAvatar_Size/2;
        self.avatarIV.layer.masksToBounds = YES;
        [self addSubview:self.avatarIV];
        
        UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIcons:)];
        self.avatarIV.userInteractionEnabled = YES;
        [self.avatarIV addGestureRecognizer:tapIcon];

        //昵称
        self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarIV.frame)+kGAP, k750AdaptationWidth(30), 200, Comment_name_H)];
        self.userNameLabel.font = Comment_nameFont;
        self.userNameLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.userNameLabel];
        
        
        _likeBtn = [[UIButton alloc]init];
        [_likeBtn setImage:[UIImage imageNamed:@"vk_comment_like"] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = k750AdaptationFont(12);
        [self addSubview:_likeBtn];
        [_likeBtn addTarget:self action:@selector(clickLike:) forControlEvents:UIControlEventTouchUpInside];
//        [_likeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:4];
        _likeBtn.frame = CGRectMake(kScreenWidth - k750AdaptationWidth(100) - k750AdaptationWidth(30), k750AdaptationWidth(30), k750AdaptationWidth(100), kAvatar_Size);
        
        //发布的评论
        self.messageTextLabel = [[YYLabel alloc]init];
        self.messageTextLabel.numberOfLines = 0;
        self.messageTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.messageTextLabel.font = Comment_BigComment;
        [self addSubview:self.messageTextLabel];
        
        //时间
        self.timeLable = [[UILabel alloc]init];
        self.timeLable.textColor = [UIColor whiteColor];
        self.timeLable.font = Comment_TimeFont;
        [self addSubview:self.timeLable];
        self.timeLable.text = @"11-20 18：23";

        self.timeLable.frame = CGRectMake(CGRectGetMaxX(self.avatarIV.frame)+kGAP, CGRectGetMaxY(self.userNameLabel.frame), 200, Comment_time_H);
        
        
        _line = [[UIImageView alloc]init];
        _line.backgroundColor = VKColorRGBA(255, 255, 255, 0.2);
        [self addSubview:_line];
        
        
        self.commnetsNumber = [[UILabel alloc]init];
        self.commnetsNumber.textColor = [UIColor whiteColor];
        self.commnetsNumber.font = k750AdaptationBoldFont(16);
        [self addSubview:self.commnetsNumber];
        
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapSelf = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)];
        [self addGestureRecognizer:tapSelf];
    }
    return self;
}
-(void)tapIcons:(UITapGestureRecognizer *)tap
{
    if (self.tapIconBlock) {
        self.tapIconBlock(self.messageModel);
    }
}

-(void)tapSelf
{
    if (self.tapSelfBlock) {
        self.tapSelfBlock();
    }
}

-(void)clickLike:(UIButton *)btn
{
    if (self.likeBlock) {
        self.likeBlock(self.messageModel);
    }
}


-(void)setMessageModel:(MessageInfoModel *)messageModel
{
    _messageModel = messageModel;
    
    [self.avatarIV setImage:[UIImage imageNamed:messageModel.photo]];
    
    self.userNameLabel.text = messageModel.nickName;
    
    
    //大评论的frame
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    UIFont *font = Comment_BigComment;
    muStyle.alignment = NSTextAlignmentLeft;//对齐方式
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:messageModel.content];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attrString.length)];
    
    CGFloat maxW = kScreenWidth - ( k750AdaptationWidth(30) + kGAP + kAvatar_Size + k750AdaptationWidth(40));
    
    CGSize maxSize = CGSizeMake(maxW, CGFLOAT_MAX);

    muStyle.lineSpacing = 3.0;
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:attrString];
    CGFloat introHeight = layout.textBoundingSize.height;
    
    CGFloat space = k750AdaptationWidth(25);
    self.messageTextLabel.attributedText = attrString;
    self.messageTextLabel.frame = CGRectMake(k750AdaptationWidth(30) + kGAP + kAvatar_Size,CGRectGetMaxY(self.avatarIV.frame) + space, maxW, introHeight);
    self.messageTextLabel.textLayout = layout;
    self.timeLable.text = messageModel.commentTime;
    
    [self.likeBtn setTitle:messageModel.praiseCount forState:UIControlStateNormal];

    if ([messageModel.praised isEqualToString:@"0"]) { //未点赞
        [_likeBtn setImage:[UIImage imageNamed:@"vk_comment_like"] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{ //已点赞
        [_likeBtn setImage:[UIImage imageNamed:@"vk_comment_like_selected"] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.messageTextLabel.frame) + space, kScreenWidth, k750AdaptationWidth(1));

    self.commnetsNumber.frame = CGRectMake(k750AdaptationWidth(30), self.line.bottom , 100, k750AdaptationWidth(100));
    
    if (messageModel.replyList.count >0) {
        self.commnetsNumber.text = [NSString stringWithFormat:@"回复（%ld）",messageModel.replyList.count];
    }else{
        self.commnetsNumber.text = @"暂无评论";
    }
    
    self.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(self.commnetsNumber.frame));
}


+(instancetype)DetailView
{
    return [[CommentDetailHeadView alloc]init];
}

@end
