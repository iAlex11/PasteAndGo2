#line 1 "Tweak.x"



#import "PasteAndGo2.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBUIAppIconForceTouchController; @class SBUIAppIconForceTouchControllerDataProvider; @class SBIconView; @class SBSApplicationShortcutItem; 

static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBSApplicationShortcutItem(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBSApplicationShortcutItem"); } return _klass; }
#line 9 "Tweak.x"
static bool _logos_method$iOS13Up$SBIconView$isInArray$item$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL, NSArray, NSString); static NSURL _logos_method$iOS13Up$SBIconView$generateLink$forApp$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL, NSString *, NSString *); static NSArray * (*_logos_orig$iOS13Up$SBIconView$applicationShortcutItems)(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL); static NSArray * _logos_method$iOS13Up$SBIconView$applicationShortcutItems(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL); static void (*_logos_meta_orig$iOS13Up$SBIconView$activateShortcut$withBundleIdentifier$forIconView$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, SBSApplicationShortcutItem*, NSString*, id); static void _logos_meta_method$iOS13Up$SBIconView$activateShortcut$withBundleIdentifier$forIconView$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, SBSApplicationShortcutItem*, NSString*, id); 




static bool _logos_method$iOS13Up$SBIconView$isInArray$item$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSArray array, NSString item) {
	for (NSString * currentString in array) {

		if ([currentString isEqualToString:item]) {
			return true;
		}
		return false;

	}
}


static NSURL _logos_method$iOS13Up$SBIconView$generateLink$forApp$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * url, NSString * bundleID) {

	NSString * urlScheme;

	UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard]; 
	NSString *pbStr = [pasteBoard string];
	NSArray * appBundleIDs = [[NSArray alloc] initWithObjects:@"com.apple.mobilesafari", @"org.mozilla.ios.Firefox", @"org.mozilla.ios.Focus", @"com.google.chrome.ios", @"com.brave.ios.browser", @"com.microsoft.msedge",nil];

	switch (([[appBundleIDs objectAtIndex:1] intValue])) {
		
		case 2:
			urlScheme = @"firefox://open-url?url=";
			break;

		case 3:
			urlScheme = @"firefox-focus://open-url?url=";
			break;

		case 4:
			url = [[[url stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"http://" withString:@""] mutableCopy];
			urlScheme = @"googlechrome://";
			break;

		case 5:
			urlScheme = @"brave://open-url?url=";
			break;

		case 6:
			urlScheme = @"microsoft-edge-";
			break;

		default:
			break;
	}

	NSURL * finalURL = [NSURL URLWithString:url];

	if ([[UIApplication sharedApplication] canOpenURL:finalURL]) {

		finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlScheme, [pbStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];

		return finalURL;

	} else { 
		
		if ([bundleID isEqualToString:@"com.google.chrome.ios"]) {
			finalURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@www.google.com/search?q=%@", urlScheme, [[pbStr stringByReplacingOccurrencesOfString:@" " withString:@"+"] mutableCopy]]]; 
		} else {
			finalURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@https://www.google.com/search?q=%@", urlScheme, [[pbStr stringByReplacingOccurrencesOfString:@" " withString:@"+"] mutableCopy]]]; 
		}
		

		return finalURL;

	}
}

static NSArray * _logos_method$iOS13Up$SBIconView$applicationShortcutItems(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	
	NSArray * orig = _logos_orig$iOS13Up$SBIconView$applicationShortcutItems(self, _cmd);

	
	NSString * bundleID;
	NSBundle * tweakBundle = [NSBundle bundleWithPath:@"/Library/Application Support/PasteAndGo2.bundle"];
	NSArray * appBundleIDs = [[NSArray alloc] initWithObjects:@"com.apple.mobilesafari", @"org.mozilla.ios.Firefox", @"org.mozilla.ios.Focus", @"com.google.chrome.ios", @"com.brave.ios.browser", @"com.microsoft.msedge",nil];

	if ([self respondsToSelector:@selector(applicationBundleIdentifier)]){
		bundleID = [self applicationBundleIdentifier];
	} else if ([self respondsToSelector:@selector(applicationBundleIdentifierForShortcuts)]){
		bundleID = [self applicationBundleIdentifierForShortcuts];
	}

	if(!bundleID){
		return orig;
	}

	if ([self isInArray:appBundleIDs item:bundleID]){
		
		UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard]; 
		NSString *pbStr = [pasteBoard string];
		
		if (pbStr){
			
			NSURL *url = [NSURL URLWithString:[pbStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
			
			if ([[UIApplication sharedApplication] canOpenURL:url]) { 

				SBSApplicationShortcutItem* pasteAndGoItem = [[_logos_static_class_lookup$SBSApplicationShortcutItem() alloc] init];
				pasteAndGoItem.localizedTitle = [tweakBundle localizedStringForKey:@"PASTEANDGO" value:@"" table:nil];
				pasteAndGoItem.localizedSubtitle = [NSString stringWithFormat: @"Go to: %@", [[[pbStr stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"http://" withString:@""] mutableCopy]]; 
				pasteAndGoItem.type = @"com.amodrono.pasteandgo2.item";

				return [orig arrayByAddingObject:pasteAndGoItem];

			} else { 

				SBSApplicationShortcutItem* pasteAndGoItem = [[_logos_static_class_lookup$SBSApplicationShortcutItem() alloc] init];
				pasteAndGoItem.localizedTitle = [tweakBundle localizedStringForKey:@"PASTEANDSEARCH" value:@"" table:nil];
				pasteAndGoItem.localizedSubtitle = [NSString stringWithFormat: @"Search \"%@\"", pbStr];
				pasteAndGoItem.type = @"com.amodrono.pasteandgo2.item";

				return [orig arrayByAddingObject:pasteAndGoItem];

			}
		}
	}

	return orig;
}

static void _logos_meta_method$iOS13Up$SBIconView$activateShortcut$withBundleIdentifier$forIconView$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, SBSApplicationShortcutItem* item, NSString* bundleID, id iconView){
	
	if ([[item type] isEqualToString:@"com.amodrono.pasteandgo2.item"]){
		
		UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard]; 
		NSString *pbStr = [pasteBoard string];
		
		if (pbStr){
			
			NSURL * url = [self generateLink:pbStr]
			
			[[UIApplication sharedApplication] openURL:url];

		}
	}

	_logos_meta_orig$iOS13Up$SBIconView$activateShortcut$withBundleIdentifier$forIconView$(self, _cmd, item, bundleID, iconView);
}






static NSArray * (*_logos_orig$iOS12OrDown$SBUIAppIconForceTouchControllerDataProvider$applicationShortcutItems)(_LOGOS_SELF_TYPE_NORMAL SBUIAppIconForceTouchControllerDataProvider* _LOGOS_SELF_CONST, SEL); static NSArray * _logos_method$iOS12OrDown$SBUIAppIconForceTouchControllerDataProvider$applicationShortcutItems(_LOGOS_SELF_TYPE_NORMAL SBUIAppIconForceTouchControllerDataProvider* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$iOS12OrDown$SBUIAppIconForceTouchController$appIconForceTouchShortcutViewController$activateApplicationShortcutItem$)(_LOGOS_SELF_TYPE_NORMAL SBUIAppIconForceTouchController* _LOGOS_SELF_CONST, SEL, id, SBSApplicationShortcutItem*); static void _logos_method$iOS12OrDown$SBUIAppIconForceTouchController$appIconForceTouchShortcutViewController$activateApplicationShortcutItem$(_LOGOS_SELF_TYPE_NORMAL SBUIAppIconForceTouchController* _LOGOS_SELF_CONST, SEL, id, SBSApplicationShortcutItem*); 



static NSArray * _logos_method$iOS12OrDown$SBUIAppIconForceTouchControllerDataProvider$applicationShortcutItems(_LOGOS_SELF_TYPE_NORMAL SBUIAppIconForceTouchControllerDataProvider* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	
	NSArray *orig = _logos_orig$iOS12OrDown$SBUIAppIconForceTouchControllerDataProvider$applicationShortcutItems(self, _cmd);

	
	NSString * bundleID;
	NSBundle * tweakBundle = [NSBundle bundleWithPath:@"/Library/Application Support/PasteAndGo2.bundle"];
	NSArray * appBundleIDs = [[NSArray alloc] initWithObjects:@"com.apple.mobilesafari", @"org.mozilla.ios.Firefox", @"org.mozilla.ios.Focus", @"com.google.chrome.ios", @"com.brave.ios.browser", @"com.microsoft.msedge",nil];

	if (!bundleID){
		return orig;
	}
	
	if ([self isInArray:appBundleIDs item:bundleID]){
		
		UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard]; 
		NSString *pbStr = [pasteBoard string];
		
		if (pbStr){
			
			NSURL *url = [NSURL URLWithString:[pbStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
			
			if ([[UIApplication sharedApplication] canOpenURL:url]) {
				
				SBSApplicationShortcutItem* pasteAndGoItem = [[_logos_static_class_lookup$SBSApplicationShortcutItem() alloc] init];
				pasteAndGoItem.localizedTitle = [tweakBundle localizedStringForKey:@"PASTEANDGO" value:@"" table:nil];
				pasteAndGoItem.localizedSubtitle = [NSString stringWithFormat: @"Go to: %@", [[[pbStr stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"http://" withString:@""] mutableCopy]]; 
				pasteAndGoItem.type = @"com.amodrono.pasteandgo2.item";

				if (!orig){
					return @[pasteAndGoItem];
				} else {
					return [orig arrayByAddingObject:pasteAndGoItem];
				}

			} else { 

				SBSApplicationShortcutItem* pasteAndGoItem = [[_logos_static_class_lookup$SBSApplicationShortcutItem() alloc] init];
				pasteAndGoItem.localizedTitle = [tweakBundle localizedStringForKey:@"PASTEANDSEARCH" value:@"" table:nil];
				pasteAndGoItem.localizedSubtitle = [NSString stringWithFormat: @"Search \"%@\"", pbStr];
				pasteAndGoItem.type = @"com.amodrono.pasteandgo2.item";

				if (!orig) {
					return @[pasteAndGoItem];
				} else {
					return [orig arrayByAddingObject:pasteAndGoItem];
				}

			}
		}
	}

	return orig;
}



















static void _logos_method$iOS12OrDown$SBUIAppIconForceTouchController$appIconForceTouchShortcutViewController$activateApplicationShortcutItem$(_LOGOS_SELF_TYPE_NORMAL SBUIAppIconForceTouchController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, SBSApplicationShortcutItem* item) {
	
	if ([item.type isEqualToString:@"com.amodrono.pasteandgo2.item"]){
		
		UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard]; 
		NSString *pbStr = [pasteBoard string];
		
		if (pbStr){
			
			NSURL *url = [NSURL URLWithString:[pbStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
			
			if ([[UIApplication sharedApplication] canOpenURL:url]) {

				[[UIApplication sharedApplication] openURL:url];

			} else { 
				
				url = [NSURL URLWithString: [NSString stringWithFormat:@"https://www.google.com/search?q=%@", [[pbStr stringByReplacingOccurrencesOfString:@" " withString:@"+"] mutableCopy]]]; 

				[[UIApplication sharedApplication] openURL:url];

			}
		}
	}

	_logos_orig$iOS12OrDown$SBUIAppIconForceTouchController$appIconForceTouchShortcutViewController$activateApplicationShortcutItem$(self, _cmd, arg1, item);
}





static __attribute__((constructor)) void _logosLocalCtor_7d8832b0(int __unused argc, char __unused **argv, char __unused **envp){
	
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")){
		{Class _logos_class$iOS13Up$SBIconView = objc_getClass("SBIconView"); Class _logos_metaclass$iOS13Up$SBIconView = object_getClass(_logos_class$iOS13Up$SBIconView); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'B'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSArray), strlen(@encode(NSArray))); i += strlen(@encode(NSArray)); memcpy(_typeEncoding + i, @encode(NSString), strlen(@encode(NSString))); i += strlen(@encode(NSString)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$iOS13Up$SBIconView, @selector(isInArray:item:), (IMP)&_logos_method$iOS13Up$SBIconView$isInArray$item$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSURL), strlen(@encode(NSURL))); i += strlen(@encode(NSURL)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$iOS13Up$SBIconView, @selector(generateLink:forApp:), (IMP)&_logos_method$iOS13Up$SBIconView$generateLink$forApp$, _typeEncoding); }MSHookMessageEx(_logos_class$iOS13Up$SBIconView, @selector(applicationShortcutItems), (IMP)&_logos_method$iOS13Up$SBIconView$applicationShortcutItems, (IMP*)&_logos_orig$iOS13Up$SBIconView$applicationShortcutItems);MSHookMessageEx(_logos_metaclass$iOS13Up$SBIconView, @selector(activateShortcut:withBundleIdentifier:forIconView:), (IMP)&_logos_meta_method$iOS13Up$SBIconView$activateShortcut$withBundleIdentifier$forIconView$, (IMP*)&_logos_meta_orig$iOS13Up$SBIconView$activateShortcut$withBundleIdentifier$forIconView$);} 
	} else {
		{Class _logos_class$iOS12OrDown$SBUIAppIconForceTouchControllerDataProvider = objc_getClass("SBUIAppIconForceTouchControllerDataProvider"); MSHookMessageEx(_logos_class$iOS12OrDown$SBUIAppIconForceTouchControllerDataProvider, @selector(applicationShortcutItems), (IMP)&_logos_method$iOS12OrDown$SBUIAppIconForceTouchControllerDataProvider$applicationShortcutItems, (IMP*)&_logos_orig$iOS12OrDown$SBUIAppIconForceTouchControllerDataProvider$applicationShortcutItems);Class _logos_class$iOS12OrDown$SBUIAppIconForceTouchController = objc_getClass("SBUIAppIconForceTouchController"); MSHookMessageEx(_logos_class$iOS12OrDown$SBUIAppIconForceTouchController, @selector(appIconForceTouchShortcutViewController:activateApplicationShortcutItem:), (IMP)&_logos_method$iOS12OrDown$SBUIAppIconForceTouchController$appIconForceTouchShortcutViewController$activateApplicationShortcutItem$, (IMP*)&_logos_orig$iOS12OrDown$SBUIAppIconForceTouchController$appIconForceTouchShortcutViewController$activateApplicationShortcutItem$);}
	}
}
