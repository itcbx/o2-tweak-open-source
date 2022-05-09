#import "HBPreferences+Helpers.h"

@implementation HBPreferences (Helpers)

- (NSInteger)nonZeroIntegerForKey:(NSString *)key fallback:(NSInteger)fallback {
	NSNumber *object = [self objectForKey:key];
	if (object) {
		return (object.intValue != 0) ? object.intValue : fallback;
	}
	return fallback;
}

- (BOOL)valueExistsForKey:(NSString *)key {
	if ([self objectForKey:key]) {
		NSString *value = [self objectForKey:key];
		return ![value isEqualToString:@""];
	}
	return NO;
}

@end