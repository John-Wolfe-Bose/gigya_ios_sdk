#import "NSString+GSString.h"
#import "Base64Transcoder.h"

@implementation NSString (GSString)

- (NSString *)GSURLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[] "),
                                                                           kCFStringEncodingUTF8));
	return result;
}

- (NSString*)GSURLDecodedString
{
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8));
	return result;
}

+(NSString*)GSGUIDString
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (NSString *)CFBridgingRelease(string);
}

- (NSMutableDictionary *)GSDictionaryFromQueryComponents
{
    NSMutableDictionary *queryComponents = [NSMutableDictionary dictionary];
    for(NSString *keyValuePairString in [self componentsSeparatedByString:@"&"])
    {
        NSArray *keyValuePairArray = [keyValuePairString componentsSeparatedByString:@"="];
        if ([keyValuePairArray count] < 2) continue;
        NSString *key = [keyValuePairArray objectAtIndex:0];
        NSString *value = [keyValuePairArray objectAtIndex:1];
        NSMutableArray *results = [queryComponents objectForKey:key];
        if(!results) // First object
        {
            results = [NSMutableArray arrayWithCapacity:1];
            [queryComponents setObject:value forKey:key];
        }
        [results addObject:value];
    }
    return queryComponents;
}
@end
