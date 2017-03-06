//
//  GBItemModel.h
//  zhibo
//
//  Created by K.Lam on 2017/3/6.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBItemDetailModel.h"

@interface GBItemModel : NSObject

@property (nonatomic , strong) GBItemDetailModel *creator;

@property (nonatomic , copy) NSString *id;

@property (nonatomic , copy) NSString *name;

@property (nonatomic , copy) NSString *city;

@property (nonatomic , copy) NSString *share_addr;

@property (nonatomic , copy) NSString *stream_addr;

@end
