//
//  PreferencesWindowController.h
//  iNFO
//
//  Created by Latchezar Tzvetkoff on 2013-03-07.
//  Copyright (c) 2013 Latchezar Tzvetkoff. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesWindowController : NSWindowController {
	IBOutlet NSButton *fontButton;
	IBOutlet NSColorWell *foregroundColorWell;
	IBOutlet NSColorWell *backgroundColorWell;
}

@end
