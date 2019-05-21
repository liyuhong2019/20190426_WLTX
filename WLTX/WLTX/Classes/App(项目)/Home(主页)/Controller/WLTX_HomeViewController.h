//
//  WLTX_HomeViewController.h
//  WLTX
//
//  Created by lee on 2019/3/6.
//  Copyright © 2019年 liyuhong165. All rights reserved.
//

#import "LYHBaseViewController.h"
#import <iflyMSC/iflyMSC.h>
@interface WLTX_HomeViewController : LYHBaseViewController
<IFlySpeechRecognizerDelegate,
IFlyRecognizerViewDelegate>

// 讯飞科大
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;


@end
