//
//  NFODocument.m
//  iNFO
//
//  Created by Latchezar Tzvetkoff on 3/7/13.
//  Copyright (c) 2013 Latchezar Tzvetkoff. All rights reserved.
//

#import "NFODocument.h"
#import "Preferences.h"

@implementation NFODocument

#pragma mark - Initialization

- (id)init {
	if (self = [super init]) {
		encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertWindowsCodepageToEncoding(437));
		contents = @"";
	}

	return self;
}

#pragma mark - Cleanup

- (void)dealloc {
	PREF_UNOBSERVE(@"iNFO_ForegroundColor");
	PREF_UNOBSERVE(@"iNFO_BackgroundColor");
	PREF_UNOBSERVE(@"iNFO_Font");
}

#pragma mark - Loading Document Data

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
	contents = [NSString stringWithContentsOfURL:url encoding:encoding error:outError];

	if (!contents) {
		if (outError) {
			[self presentError:*outError modalForWindow:self.windowForSheet delegate:nil didPresentSelector:nil contextInfo:nil];
		}

		return NO;
	}

	return YES;
}

#pragma mark - Saving Document Data

- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
	return [textView.string writeToURL:url atomically:YES encoding:encoding error:outError];
}

#pragma mark - Window Controller Creation

- (NSString *)windowNibName {
	return @"NFODocumentWindow";
}

#pragma mark - Window Controller Lifecycle

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController {
	[super windowControllerDidLoadNib:windowController];

	PREF_OBSERVE(@"iNFO_ForegroundColor");
	PREF_OBSERVE(@"iNFO_BackgroundColor");
	PREF_OBSERVE(@"iNFO_Font");

	textView.textColor = textView.insertionPointColor = PREF_GET(@"iNFO_ForegroundColor");
	scrollView.backgroundColor = PREF_GET(@"iNFO_BackgroundColor");
	textView.font = PREF_GET(@"iNFO_Font");
	textView.textContainer.containerSize = NSMakeSize(FLT_MAX, FLT_MAX);
	textView.textContainer.widthTracksTextView = NO;
	textView.string = contents, contents = nil;
}

#pragma mark - Defaults Change Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"iNFO_ForegroundColor"]) {
		textView.textColor = textView.insertionPointColor = [NSUnarchiver unarchiveObjectWithData:[change objectForKey:@"new"]];
	} else if ([keyPath isEqualToString:@"iNFO_BackgroundColor"]) {
		scrollView.backgroundColor = [NSUnarchiver unarchiveObjectWithData:[change objectForKey:@"new"]];
	} else if ([keyPath isEqualToString:@"iNFO_Font"]) {
		textView.font = [NSUnarchiver unarchiveObjectWithData:[change objectForKey:@"new"]];
	}
}

@end
