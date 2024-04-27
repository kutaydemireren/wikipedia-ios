#import <XCTest/XCTest.h>
#import "CLLocation+WMFExtensions.h"

@interface CLLocation_WMFExtensions_Tests : XCTestCase
@end

@implementation CLLocation_WMFExtensions_Tests

- (void)testInitWithEmptyStringReturnsNil {
    CLLocation *loc = [[CLLocation alloc] initWithString:@""];
    XCTAssertNil(loc, @"Location must be nil for an empty string.");
}

- (void)testInitWithInvalidStringReturnsNil {
    CLLocation *loc = [[CLLocation alloc] initWithString:@"an invalid string"];
    XCTAssertNil(loc, @"Location must be nil for an invalid string.");
}

- (void)testInitWithMissingStringReturnsNil {
    CLLocation *loc = [[CLLocation alloc] initWithString:@"52.35,"];
    XCTAssertNil(loc, @"Location must be nil for a missing string.");
}

- (void)testInitWithValidString {
    CLLocation *loc = [[CLLocation alloc] initWithString:@"52.35,4.88"];
    XCTAssertEqual(loc.coordinate.latitude, 52.35, @"Latitude must be set as expected for a valid string.");
    XCTAssertEqual(loc.coordinate.longitude, 4.88, @"Longitude must be set as expected for a valid string.");
}
@end
