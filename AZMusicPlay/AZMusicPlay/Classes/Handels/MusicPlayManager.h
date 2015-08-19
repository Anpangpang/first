//
//  MusicPlayManager.h
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MusicPlayDelegate<NSObject>
-(void)playingWithProgress:(CGFloat)progress;
-(void)musicPlayEnd;
@end

@interface MusicPlayManager : NSObject
@property (nonatomic,weak)id<MusicPlayDelegate>delegate;
+(instancetype)defaultHandel;
-(void)setAVplayerWithUrl:(NSURL*)url;
-(void)pauseMusic;
-(BOOL)playORpause;
-(void)playForATime:(CGFloat)time;
@end
