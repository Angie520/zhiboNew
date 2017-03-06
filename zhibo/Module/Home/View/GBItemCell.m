//
//  GBItemCell.m
//  zhibo
//
//  Created by K.Lam on 2017/3/6.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "GBItemCell.h"
#import "GBItemDetailModel.h"
#import "UIImageView+WebCache.h"
@interface GBItemCell()

@property (nonatomic , weak) UILabel *nickLabel;

@property (nonatomic , weak) UIImageView *iconView;

@end

@implementation GBItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GBWidth, 20)];
        nickLabel.textAlignment = NSTextAlignmentCenter;
        nickLabel.textColor = [UIColor blackColor];
        [self addSubview:nickLabel];
        self.nickLabel = nickLabel;
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, GBWidth, GBWidth)];
        [self addSubview:iconView];
        self.iconView = iconView;
    }
    
    return self;
}

- (void)setModel:(GBItemModel *)model {
    _model = model;
    
    self.nickLabel.text = model.creator.nick;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait]];
}

@end
