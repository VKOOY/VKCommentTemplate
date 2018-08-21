//
//  CommentFooterView.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "CommentFooterView.h"
@interface CommentFooterView ()
@property (nonatomic,strong)UILabel *moreBtn;
@end
@implementation CommentFooterView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];

        self.userInteractionEnabled = YES;
        _moreBtn = [[UILabel alloc]init];
        _moreBtn.userInteractionEnabled = YES;
        _moreBtn.text = @"查看更多回复 (0) >";
        _moreBtn.font = k750AdaptationFont(12);
        _moreBtn.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapMoreTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMore)];
        _moreBtn.backgroundColor = [UIColor clearColor];
        [_moreBtn addGestureRecognizer:tapMoreTap];
        
        UIView * bgColorView = [[UIView alloc]init];
        bgColorView.backgroundColor = VKColorRGBA(57, 45, 53, 0.4);;
        [self.contentView addSubview:bgColorView];
        
        [bgColorView addSubview:_moreBtn];
        [bgColorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, kGAP + kAvatar_Size + k750AdaptationWidth(30), 0,k750AdaptationWidth(30)));
        }];
        
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(bgColorView).with.insets(UIEdgeInsetsMake(0, k750AdaptationWidth(20), 0,0));
        }];
    }
    return self;
}

-(void)setModel:(MessageInfoModel *)model
{
    _model = model;
    _moreBtn.text = [NSString stringWithFormat:@"查看全部回复  (%ld) >",model.replyList.count ];
}

-(void)tapMore
{
    if (self.block) {
        self.block();
    }
}

@end
