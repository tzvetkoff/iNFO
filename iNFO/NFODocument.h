//
//  NFODocument.h
//  iNFO
//
//  Created by Latchezar Tzvetkoff on 3/7/13.
//  Copyright (c) 2013 Latchezar Tzvetkoff. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NFODocument : NSDocument {
	NSStringEncoding encoding;
	NSString *contents;
	IBOutlet NSTextView *textView;
	IBOutlet NSScrollView *scrollView;
}

@end
