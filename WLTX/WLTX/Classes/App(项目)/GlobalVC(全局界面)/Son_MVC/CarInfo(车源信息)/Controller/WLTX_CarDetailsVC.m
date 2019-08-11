//
//  WLTX_CarDetailsVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/22.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CarDetailsVC.h"

@interface WLTX_CarDetailsVC ()
@property (weak, nonatomic) IBOutlet UILabel *lb_carNumber;
@property (weak, nonatomic) IBOutlet UILabel *lb_carLength;
@property (weak, nonatomic) IBOutlet UILabel *lb_carWeight;
@property (weak, nonatomic) IBOutlet UILabel *lb_location;
@property (weak, nonatomic) IBOutlet UILabel *lb_tel;
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;

@end

@implementation WLTX_CarDetailsVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.lb_tel.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [self.lb_tel addGestureRecognizer:labelTapGestureRecognizer];

}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    
    NSLog(@"%@被点击了",label.text);
    
    NSString*replacedStr = [label.text stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    label.text = replacedStr;
    //    SharedAppDelegate.companyName = cell.lb_route.text;
    [self vcCallPhoneNumber:label.text];

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车源信息详情";
    
    [self netwrok_getShuttleRouteListRequestWithid:self.detailsId];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 专线路线
- (void)netwrok_getShuttleRouteListRequestWithid:(NSString *)detailsId
{
    [AFNetworkingTool postWithURLString:Common_CarInfo(detailsId) parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSDictionary *data = result[@"data"];
        NSString *content = data[@"content"];
        
        /**
         "dizhi" : "广州市白云区太和物流广场",
         "img" : "http:\/\/www.0201566.com\/tupian\/image\/20180601\/20180601123743_58145.jpg",
         "chepai" : "粤A8123",
         "length" : "4.2米",
         "chezai" : "1.5吨",
         "tel" : "15856565658"
         */
        self.lb_location.text = result[@"dizhi"];
        [self.img_icon sd_setImageWithURL:[NSURL URLWithString:result[@"img"]] placeholderImage:[UIImage imageNamed:@""]];
        self.lb_carNumber.text = result[@"chepai"];
        self.lb_tel.text = result[@"tel"];
        self.lb_carLength.text = result[@"length"];
        self.lb_carWeight.text = result[@"chezai"];

    } failure:^(NSError *error) {
        
    }];
}
// http://m.0201566.com/appapi/cheyuan_content.php?id=
@end
