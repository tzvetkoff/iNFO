//
//  AppDelegate.h
//  iNFO
//
//  Created by Latchezar Tzvetkoff on 3/7/13.
//  Copyright (c) 2013 Latchezar Tzvetkoff. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PreferencesWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
	PreferencesWindowController *preferencesWindowController;
}

@property (assign) IBOutlet NSWindow *window;

@end
