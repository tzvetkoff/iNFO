//
//  Preferences.h
//  iNFO
//
//  Created by Latchezar Tzvetkoff on 3/7/13.
//  Copyright (c) 2013 Latchezar Tzvetkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PREF_GET(key) ([[Preferences preferences] objectForKey:key])
#define PREF_SET(key, object) ([[Preferences preferences] setObject:object forKey:key])
#define PREF_OBSERVE(key) ([[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:key options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil])
#define PREF_UNOBSERVE(key) ([[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:key])

@interface Preferences : NSObject {
	NSUserDefaults *defaults;
}

+ (id)preferences;

- (id)objectForKey:(id)key;
- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)object forKey:(id)key;
- (void)setObject:(id)object forKeyedSubscript:(id)key;

@end
