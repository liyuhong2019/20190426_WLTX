//
//  WLTX_RegistViewController.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/3/16.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "LYHBaseViewController.h"


typedef NS_OPTIONS(NSUInteger, RegistType) {
    RegistType_Dirver  = 0,  //  默认 司机
    RegistType_Shipper    ,  // 货主
    RegistType_LogisticsCompany       // 物流公司

};

typedef NS_OPTIONS(NSUInteger, UserAgreement) {
    UserAgreement_NotAgreed  = 0,  //  不同意
    UserAgreement_Agreed    ,  // 默认 同意
    
};


NS_ASSUME_NONNULL_BEGIN

@interface WLTX_RegistViewController : LYHBaseViewController

@end

NS_ASSUME_NONNULL_END
