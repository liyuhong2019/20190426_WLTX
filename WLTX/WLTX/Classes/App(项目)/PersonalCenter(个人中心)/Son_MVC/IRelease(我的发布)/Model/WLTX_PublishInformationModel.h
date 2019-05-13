//
//  WLTX_PublishInformationModel.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/13.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_PublishInformationModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *tyle;
@property (nonatomic,strong) NSString *is_sh; // 是否已经审核
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *time;

@end

NS_ASSUME_NONNULL_END
