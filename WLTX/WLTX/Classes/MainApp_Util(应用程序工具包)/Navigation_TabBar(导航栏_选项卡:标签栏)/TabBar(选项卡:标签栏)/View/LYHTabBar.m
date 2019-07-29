
#import "LYHTabBar.h"
static const NSInteger ITEMCOUNT = 5;
@interface LYHTabBar ()

@property (nonatomic, strong) UIButton *orderButton;

@property (nonatomic, assign) NSInteger selectedIndex;

@end
@implementation LYHTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, [UIScreen mainScreen].bounds.size.width, 1)];
        topView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        [self addSubview:topView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"ic_line_no"] forState:UIControlStateNormal];
        button.bounds = CGRectMake(0, -15, 44, 44);
        self.centerBtn = button;
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+20, button.frame.size.width+15, 12)];
//        lb.backgroundColor = [UIColor lightGrayColor];
        lb.font = [UIFont systemFontOfSize:12];
        lb.text =  @"信息发布";
//        lb.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.78];
        lb.textColor = [UIColor blackColor];
        self.centerLb = lb;
        [self addSubview:lb];
        [self addSubview:button];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // self.height * 0.2

    
    
    if (IS_IPHONE_Xs_Max || IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs) {
        self.centerBtn.center = CGPointMake(self.width * 0.5, self.height * 0.25);
        self.centerLb.center = CGPointMake(self.width * 0.505, self.height *0.5);
    }
    else
    {
        self.centerBtn.center = CGPointMake(self.width * 0.5, self.height * 0.34);
        self.centerLb.center = CGPointMake(self.width * 0.505, self.centerBtn.height-3);
    }
    int index = 0;
    //    CGFloat wigth = self.width / ITEMCOUNT; // 按比例分
    CGFloat wigth = self.width / 2;
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            sub.x = index * wigth;
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.centerBtn];
        
        if ( [self.centerBtn pointInside:newPoint withEvent:event]) {
            return self.centerBtn;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        return [super hitTest:point withEvent:event];
    }
}

@end



//
//#import "LYHTabBar.h"
//static const NSInteger ITEMCOUNT = 5;
//@interface LYHTabBar ()
//
//@property (nonatomic, strong) UIButton *orderButton;
//
//@property (nonatomic, assign) NSInteger selectedIndex;
//
//@end
//@implementation LYHTabBar
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, [UIScreen mainScreen].bounds.size.width, 1)];
//        topView.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:topView];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
//        button.bounds = CGRectMake(0, 0, 64, 64);
//        self.centerBtn = button;
//        [self addSubview:button];
//    }
//    return self;
//}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    // self.height * 0.2
//    self.centerBtn.center = CGPointMake(self.width * 0.5, self.height * 0.1);
//
//    int index = 0;
//    CGFloat wigth = self.width / ITEMCOUNT;
//    for (UIView *sub in self.subviews) {
//        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            sub.x = index * wigth;
//            index++;
//            if (index == 2) {
//                index++;
//            }
//        }
//    }
//}
//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    if (self.isHidden == NO) {
//
//        CGPoint newPoint = [self convertPoint:point toView:self.centerBtn];
//
//        if ( [self.centerBtn pointInside:newPoint withEvent:event]) {
//            return self.centerBtn;
//        }else{
//
//            return [super hitTest:point withEvent:event];
//        }
//    }
//
//    else {
//        return [super hitTest:point withEvent:event];
//    }
//}
//
//@end
