//
//  MusicListTableViewCell.m
//  AZMusicPlay
//
//  Created by lanou3g on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicListTableViewCell.h"

@implementation MusicListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MusicModel *)model{
    [self.singerImageView sd_setImageWithURL:[NSURL URLWithString: model.blurPicUrl]];
    self.singerName.text = model.singer;
    self.songName.text = model.name;
}
@end
