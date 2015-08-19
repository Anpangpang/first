//
//  musicLyric.h
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface musicLyric : NSObject
-(void)formatLyricModelWithLyric:(NSString*)lyric;
+(instancetype)defaultManager;
-(lyricModel*)getLyricForIndex:(NSInteger)indexpath;
-(NSInteger)lyricNumberForRow;
-(NSInteger)progressAtTime:(CGFloat)time;
-(CGFloat)progressAtIndex:(NSInteger)index;
@end
