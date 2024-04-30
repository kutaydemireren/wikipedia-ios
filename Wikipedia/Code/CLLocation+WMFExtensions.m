#import <WMF/CLLocation+WMFExtensions.h>

@import CoreLocation;

@implementation CLLocation (WMFExtensions)

- (nullable instancetype)initWithString:(NSString *)locString {
    NSArray<NSString *> *components = [locString componentsSeparatedByString:@","];
    if (components.count != 2) {
        return nil;
    }

    NSString *lat = components[0];
    NSString *lgt = components[1];
    if (lat.length == 0 || lgt.length == 0) {
        return nil;
    }

    return [self initWithLatitude:[lat doubleValue] longitude:[lgt doubleValue]];
}

@end
