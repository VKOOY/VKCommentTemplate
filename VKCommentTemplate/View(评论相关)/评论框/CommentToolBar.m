//
//  CommentToolBar.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "CommentToolBar.h"
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define UIColorRGB(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

@interface CommentToolBar()<UITextViewDelegate,UIScrollViewDelegate>
{
    BOOL statusTextView;//当文字大于限定高度之后的状态
    NSString *placeholderText;//设置占位符的文字
}
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, assign) CGRect selfFrame;

@end


@implementation CommentToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
        self.selfFrame = frame;
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = VKColorRGBA(26, 26, 26, 1);
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.left.mas_equalTo(14);
        make.bottom.mas_equalTo(-7);
        make.width.mas_equalTo(kScreenWidth-80);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(39);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.width.mas_equalTo(50);
    }];
    
}

//暴露的方法
- (void)setPlaceholderText:(NSString *)text{
    placeholderText = text;
    self.placeholderLabel.text = placeholderText;
}


#pragma mark --- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    /**
     *  设置占位符
     */
    if (textView.text.length == 0) {
        self.placeholderLabel.text = placeholderText;
//        [self.sendButton setBackgroundColor:[UIColor colorWithHex:@"#3d3d45"]];
        self.sendButton.userInteractionEnabled = NO;
    }else{
        self.placeholderLabel.text = @"";
//        [self.sendButton setBackgroundColor:[UIColor colorWithHex:@"#3d3d45"]];
        self.sendButton.userInteractionEnabled = YES;
    }
    
    //---- 计算高度 ---- //
    CGSize size = CGSizeMake(kScreenWidth-65, CGFLOAT_MAX);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGFloat curheight = [textView.text boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:dic
                                                    context:nil].size.height;
    CGFloat y = CGRectGetMaxY(self.frame);
    if (curheight < 19.094) {
        statusTextView = NO;
        self.frame = CGRectMake(0, y - 49, kScreenWidth, 49);
    }else if(curheight < MaxTextViewHeight){
        statusTextView = NO;
        self.frame = CGRectMake(0, y - textView.contentSize.height-10, kScreenWidth,textView.contentSize.height+10);
    }else{
        statusTextView = YES;
        return;
    }
    
}

#pragma  mark -- 发送事件
- (void)sendClick:(UIButton *)sender{
    [self.textView endEditing:YES];
    if (self.EwenTextViewBlock) {
        self.EwenTextViewBlock(self.textView.text);
    }
    //---- 发送成功之后清空 ------//
    self.textView.text = nil;
    self.placeholderLabel.text = placeholderText;
    [self.sendButton setBackgroundColor:UIColorRGB(180, 180, 180)];
    self.sendButton.userInteractionEnabled = NO;
    [self.textView resignFirstResponder];
#pragma mark-- 注释了
//    self.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);

    CGFloat y = self.selfFrame.origin.y;
    self.frame = CGRectMake(0, y, kScreenWidth, 49);
}

-(void)resetTextView
{
    if (self.textView.text.length > 0) {//输入了
        self.placeholderLabel.text = @"";
        self.textView.text = nil;
        self.height = 49;
    }
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor colorWithHexString:@"#3d3d45"];
        _textView.textColor = [UIColor colorWithHexString:@"#c0c0c0"];
        _textView.layer.cornerRadius = 4;
        _textView.inputAccessoryView = [[UIView alloc] init];
//        _textView.layer.borderWidth = 1;
//        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
        [self addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.font = [UIFont systemFontOfSize:15];
        _placeholderLabel.textColor = [UIColor colorWithHexString:@"#c0c0c0"];
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [[UIButton alloc]init];
        [_sendButton setBackgroundColor:UIColorRGB(180, 180, 180)];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_sendButton setImage:[UIImage imageNamed:@"发送按钮"] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendClick:)
              forControlEvents:UIControlEventTouchUpInside];
        _sendButton.titleLabel.font = k750AdaptationFont(15);
        _sendButton.layer.cornerRadius = 5;
        _sendButton.userInteractionEnabled = NO;
        [self addSubview:_sendButton];
    }
    return _sendButton;
}

@end
