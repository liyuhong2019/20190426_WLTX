/**
参考 https://www.jianshu.com/p/3acc43262b7d
 
 swift 宏属性
 
 let iphone5  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:960,height:1336), (UIScreen.main.currentMode?.size)!) : false
 let iphone6  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:750,height:1334), (UIScreen.main.currentMode?.size)!) : false
 let iphone6p  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1242,height:2208), (UIScreen.main.currentMode?.size)!) : false
 let iphone6pBigMode = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2001), (UIScreen.main.currentMode?.size)!) : false
 let iphoneX = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2436), (UIScreen.main.currentMode?.size)!) : false
 let iphoneXR = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:828,height:1792), (UIScreen.main.currentMode?.size)!) : false
 let iphoneXSM  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1242,height:2688), (UIScreen.main.currentMode?.size)!) : false
 let iphoneXXL = (iphoneX||iphoneXR||iphoneXSM)
 
 
 //适配参数
 let suitParm:CGFloat = ((iphone6p||iphoneXR||iphoneXSM) ? 1.12 : (iphone6 ? 1.0 : (iphone6pBigMode ? 1.01 : (iphoneX ? 1.0 : 0.85))))

 */


NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (IBDesignable)
@property(nonatomic, assign) IBInspectable BOOL adapterScreen;
@end

NS_ASSUME_NONNULL_END
