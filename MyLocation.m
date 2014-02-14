#import "MyLocation.h"

@implementation MyLocation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        self.name = name; 
        self.address = address;
        self.coordinate = coordinate;
        
    }
    return self;
}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.address;
}



@end