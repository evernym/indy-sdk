//
//  NSError+VcxError.m
//  libindy
//

#import "NSError+VcxError.h"
#import "vcx.h"
#include "vcx.h"

static NSString *const VcxErrorDomain = @"VcxErrorDomain";

@implementation NSError (VcxError)

+ (NSError*) errorFromVcxError:(vcx_error_t) error
{
    NSMutableDictionary *userInfo = [NSMutableDictionary new];

    if (error != 0) {
        const char * error_json_p;

        NSLog(@"errorFromVcxError before vcx_get_current_error: %d", error);
        vcx_get_current_error(&error_json_p);
        NSLog(@"errorFromVcxError after vcx_get_current_error: %d", error);

        NSString *errorDetailsJson = nil;
        if (error_json_p) {
            errorDetailsJson = [NSString stringWithUTF8String:error_json_p];
        }

        NSError *error;
        NSDictionary *errorDetails = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:[errorDetailsJson UTF8String]
                                                                length:[errorDetailsJson length]]
                                                            options:kNilOptions
                                                            error: &error];

        [userInfo setValue:errorDetails[@"error"] forKey:@"sdk_message"];
        [userInfo setValue:errorDetails[@"message"] forKey:@"sdk_full_message"];
        [userInfo setValue:errorDetails[@"cause"] forKey:@"sdk_cause"];
        [userInfo setValue:errorDetails[@"backtrace"] forKey:@"sdk_backtrace"];

        for(NSString *key in [userInfo allKeys]) {
            NSLog(@"errorFromVcxError after userInfo: %@",[userInfo objectForKey:key]);
        }
    }

    return [NSError errorWithDomain:VcxErrorDomain code: error userInfo:userInfo];
}

@end
