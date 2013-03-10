//
//  AppDelegate.m
//  iNFO/Users/w00t/Code/iNFO/core.nfo
//
//  Created by Latchezar Tzvetkoff on 3/7/13.
//  Copyright (c) 2013 Latchezar Tzvetkoff. All rights reserved.
//

#import "AppDelegate.h"
#import "Preferences.h"

@implementation AppDelegate

- (void)registerFonts {
	NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/Fonts"];
	NSArray *names = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];

	for (NSString *name in names) {
		NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:name]];
		CFErrorRef error = nil;
		if (!CTFontManagerRegisterFontsForURL((__bridge CFURLRef)(url), kCTFontManagerScopeProcess, &error)) {
			CFShow(error);
			exit(1);
		}
	}
}

- (void)setDefaultPreferences {
	NSFont *font;
	font = [NSFont fontWithName:@"LucidaConsoleP" size:12.0];
	if (!font) {
		font = [NSFont fontWithName:@"Menlo" size:12.0];
	}

	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
															 [NSArchiver archivedDataWithRootObject:[NSColor blackColor]], @"iNFO_BackgroundColor",
															 [NSArchiver archivedDataWithRootObject:[NSColor lightGrayColor]], @"iNFO_ForegroundColor",
															 [NSArchiver archivedDataWithRootObject:font], @"iNFO_Font",
															 nil]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self registerFonts];
	[self setDefaultPreferences];
}

- (IBAction)openPreferences:(id)sender {
	if (!preferencesWindowController) {
		preferencesWindowController = [[PreferencesWindowController alloc] init];
	}

	[preferencesWindowController showWindow:nil];
}

@end
