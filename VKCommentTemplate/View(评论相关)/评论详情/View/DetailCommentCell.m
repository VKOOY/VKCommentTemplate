//
//  DetailCommentCell.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "DetailCommentCell.h"
#import "YYLabel.h"

@interface DetailCommentCell ()
@property (nonatomic, strong) YYLabel *contentLabel;
@property(nonatomic,strong)UIImageView *avatarIV; //头像
@property(nonatomic,strong)UILabel *userNameLabel; //昵称
@property(nonatomic,strong)UILabel *timeLable; //时间
@property (nonatomic,strong)UIImageView *line;

@end
@implementation DetailCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#4B4B53"];

        
        self.userInteractionEnabled = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        //头像
        self.avatarIV = [[UIImageView alloc]initWithFrame:CGRectMake(k750AdaptationWidth(30), k750AdaptationWidth(30), kAvatar_Size, kAvatar_Size)];
        self.avatarIV.layer.cornerRadius = kAvatar_Size/2;
        self.avatarIV.layer.masksToBounds = YES;
        [self.contentView addSubview:self.avatarIV];

        UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIcons:)];
        self.avatarIV.userInteractionEnabled = YES;
        [self.avatarIV addGestureRecognizer:tapIcon];

        //昵称
        self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarIV.frame)+kGAP, k750AdaptationWidth(30), 200, Comment_name_H)];
        self.userNameLabel.font = Comment_nameFont;
        self.userNameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.userNameLabel];

        //时间
        self.timeLable = [[UILabel alloc]init];
        self.timeLable.textColor = [UIColor whiteColor];
        self.timeLable.font = Comment_TimeFont;
        [self.contentView addSubview:self.timeLable];
        self.timeLable.text = @"11-20 18：23";

        self.timeLable.frame = CGRectMake(CGRectGetMaxX(self.avatarIV.frame)+kGAP, CGRectGetMaxY(self.userNameLabel.frame), 200, Comment_time_H);

        _line = [[UIImageView alloc]init];
        _line.backgroundColor = VKColorRGBA(255, 255, 255, 0.2);
        [self.contentView addSubview:_line];


        self.contentLabel = [[YYLabel alloc] init];
        self.contentLabel.preferredMaxLayoutWidth = kScreenWidth - 2*kGAP;
        self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.userInteractionEnabled = YES;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.displaysAsynchronously = YES;
        [self addSubview:self.contentLabel];

        CGFloat topSpace = k750AdaptationWidth(30) + kAvatar_Size + k750AdaptationWidth(20);
        CGFloat leftSpace = k750AdaptationWidth(30) + kAvatar_Size + kGAP;
        CGFloat rightSpace = k750AdaptationWidth(50);
        CGFloat bottomSpace = k750AdaptationWidth(20);

        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(topSpace, leftSpace, bottomSpace, rightSpace));
        }];
    }
    return self;
}

-(void)setModel:(CommentInfoModel *)model
{
    NSString *str  = nil;
    
    UIColor *nameColor = [UIColor colorWithHexString:@"#CE70FF"];
    NSMutableAttributedString *text;
    
    UIColor *pressHighColor = VKColorRGBA(57, 45, 53, 0.6);;
    __weak typeof(self) weakSelf = self;
    if (![model.nickName isEqualToString:@""]) { // XX回复XX
        str= [NSString stringWithFormat:@"%@ 回复 %@ : %@",
              model.nickName, model.toNickName, model.replyContent];
        text = [[NSMutableAttributedString alloc] initWithString:str];
        [text addAttribute:NSForegroundColorAttributeName //评论者变色
                     value:nameColor
                     range:NSMakeRange(0, model.nickName.length)];
        
 
        [text setTextHighlightRange:NSMakeRange(0, model.nickName.length ) //评论者可点击
                                 color:nameColor
                       backgroundColor:pressHighColor
                             tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                 if (weakSelf.block) {
                                     weakSelf.block([text.string substringWithRange:NSMakeRange(0, model.nickName.length)]);
                                 }
                             }];
        
        [text addAttribute:NSForegroundColorAttributeName //回复俩字变色
                     value:[UIColor whiteColor]
                     range:NSMakeRange(model.nickName.length + 1, 2)];
        
        
        NSRange repeatNameRange = NSMakeRange(model.nickName.length + 1 + 1 +2, model.toNickName.length );
        [text addAttribute:NSForegroundColorAttributeName //回复XX XX变色
                     value:nameColor
                     range:repeatNameRange];
        
        [text setTextHighlightRange:repeatNameRange //回复XX XX可点击
                                 color:nameColor
                       backgroundColor:pressHighColor
                             tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                 if (weakSelf.block) {
                                     weakSelf.block([str substringWithRange:repeatNameRange]);
                                 }
                             }];
        
        
        CGFloat totalLength = model.nickName.length + 1 + 1 + 2 + model.toNickName.length + 1;
        NSRange normRange = NSMakeRange(totalLength, text.length - totalLength);
        [text addAttribute:NSForegroundColorAttributeName //具体内容变色
                     value:[UIColor whiteColor]
                     range:normRange];
    }else{
        str= [NSString stringWithFormat:@"%@ 回复 : %@",
              model.nickName, model.replyContent];
        
        text = [[NSMutableAttributedString alloc] initWithString:str];
        [text addAttribute:NSForegroundColorAttributeName
                     value:nameColor
                     range:NSMakeRange(0, model.nickName.length)];
        
        [text addAttribute:NSForegroundColorAttributeName
                     value:[UIColor whiteColor]
                     range:NSMakeRange(model.nickName.length + 1, text.length - (model.nickName.length + 1))];
        
        
        [text setTextHighlightRange:NSMakeRange(0, model.nickName.length) //评论者可点击
                                 color:nameColor
                       backgroundColor:pressHighColor
                             tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                 if (weakSelf.block) {
                                     weakSelf.block([str substringWithRange:NSMakeRange(0, model.nickName.length)]);
                                 }
                             }];
    }
    
    
    
    [text addAttribute:NSFontAttributeName value:Comment_SmallComment range:NSMakeRange(0, str.length)];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    CGFloat leftSpace = k750AdaptationWidth(30) + kAvatar_Size + kGAP;
    CGFloat rightSpace = k750AdaptationWidth(50);
    
    CGSize maxSize = CGSizeMake(kScreenWidth - leftSpace - rightSpace, CGFLOAT_MAX);

    
//    if ([text.string isMoreThanOneLineWithSize:maxSize font:Comment_SmallComment lineSpaceing:5.0]) {//margin
//        style.lineSpacing = 5.0;
//    }else{
//        style.lineSpacing = CGFLOAT_MIN;
//    }
    style.lineSpacing = 3.0;
    
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.string.length)];
    
    //计算文本尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:text];
    self.contentLabel.attributedText = text;
    self.contentLabel.textLayout = layout;

    [self.avatarIV setImage:[UIImage imageNamed:model.userImageUrl]];
    
    self.timeLable.text = model.replyTime;
    self.userNameLabel.text = model.nickName;
}

-(void)tapIcons:(UITapGestureRecognizer *)tap
{
    if (self.tapIconBlock) {
        self.tapIconBlock(self.model);
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftSpace = k750AdaptationWidth(30) + kAvatar_Size + kGAP;
    CGFloat rightSpace = k750AdaptationWidth(50);
    CGFloat width = kScreenWidth - (leftSpace + rightSpace);
    _line.frame = CGRectMake(leftSpace, self.height - k750AdaptationWidth(1), width, k750AdaptationWidth(1));
}
@end
