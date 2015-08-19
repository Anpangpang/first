//
//  MusicListTableViewCell.h
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *singerName;
@property (strong, nonatomic) IBOutlet UIImageView *singerImageView;
@property (strong, nonatomic) IBOutlet UILabel *songName;
@property (weak,nonatomic)MusicModel * model;
@end
