#import "HaoPSHeaderCellCustom.h"

@implementation HaoPSHeaderCellCustom {
  UILabel *label;
  UILabel *underLabel;
}

- (id)initWithSpecifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  if (self) {
    #define kWidth [[UIApplication sharedApplication] keyWindow].frame.size.width
    NSArray *subtitles = [NSArray arrayWithObjects:@"By @haoict", @"Free and Open Source!", @"The best tweak for Messenger", nil];

    CGRect labelFrame = CGRectMake(0, 10, kWidth, 80);
    CGRect underLabelFrame = CGRectMake(0, 60, kWidth, 60);

    label = [[UILabel alloc] initWithFrame:labelFrame];
    [label setNumberOfLines:1];
    label.font = [UIFont systemFontOfSize:35];
    [label setText:[specifier.properties objectForKey:@"label"]];
    label.textColor = kTintColor;
    label.textAlignment = NSTextAlignmentCenter;

    underLabel = [[UILabel alloc] initWithFrame:underLabelFrame];
    [underLabel setNumberOfLines:1];
    underLabel.font = [UIFont systemFontOfSize:15];
    uint32_t rnd = arc4random_uniform([subtitles count]);
    [underLabel setText:[subtitles objectAtIndex:rnd]];
    underLabel.textColor = [UIColor grayColor];
    underLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:label];
    [self addSubview:underLabel];
  }
  return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
  CGFloat prefHeight = 110.0;
  return prefHeight;
}
@end