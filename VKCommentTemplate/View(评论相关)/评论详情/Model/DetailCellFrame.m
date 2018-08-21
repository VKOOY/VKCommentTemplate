//
//  DetailCellFrame.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "DetailCellFrame.h"

@implementation DetailCellFrame

-(void)setCommentModel:(CommentInfoModel *)commentModel
{
    _commentModel = commentModel;
    
    NSString *str  = nil;
    NSMutableAttributedString *text;
    
    if (![commentModel.toNickName isEqualToString:@""]) { // XX回复XX
        str= [NSString stringWithFormat:@"%@ 回复 %@ : %@",
              commentModel.nickName, commentModel.toNickName, commentModel.replyContent];
    }else{
        str= [NSString stringWithFormat:@"%@ 回复 : %@",
              commentModel.nickName, commentModel.replyContent];
    }
    text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str]];
    [text addAttribute:NSFontAttributeName value:Comment_SmallComment range:NSMakeRange(0, str.length)];
    
    CGFloat leftSpace = k750AdaptationWidth(30) + kAvatar_Size + kGAP;
    CGFloat rightSpace = k750AdaptationWidth(50); //多减一点 
    
    CGSize maxSize = CGSizeMake(kScreenWidth - leftSpace - rightSpace, CGFLOAT_MAX);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];

    style.lineSpacing = 3.0;
    
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.string.length)];
    
    //计算文本尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:text];
    self.cellHeight = layout.textBoundingSize.height + k750AdaptationWidth(30) + kAvatar_Size + k750AdaptationWidth(20) + k750AdaptationWidth(20);
}
@end
