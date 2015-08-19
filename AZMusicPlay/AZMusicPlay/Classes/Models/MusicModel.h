//
//  MusicModel.h
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject
@property (strong, nonatomic)NSString * mp3Url;//mp3地址
@property (strong, nonatomic)NSString * ID;//id
@property (strong, nonatomic)NSString * name;//音乐名
@property (strong, nonatomic)NSString * picUrl;//图片地址
@property (strong, nonatomic)NSString * blurPicUrl;//模糊图片
@property (strong, nonatomic)NSString * album;//专辑
@property (strong, nonatomic)NSString * singer;//歌手
@property (strong, nonatomic)NSString * duration;//时间
@property (strong, nonatomic)NSString * artists_name;
@property (strong, nonatomic)NSString * lyric;//歌词
@property (assign, nonatomic) NSInteger musicIndex;//下标
@end
