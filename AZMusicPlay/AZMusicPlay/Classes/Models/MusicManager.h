//
//  MusicManager.h
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicManager : NSObject

+(instancetype)shareInstance;
- (void)requestAllData:(void(^)(NSMutableArray * array))result;
- (MusicModel*)getMusicModelForIndex:(NSInteger)indexPath;
-(NSUInteger)countOfAllModelArray;
@end
