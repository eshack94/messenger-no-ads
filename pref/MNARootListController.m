#include "MNARootListController.h"

#define PLIST_PATH "/var/mobile/Library/Preferences/com.haoict.messengernoadspref.plist"
#define PREF_CHANGED_NOTIF "com.haoict.messengernoadspref/PrefChanged"

@implementation MNARootListController
- (id)init {
  self = [super init];
  if (self) {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[HaoPSUtil localizedItem:@"APPLY"] style:UIBarButtonItemStylePlain target:self action:@selector(apply)];;
  }
  return self;
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
  self.view.tintColor = kTintColor;
  keyWindow.tintColor = kTintColor;
  [UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]].onTintColor = kTintColor;
  // self.view.separatorColor = [UIColor clearColor];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
  keyWindow.tintColor = nil;
}
- (NSArray *)specifiers {
  if (!_specifiers) {
    _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
  }

  /** Disable Hide Search Bar for ios 13 - begin **/
  if (@available(iOS 13, *)) {
    for (PSSpecifier *spec in _specifiers) {
      if ([[spec.properties objectForKey:@"key"] isEqual:@"hidesearchbar"]) {
        [spec setProperty:@FALSE forKey:@"enabled"];
      }
    }
  }
  /** Disable Hide Search Bar for ios 13 - end   **/

  return _specifiers;
}
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH] ?: [@{} mutableCopy];
  [settings setObject:value forKey:[[specifier properties] objectForKey:@"key"]];
  [settings writeToFile:@PLIST_PATH atomically:YES];
  notify_post(PREF_CHANGED_NOTIF);
}
- (id)readPreferenceValue:(PSSpecifier *)specifier {
  NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:@PLIST_PATH];
  return settings[[[specifier properties] objectForKey:@"key"]] ?: [[specifier properties] objectForKey:@"default"];
}
- (void)resetSettings:(PSSpecifier *)specifier  {
  [@{} writeToFile:@PLIST_PATH atomically:YES];
  [self reloadSpecifiers];
  notify_post(PREF_CHANGED_NOTIF);
}
- (void)openURL:(PSSpecifier *)specifier  {
  UIApplication *app = [UIApplication sharedApplication];
  NSString *url = [specifier.properties objectForKey:@"url"];
  [app openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
}

/**
 * Apply top right button
 */
-(void)apply {
  UIAlertController *killConfirm = [UIAlertController alertControllerWithTitle:@TWEAK_TITLE message:[HaoPSUtil localizedItem:@"DO_YOU_REALLY_WANT_TO_KILL_MESSENGER"] preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:[HaoPSUtil localizedItem:@"CONFIRM"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
    NSTask *killall = [[NSTask alloc] init];
    [killall setLaunchPath:@"/usr/bin/killall"];
    [killall setArguments:@[@"-9", @"Messenger", @"LightSpeedApp"]];
    [killall launch];
  }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[HaoPSUtil localizedItem:@"CANCEL"] style:UIAlertActionStyleCancel handler:nil];
  [killConfirm addAction:confirmAction];
  [killConfirm addAction:cancelAction];
  [self presentViewController:killConfirm animated:YES completion:nil];
}

- (void)respring {
  NSTask *killall = [[NSTask alloc] init];
  [killall setLaunchPath:@"/usr/bin/killall"];
  [killall setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
  [killall launch];
}

@end
