//
//  MusicPlayManager.m
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayManager.h"
@interface MusicPlayManager()
{
    BOOL isPlaying;
    NSInteger changColor;
}
@property (nonatomic,strong) NSTimer * time;
@end
static AVPlayer * avplayer = nil;
@implementation MusicPlayManager

+(instancetype)defaultHandel{
    static MusicPlayManager * music= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        music = [[MusicPlayManager alloc]init];
        avplayer = [[AVPlayer alloc]init];
    });
    return music;
}
#pragma mark  - 注册通知  播放结束执行
-(instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(musicPlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}
#pragma mark--设置音乐播放器
-(void)setAVplayerWithUrl:(NSURL*)url{
    AVPlayerItem * item =[[AVPlayerItem alloc]initWithURL:url];
    [avplayer replaceCurrentItemWithPlayerItem:item];
    [self playMusic];
}
#pragma mark---播放音乐
-(void)playMusic{
    self.time = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playingMusic) userInfo:nil repeats:YES];
    isPlaying = YES;
    [avplayer play];
}
#pragma mark----播放音乐中执行
-(void)playingMusic{
    CGFloat timer = avplayer.currentTime.value/avplayer.currentTime.timescale;
    if (self.delegate && [self.delegate performSelector:@selector(playingWithProgress:)]) {
        [self.delegate playingWithProgress:timer];
    }
    
}
#pragma mark---暂停音乐
-(void)pauseMusic{
    isPlaying = NO;
    [avplayer pause];
    [self.time invalidate];
    self.time = nil;
}
#pragma mark---播放结束执行
-(void)musicPlayEnd{
    if (self.delegate && [self.delegate performSelector:@selector(musicPlayEnd)]) {
        [self.delegate musicPlayEnd];
    }
    
}
#pragma mark---暂停或者播放
-(BOOL)playORpause{
    if (isPlaying) {
        [self pauseMusic];
        return NO;
    }else{
        [self playMusic];
        return YES;
    }
}
#pragma mark---从指定时间播放
-(void)playForATime:(CGFloat)time{
    [self pauseMusic];
    [avplayer seekToTime:CMTimeMakeWithSeconds(time, avplayer.currentTime.timescale) completionHandler:^(BOOL finished) {
        [self playMusic];
    }];
    
}
#pragma mark--改变音量
-(void)changSounde:(NSInteger)value{
    
    
    
}









@end
