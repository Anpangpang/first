//
//  MusicPlayViewController.h
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPlayManager.h"
@interface MusicPlayViewController : UIViewController<MusicPlayDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *controlerView;
@property (strong, nonatomic) IBOutlet UIView *backOfSingerview;
@property (strong, nonatomic) IBOutlet UILabel *songTitle;//歌曲名
@property (strong, nonatomic) IBOutlet UIImageView *singerImageView;//图片
- (IBAction)upSong:(UIButton *)sender;//上一曲
- (IBAction)startStopSong:(UIButton *)sender;//开始
- (IBAction)downSong:(UIButton *)sender;//下一曲
- (IBAction)backBack:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *endTime;//结束时间
@property (strong, nonatomic) IBOutlet UILabel *beginTime;//开始时间
@property (strong, nonatomic) IBOutlet UISlider *musicSlider;
@property (strong, nonatomic) IBOutlet UITableView *musiclyricTableView;

- (IBAction)sliderPlayMusic:(UISlider *)sender;
@property (strong, nonatomic) IBOutlet UISlider *soundChange;
@property (strong ,nonatomic)MusicModel * musicModel;
@end
