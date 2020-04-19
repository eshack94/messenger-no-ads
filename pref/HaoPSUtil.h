
#define TWEAK_TITLE "Messenger No Ads"
#define PREF_BUNDLE_PATH "/Library/PreferenceBundles/MNAPref.bundle"
#define kTintColor [UIColor colorWithRed:0.72 green:0.53 blue:1.00 alpha:1.00];

@interface HaoPSUtil : NSObject
+ (NSString *)localizedItem:(NSString *)key;
+ (UIColor *)colorFromHex:(NSString *)hexString;
@end