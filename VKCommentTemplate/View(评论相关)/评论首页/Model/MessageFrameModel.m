//
//  MessageFrameModel.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "MessageFrameModel.h"
@implementation MessageFrameModel

-(NSMutableArray<YYTextLayout *> *)cellFrmaes
{
    if (!_cellFrmaes) {
        _cellFrmaes = [NSMutableArray array];
    }
    return _cellFrmaes;
}
-(void)setModel:(MessageInfoModel *)model
{
    _model = model;
    
    //icon
    self.iconFrame = CGRectMake(k750AdaptationWidth(30), k750AdaptationWidth(30), kAvatar_Size, kAvatar_Size);
    
    //名称
    self.nameFrame = CGRectMake(CGRectGetMaxX(self.iconFrame)+kGAP, k750AdaptationWidth(30),kScreenWidth-kAvatar_Size-2*kGAP-kGAP, 20);
    
    //点赞
    self.lickBtnFrame = CGRectMake(kScreenWidth - k750AdaptationWidth(100) - k750AdaptationWidth(30), k750AdaptationWidth(30), k750AdaptationWidth(100), kAvatar_Size);
                                 
    //时间
                            
//    CGSize timeSize = [NSString getSizeFromString:model.commentTime withMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:Comment_TimeFont];
//    self.timeFrame = CGRectMake(CGRectGetMaxX(self.iconFrame)+kGAP, CGRectGetMaxY(self.nameFrame), timeSize.width, Comment_time_H);
    self.timeFrame = CGRectMake(CGRectGetMaxX(self.iconFrame)+kGAP, CGRectGetMaxY(self.nameFrame), 100, 20);
    
    //大评论的frame
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    UIFont *font = [UIFont systemFontOfSize:14];
    muStyle.alignment = NSTextAlignmentLeft;//对齐方式
    
    if (model.content == nil) {
        model.content = @"";
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:model.content];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, attrString.length)];
    
    [attrString addAttribute:NSForegroundColorAttributeName //评论者变色
                 value:[UIColor whiteColor]
                 range:NSMakeRange(0, attrString.length)];

    muStyle.lineSpacing = 3.0;
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kScreenWidth-kGAP-kAvatar_Size-2*kGAP, CGFLOAT_MAX) text:attrString];
    CGFloat introHeight = layout.textBoundingSize.height;
    self.bigCommentFrame = CGRectMake(kGAP+kAvatar_Size+kGAP,CGRectGetMaxY(self.timeFrame) + kGAP, kScreenWidth - 2 * kGAP-kAvatar_Size-kGAP, introHeight); //这个是评大评论的高度
    self.bigCommentAttrString = attrString;
    self.textLayout = layout;
    
    //自己的frame
    self.selfHeight = CGRectGetMaxY(self.bigCommentFrame) + kGAP;
    
    //cell的高度
    for (CommentInfoModel *commentModel in model.replyList) {
        NSString *str  = nil;
        NSMutableAttributedString *text;
        
        if (![commentModel.nickName isEqualToString:@""]) { // XX回复XX
            str= [NSString stringWithFormat:@"%@ 回复 %@ : %@",
                  commentModel.nickName, commentModel.toNickName, commentModel.replyContent];
        }else{
            str= [NSString stringWithFormat:@"%@ 回复 : %@",
                  commentModel.nickName, commentModel.replyContent];
        }
        text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"空格%@",str]];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        CGSize maxSize = CGSizeMake(kScreenWidth - 2*kGAP-kAvatar_Size-10, CGFLOAT_MAX);

        style.lineSpacing = 3.0;
        
        [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.string.length)];
        
        //计算文本尺寸
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:text];
        [self.cellFrmaes addObject:layout];
    }
}


@end
