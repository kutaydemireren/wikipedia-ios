#import <XCTest/XCTest.h>
#import "NSUserActivity+WMFExtensions.h"


@interface NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test : XCTestCase
@end

@implementation NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test

- (void)testURLWithoutWikipediaSchemeReturnsNil {
    NSURL *url = [NSURL URLWithString:@"http://www.foo.com"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testInvalidArticleURLReturnsNil {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testArticleURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/wiki/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, @"https://en.wikipedia.org/wiki/Foo");
}

- (void)testExploreURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://explore"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeExplore);
}

- (void)testPlacesURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertNil(activity.webpageURL.absoluteString);
}

- (void)testPlacesURLWithArticleURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?WMFArticleURL=https://en.wikipedia.org"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, @"https://en.wikipedia.org");
}

- (void)testPlacesURLWithLocation {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?loc=52.35,4.88"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.userInfo[@"WMFLocation"], @"52.35,4.88");
}

- (void)testPlacesURLWithLocationEmpty {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?loc="];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.userInfo[@"WMFLocation"], NULL);
}

- (void)testHistoryURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://history"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeHistory);
}

- (void)testSavedURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://saved"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeSavedPages);
}

- (void)testSearchURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/w/index.php?search=dog"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString,
                          @"https://en.wikipedia.org/w/index.php?search=dog&title=Special:Search&fulltext=1");
}

@end

// TODO: Move
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
