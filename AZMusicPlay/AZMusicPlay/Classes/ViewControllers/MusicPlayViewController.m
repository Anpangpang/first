//
//  MusicPlayViewController.m
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayViewController.h"

@interface MusicPlayViewController ()

@end
static NSInteger zhuti = 0;

@implementation MusicPlayViewController
-(void)viewWillAppear:(BOOL)animated{
    [self updataUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [MusicPlayManager defaultHandel].delegate = self;
    [self setImageView];
    self.soundChange.transform = CGAffineTransformRotate(self.soundChange.transform,M_PI_2 );
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--更新UI
-(void)updataUI{
    
    self.musicModel = [[MusicManager shareInstance]getMusicModelForIndex:_musicModel.musicIndex];
    //音乐
    [[MusicPlayManager defaultHandel]setAVplayerWithUrl:[NSURL URLWithString: _musicModel.mp3Url ]];
    //歌名
    self.songTitle.text = _musicModel.name;
    //slider
    self.musicSlider.maximumValue = [_musicModel.duration floatValue]/1000;
    //歌词
    [[musicLyric defaultManager]formatLyricModelWithLyric:_musicModel.lyric];
    //歌词背景
    UIImageView * backView= [[UIImageView alloc]initWithFrame:self.musiclyricTableView.frame];
    [backView sd_setImageWithURL:[NSURL URLWithString: _musicModel.blurPicUrl ]];
    self.musiclyricTableView.backgroundView = backView;

    //背景
    UIImageView * backVie= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.musiclyricTableView.frame) ,CGRectGetHeight(self.musiclyricTableView.frame))];
    [backVie sd_setImageWithURL:[NSURL URLWithString: _musicModel.blurPicUrl ]];
    //[self.backOfSingerview addSubview:backVie];
    //图片
    [self.singerImageView sd_setImageWithURL:[NSURL URLWithString:_musicModel.picUrl ]];
    self.singerImageView.transform = CGAffineTransformMakeRotation(0);
    [self.backOfSingerview addSubview:self.singerImageView];
    [self.musiclyricTableView reloadData];
}
#pragma mark--更换主题
-(void)changColor:(NSInteger)colcor{
    zhuti = colcor;
    [self updataUI];
}
//变换主题


#pragma mark--设置imageView
-(void)setImageView{
    [self.singerImageView.layer layoutIfNeeded];
    self.singerImageView.layer.cornerRadius = CGRectGetWidth(self.view.frame)*3/10;
    self.singerImageView.layer.masksToBounds = YES;
    self.singerImageView.transform = CGAffineTransformMakeRotation(0);
}
#pragma mark--- 执行协议中的方法1
-(void)playingWithProgress:(CGFloat)progress{
    //图片旋转
    self.singerImageView.transform = CGAffineTransformRotate(self.singerImageView.transform,M_1_PI/180 );
    //slider
    self.musicSlider.value = progress;
    //开始时间
    self.beginTime.text = [self changTimeToString:progress];
    //结束时间
    NSInteger time =[_musicModel.duration floatValue]/1000-progress;
    self.endTime.text = [self changTimeToString:time];
    //改变歌词
    NSInteger index = [[musicLyric defaultManager]progressAtTime:progress];
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.musiclyricTableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    //[_musiclyricTableView reloadData];
}
#pragma mark--- 执行协议中的方法2
-(void)musicPlayEnd{
    self.musicModel.musicIndex=arc4random()%200;
    if (_musicModel.musicIndex > [[MusicManager shareInstance]countOfAllModelArray]-1) {
        _musicModel.musicIndex = 0;
    }
    [[MusicPlayManager defaultHandel]pauseMusic];
    [self updataUI];

}
#pragma mark---上一首

- (IBAction)upSong:(UIButton *)sender {
    //改变下标
    self.musicModel.musicIndex--;
    if (_musicModel.musicIndex < 0) {
        _musicModel.musicIndex = [[MusicManager shareInstance]countOfAllModelArray]-1;
    }
    //暂停
    [[MusicPlayManager defaultHandel]pauseMusic];
    [self updataUI];
}
#pragma mark---开始暂停

- (IBAction)startStopSong:(UIButton *)sender {
    BOOL action = [[MusicPlayManager defaultHandel]playORpause];
    if (action) {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"开始" forState:UIControlStateNormal];
    }
}
#pragma mark---下一首
- (IBAction)downSong:(UIButton *)sender {
    self.musicModel.musicIndex=arc4random()%200;
    if (_musicModel.musicIndex > [[MusicManager shareInstance]countOfAllModelArray]-1) {
        _musicModel.musicIndex = 0;
    }
    [[MusicPlayManager defaultHandel]pauseMusic];
    [self updataUI];
}
#pragma mark---返回上一级

- (IBAction)backBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark--转换时间
-(NSString*)changTimeToString:(CGFloat)time{
    int min = time/60;
    int sec = (int)time%60;
    NSString * time1 = [NSString stringWithFormat:@"%02d:%02d",min,sec];
    return time1;
}
#pragma mark--滑动改变播放
- (IBAction)sliderPlayMusic:(UISlider *)sender {
    //CGFloat duration = [_musicModel.duration floatValue]/1000;
    [[MusicPlayManager defaultHandel]pauseMusic];
    [[MusicPlayManager defaultHandel]playForATime:sender.value];
}
#pragma mark----歌词设置
//歌词区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//歌词行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[musicLyric defaultManager]lyricNumberForRow];
}


//歌词cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"songCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor redColor];
    lyricModel * lyric = [[musicLyric defaultManager]getLyricForIndex:indexPath.row];
    cell.textLabel.text = lyric.lyric;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectedView;
    cell.highlighted = YES;
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random() % 256/256.0) blue:(arc4random() % 256/256.0) alpha:1];
    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat time = [[musicLyric defaultManager]progressAtIndex:indexPath.row];
    [[MusicPlayManager defaultHandel]pauseMusic];
    [[MusicPlayManager defaultHandel]playForATime:time];
}



@end
