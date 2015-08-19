//
//  MusicManager.m
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicManager.h"
@interface MusicManager()
{
    
}
@property (nonatomic,strong)NSMutableArray * allModelArray;

@end
@implementation MusicManager
#pragma mark--单例
+(instancetype)shareInstance{
    static MusicManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MusicManager new];
    });
    return manager;
}
#pragma mark--请求数据 返回数组
- (void)requestAllData:(void(^)(NSMutableArray * array))result{
    NSURL * url = [NSURL URLWithString:MusicUrl];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array = [NSArray arrayWithContentsOfURL:url];
        for (NSDictionary * item in array) {
            MusicModel * model = [MusicModel new];
            [model setValuesForKeysWithDictionary:item];
            [self.allModelArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        
        result(_allModelArray);
        });
        
    });
    
    
}
#pragma mark--根据下标返回Model
- (MusicModel*)getMusicModelForIndex:(NSInteger)indexPath{
    MusicModel * model = _allModelArray[indexPath];
    model.musicIndex = indexPath;
    return  model;
}



-(NSUInteger)countOfAllModelArray{
   return [_allModelArray count];
}
-(NSMutableArray *)allModelArray{
    if (!_allModelArray) {
        _allModelArray = [NSMutableArray array];
    }
    return _allModelArray;
}










@end
