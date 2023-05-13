#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface SBUIPreciseClockTimer : NSObject
@end

@interface SBLockScreenManager : NSObject
+ (instancetype)sharedInstanceIfExists;
- (UIColor *)averageColorForCurrentWallpaperInScreenRect:(struct CGRect)rect;
@end

@interface SBFLockScreenDateViewController : UIViewController
@end

@interface _UIStatusBarStringView : UILabel
@property (nonatomic, assign, readwrite) NSInteger fontStyle;
@end

@interface UIViewController (Private)
- (BOOL)_canShowWhileLocked;
@end
