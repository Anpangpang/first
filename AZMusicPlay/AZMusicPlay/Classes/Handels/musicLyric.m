//
//  musicLyric.m
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "musicLyric.h"
@interface musicLyric()
@property (nonatomic, strong) NSMutableArray * lyticArray;
@end
@implementation musicLyric
#pragma mark---单例
+(instancetype)defaultManager{
    static musicLyric * lyric = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lyric = [[musicLyric alloc]init];
        lyric.lyticArray = [NSMutableArray array];
    });
    return lyric;
}
#pragma mark---格式化歌词
-(void)formatLyricModelWithLyric:(NSString*)lyric{
    [self.lyticArray removeAllObjects];
    
    NSArray * conentArray = [lyric componentsSeparatedByString:@"\n"];
    for (int  i=0; i < [conentArray count]; i++) {
        NSString * sourceStr = conentArray[i];
        NSArray * lyricArray = [sourceStr componentsSeparatedByString:@"]"];
        if ([lyricArray.firstObject length]<1) {
            break;
        }
        NSString * timeStr = [lyricArray.firstObject substringFromIndex:1];
        NSArray *timeArray = [timeStr componentsSeparatedByString:@":"];
        
        CGFloat timeTotal = [timeArray.firstObject floatValue] * 60 + [timeArray.lastObject floatValue];
        
        NSString *lyricStr = lyricArray.lastObject;
        
        lyricModel *lycir = [lyricModel new];
        
        lycir.time = timeTotal;
        
        lycir.lyric = lyricStr;
        
        [self.lyticArray addObject:lycir];
    }
 
}
#pragma mark - 根据下标请求歌词
-(lyricModel*)getLyricForIndex:(NSInteger)indexpath{
    lyricModel  * lyric = _lyticArray[indexpath];
    return lyric;
}
#pragma mark - 歌词行数
-(NSInteger)lyricNumberForRow{
    return [_lyticArray count];
}
#pragma mark - 根据下标获取时间
-(CGFloat)progressAtIndex:(NSInteger)index{
    lyricModel * lyric = _lyticArray[index];
    CGFloat time = lyric.time;
    return time;
}
#pragma mark - 根据时间获取下标
-(NSInteger)progressAtTime:(CGFloat)time{
    NSInteger alltime = 0;
    for (int i=0; i<[_lyticArray count]-1;i++ ) {
        lyricModel * lyric = _lyticArray[i];
        if (lyric.time>time) {
            alltime = i-1 > 0 ? i-1 : 0;
            break;
        }
    }
    return alltime;
}


@end
