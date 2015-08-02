//
//  XMGTopicCell.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/27.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGTopicPictureView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicVideoView.h"

@interface XMGTopicCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (nonatomic, weak) XMGTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (nonatomic, weak) XMGTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic, weak) XMGTopicVideoView *videoView;
@end

@implementation XMGTopicCell

- (XMGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == XMGTopicTypePicture) { // 图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == XMGTopicTypeVoice) { // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == XMGTopicTypeVideo) { // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else { // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = XMGTopicCellMargin;
    frame.size.width -= 2 * XMGTopicCellMargin;
    frame.size.height -= XMGTopicCellMargin;
    frame.origin.y += XMGTopicCellMargin;
    
    [super setFrame:frame];
}

@end
