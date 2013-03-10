//
//  Preferences.m
//  iNFO
//
//  Created by Latchezar Tzvetkoff on 3/7/13.
//  Copyright (c) 2013 Latchezar Tzvetkoff. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

static Preferences *instance;
+ (id)preferences {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init];
		instance->defaults = [NSUserDefaults standardUserDefaults];
	});

	return instance;
}

- (id)objectForKey:(id)key {
	return [NSUnarchiver unarchiveObjectWithData:[defaults objectForKey:key]];
}

- (id)objectForKeyedSubscript:(id)key {
	return [self objectForKey:key];
}

- (void)setObject:(id)object forKey:(id)key {
	[defaults setObject:[NSArchiver archivedDataWithRootObject:object] forKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(id)key {
	[self setObject:object forKey:key];
}

@end
