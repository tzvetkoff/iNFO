//
//  PreferencesWindowController.m
//  iNFO
//
//  Created by Latchezar Tzvetkoff on 2013-03-07.
//  Copyright (c) 2013 Latchezar Tzvetkoff. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "Preferences.h"

@implementation PreferencesWindowController

#pragma mark - Initialization

- (id)init {
	if (self = [self initWithWindowNibName:@"PreferencesWindow" owner:self]) {
		//
	}

	return self;
}

#pragma mark - Window Lifecycle

- (void)windowDidLoad {
	NSFont *font = PREF_GET(@"iNFO_Font");
	fontButton.title = [NSString stringWithFormat:@"%@ %.0f", font.fontName, font.pointSize];
	[fontButton sizeToFit];
	foregroundColorWell.color = PREF_GET(@"iNFO_ForegroundColor");
	backgroundColorWell.color = PREF_GET(@"iNFO_BackgroundColor");
}

#pragma mark - Actions

- (void)changeFont:(NSFontManager *)sender {
	NSFont *font = [sender convertFont:sender.selectedFont];
	fontButton.title = [NSString stringWithFormat:@"%@ %.0f", font.fontName, font.pointSize];
	[fontButton sizeToFit];
	PREF_SET(@"iNFO_Font", font);
}

- (IBAction)chooseFont:(NSButton *)sender {
	NSFontManager *fontManager = [NSFontManager sharedFontManager];
	[fontManager setSelectedFont:PREF_GET(@"iNFO_Font") isMultiple:NO];
	[fontManager setDelegate:self];
	[fontManager setTarget:self];
	[fontManager orderFrontFontPanel:self];
}

- (NSUInteger)validModesForFontPanel:(NSFontPanel *)fontPanel {
	return NSFontPanelFaceModeMask | NSFontPanelCollectionModeMask | NSFontPanelSizeModeMask;
}

- (IBAction)foregroundColorChanged:(NSColorWell *)sender {
	PREF_SET(@"iNFO_ForegroundColor", sender.color);
}

- (IBAction)backgroundColorChanged:(NSColorWell *)sender {
	PREF_SET(@"iNFO_BackgroundColor", sender.color);
}

@end
