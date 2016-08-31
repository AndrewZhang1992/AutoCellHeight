//
//  PersonCell.m
//  Mastory_Use
//
//  Created by Andrew on 16/8/30.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "PersonCell.h"
#import "Masonry.h"
#import "Person.h"

// 设备高度
#define DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
// 设备宽度
#define DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define CT_SCALE        DEVICE_HEIGHT/568.0
#define CT_SCALE_X      DEVICE_WIDTH/320.0
#define CT_SCALE_Y      DEVICE_HEIGHT/568.0

@interface PersonCell ()
{
    UIImageView *_avatarImageView;
    UILabel *_nameLabel;
    UILabel *_pitchLabel;
    UIButton *_locationBtn;
    UILabel *_roundLabel;
    UILabel *_industryLabel;
    
}
@end

@implementation PersonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeSubView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)makeSubView
{
    _avatarImageView = [UIImageView new];
    _avatarImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_avatarImageView];
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@10);
        make.left.mas_equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(60*CT_SCALE_X, 60*CT_SCALE_X));
    }];
    _avatarImageView.layer.cornerRadius = 60*CT_SCALE_X/2;
    _avatarImageView.layer.masksToBounds=YES;
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_nameLabel];
    
    __block PersonCell *weakSelf = self;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf->_avatarImageView.mas_top);
        make.left.mas_equalTo(weakSelf->_avatarImageView.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    
    
    _pitchLabel = [UILabel new];
    _pitchLabel.numberOfLines=0;
    _pitchLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_pitchLabel];
    
    
    // 恒定宽度，高度随着内容变化
    [_pitchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf->_avatarImageView.mas_left);
          make.top.equalTo(weakSelf->_avatarImageView.mas_bottom).with.offset(10);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(-10);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-10);
    }];
    
     [_pitchLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    

    _locationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _locationBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_locationBtn];
    
    [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf->_avatarImageView.mas_right).with.offset(10);
        make.top.equalTo(weakSelf->_nameLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [_locationBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_locationBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    _roundLabel = [UILabel new];
    _roundLabel.font = [UIFont systemFontOfSize:12.0];
    
    [self.contentView addSubview:_roundLabel];
    
    
    [_roundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf->_locationBtn.mas_right);
        make.top.equalTo(weakSelf->_locationBtn.mas_top);
        make.height.equalTo(@20);
    }];
    
    [_roundLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
}

-(void)setPerson:(Person *)person
{
    _nameLabel.text = person.name;
    _pitchLabel.text = person.pitch;
    [_locationBtn setTitle:person.location forState:UIControlStateNormal];
    __block PersonCell *weakSelf = self;
    if ([person.location isEqualToString:@""]) {
        [_locationBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf->_avatarImageView.mas_right).with.offset(10);
            make.top.equalTo(weakSelf->_nameLabel.mas_bottom).with.offset(10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(0);
        }];
    }else{
        [_locationBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf->_avatarImageView.mas_right).with.offset(10);
            make.top.equalTo(weakSelf->_nameLabel.mas_bottom).with.offset(10);
            make.height.mas_equalTo(20);
        }];
        [_locationBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_locationBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
//    _locationLabel.text = person.location;
    _roundLabel.text = person.round;
}


@end
