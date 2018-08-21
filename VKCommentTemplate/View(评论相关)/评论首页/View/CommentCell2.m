//
//  CommentCell2.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "CommentCell2.h"

#import "YYLabel.h"
#import "Masonry.h"
@interface CommentCell2 ()
@property (nonatomic, strong) YYLabel *contentLabel;

@property (nonatomic, strong) UIView *bgColorView;

@end


@implementation CommentCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.userInteractionEnabled = YES;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _bgColorView = [[UIView alloc]init];
        _bgColorView.backgroundColor = VKColorRGBA(57, 45, 53, 0.4);

        [self.contentView addSubview:_bgColorView];
    
        
        // contentLabel
        self.contentLabel = [[YYLabel alloc] init];
        self.contentLabel.backgroundColor = [UIColor clearColor];

        self.contentLabel.preferredMaxLayoutWidth = kScreenWidth- kGAP-kAvatar_Size - 2*kGAP;
        self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.contentLabel.numberOfLines = 0;
        
        self.contentLabel.userInteractionEnabled = YES;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.displaysAsynchronously = YES;
        [_bgColorView addSubview:self.contentLabel];

//        self.contentLabel.backgroundColor = RandomColor;
        
        CGFloat space =  k750AdaptationWidth(20);
        CGFloat topSpace =  k750AdaptationWidth(15);

        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(topSpace, space, topSpace, 0));
        }];
        

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgColorView.frame = CGRectMake(0, 0, self.width, self.height);
//    _contentLabel.frame = CGRectMake(k750AdaptationWidth(20), k750AdaptationWidth(20), _bgColorView.width - k750AdaptationWidth(20), _bgColorView.height - k750AdaptationWidth(20));
}

#pragma mark
#pragma mark cell左边缩进64，右边缩进10
-(void)setFrame:(CGRect)frame{
    CGFloat leftSpace = kGAP + kAvatar_Size + k750AdaptationWidth(30);
    frame.origin.x = leftSpace;
    frame.size.width = kScreenWidth - leftSpace - k750AdaptationWidth(30);
    [super setFrame:frame];
}
-(void)setModel:(CommentInfoModel *)model
{
    NSString *str  = nil;
    
    UIColor *nameColor = [UIColor colorWithHexString:@"#CE70FF"];
    NSMutableAttributedString *text;
    
    UIColor *pressHighColor = VKColorRGBA(57, 45, 53, 0.6);;
    __weak typeof(self) weakSelf = self;
    if (![model.toNickName isEqualToString:@""]) { // XX回复XX
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
    
    CGSize onelineSize = CGSizeMake(kScreenWidth - (kGAP + kAvatar_Size + k750AdaptationWidth(30) + k750AdaptationWidth(30) + k750AdaptationWidth(20)), CGFLOAT_MAX);

    style.lineSpacing = 3.0;
    
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.string.length)];
    
    //计算文本尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:onelineSize text:text];
    self.contentLabel.attributedText = text;
    self.contentLabel.textLayout = layout;
}
@end

