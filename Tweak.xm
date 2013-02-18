#import <Foundation/Foundation.h>
#include <objc/runtime.h>
#import <UIKit/UIKit.h>

float brightness;
NSMutableDictionary* SBPlistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist"];

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application
{
    %orig;
    brightness = [[SBPlistDict objectForKey:@"SBBacklightLevel2"] floatValue];
    [[UIScreen mainScreen]setBrightness:brightness];
}

%end

__attribute__((constructor)) static void init()
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    %init;

    [pool release];
}
