#import "HaoPSLinkCellCustom.h"

@implementation HaoPSLinkCellCustom
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];
  if (self) {
    NSString *subTitleValue = [specifier.properties objectForKey:@"subtitle"];
    self.detailTextLabel.text = [HaoPSUtil localizedItem:subTitleValue];
  }
  return self;
}
@end
