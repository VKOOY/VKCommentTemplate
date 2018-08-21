//
//  CommentDetailVC.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/14.
//  E-mail:vkooys@163.com
//  Copyright © 2015年 VKOOY. All rights reserved.
//

#import "CommentDetailVC.h"
#import "CommentDetailHeadView.h"
#import "DetailCommentCell.h"
#import "DetailCellFrame.h"
#import "CommentToolBar.h"

@interface CommentDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *detailTab;
@property (nonatomic,strong)NSMutableArray *frameData; //装的全是detailCellFrame
@property (nonatomic,strong)CommentToolBar *commentView; //评论框
@property (nonatomic,strong)CommentInfoModel *selectModel;
@property (nonatomic,assign)BOOL isClickCell; //用来判断是回复作者还是回复cell

@end

@implementation CommentDetailVC

-(CommentToolBar *)commentView
{
    if (!_commentView) {
        _commentView = [[CommentToolBar alloc]initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
        [_commentView setPlaceholderText:@"说点什么吧"];
    }
    return _commentView;
}

-(NSMutableArray *)frameData
{
    if (!_frameData) {
        _frameData = [NSMutableArray array];
    }
    return _frameData;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.selectModel = nil;
    [self.commentView.textView resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#4B4B53"];
    
//    self.nav.backgroundColor = rgb(26, 26, 26, 1);
//    self.titleView.type = TitleViewType_title;
//    [self.titleView setTitleColor:[UIColor whiteColor]];
//    [self.titleView setTitle:@"评论详情"];
//    self.backButton.hidden = YES;
//    self.rightBtn.hidden = NO;
//    [self.rightBtn setImage:[UIImage imageNamed:@"评论详情_关闭页面"] forState:UIControlStateNormal];
    
    _detailTab = [[UITableView alloc]initWithFrame:CGRectMake(0, NavibarH, kScreenWidth, kScreenHeight - NavibarH - 49) style:UITableViewStylePlain];
    _detailTab.delegate = self;
    _detailTab.dataSource = self;
    _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTab];
    _detailTab.backgroundColor = [UIColor colorWithHexString:@"#4B4B53"];
    CommentDetailHeadView *headView = [CommentDetailHeadView DetailView];
    headView.messageModel = self.frameModel.model;
    
    __weak typeof(self) weakSelf = self;
    
    headView.tapIconBlock = ^(MessageInfoModel *model) {//点头像
        NSLog(@"详情点击了头像");
    };
    headView.likeBlock = ^(MessageInfoModel *model) {
        
        NSLog(@"点赞");

    };
    
    headView.tapSelfBlock = ^{
        weakSelf.selectModel = nil;
        weakSelf.commentView.textView.text = nil;
        [weakSelf.commentView setPlaceholderText:@"说点什么吧"];
    };
    _detailTab.tableHeaderView =headView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
    //评论框
    self.commentView.EwenTextViewBlock = ^(NSString *text){
        
        NSLog(@"EwenTextViewBlock");
        
//        if (weakSelf.isClickCell) { //回复cell
//
//        }else{ //回复主人
//
//        }
    };
    [self.view addSubview:self.commentView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.frameData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDS = @"cells";
    DetailCommentCell *cell = (DetailCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellIDS];
    if (!cell) {
        cell = [[DetailCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDS];
    }
    cell.block = ^(NSString *name) {
        NSLog(@"2====name:%@",name);
    };
    
    DetailCellFrame *detailFrame = self.frameData[indexPath.row];
    cell.model = detailFrame.commentModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCellFrame *detailFrame = self.frameData[indexPath.row];
    return detailFrame.cellHeight;
}

-(void)setFrameModel:(MessageFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    [self.frameData addObjectsFromArray:[self statusFramesWithStatuses:frameModel.model.replyList]];
}

- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (CommentInfoModel *commentModel in statuses) {
        DetailCellFrame *frame = [[DetailCellFrame alloc] init];
        frame.commentModel = commentModel;
        [frames addObject:frame];
    }
    return frames;
}

#pragma mark --table delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.isClickCell = YES;
    [self.commentView resetTextView];
    
    DetailCellFrame *detailFrame = self.frameData[indexPath.row];
    CommentInfoModel *commentModel = detailFrame.commentModel;
    
    self.selectModel = commentModel;
    [self.commentView setPlaceholderText:[NSString stringWithFormat:@"回复%@",commentModel.nickName]];
    if (![self.commentView.textView becomeFirstResponder]) {
        [self.commentView.textView becomeFirstResponder];
    }
    
}

#pragma mark - UIKeyBoardNotification

#pragma mark --键盘将要出现
- (void)keyBoardWillAppear:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.commentView.top =  kScreenHeight  - keyboardH - self.commentView.height;
    }];
}
#pragma mark --键盘将要消失
-(void)keyBoardWillDisAppear:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.commentView.top =  kScreenHeight - self.commentView.height;
    }];
}

-(void)showReplyViewWithModel:(CommentInfoModel *)commentModel
{
    self.isClickCell = YES;
    [self.commentView setPlaceholderText:[NSString stringWithFormat:@"回复%@",commentModel.nickName]];
    self.selectModel = commentModel;
    [self.commentView.textView becomeFirstResponder];
}

-(void)showReplyOwner:(NSString *)ownerName
{
    self.isClickCell = NO;
    [self.commentView setPlaceholderText:[NSString stringWithFormat:@"回复%@",ownerName]];
    [self.commentView.textView becomeFirstResponder];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hiddenTextView];
}


-(void)hiddenTextView
{
    self.isClickCell = NO;
    self.selectModel = nil;
    self.commentView.textView.text = nil;
    [self.commentView setPlaceholderText:@"说点什么吧"];
    [self.commentView.textView resignFirstResponder];
}



@end

