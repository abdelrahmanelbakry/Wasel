//
//  AdoptingAnAnnotation.m
//  Wasel
//
//  Created by Abdelrahman Mohamed on 4/18/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "AdoptingAnAnnotation.h"



@implementation AdoptingAnAnnotation
@synthesize coordinate;
@synthesize name;
@synthesize identifier;
@synthesize isFav;

#define kFav @"isfav"
#define kName @"name"
#define kLong @"longtiude"
#define kLat @"latitude"
#define kIdentifier @"identifier"
//@synthesize latitude;
//@synthesize longitude;

- (id) initWithLatitude:(CLLocationDegrees) lat longitude:(CLLocationDegrees) lng {
    coordinate.latitude = lat;
    coordinate.longitude = lng;
    return self;
}
- (CLLocationCoordinate2D) coordinate {
    CLLocationCoordinate2D coord = {coordinate.latitude, coordinate.longitude};
    return coord;
}
-(NSString*) title
{
    return name;
}

-(void) setTitle:(NSString *)label
{
    name = label;
}

//
- (void) encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeObject:name forKey:kName];
    [encoder encodeObject:identifier forKey:kIdentifier];
    [encoder encodeFloat:coordinate.longitude forKey:kLong ];//:coordinate forKey:kCoord];
    [encoder encodeFloat:coordinate.latitude forKey:kLat];
    [encoder encodeBool:isFav forKey:kFav];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        // If parent class also adopts NSCoding, replace [super init]
        // with [super initWithCoder:decoder] to properly initialize.
        name = [decoder decodeObjectForKey:kName];
        identifier = [ decoder decodeObjectForKey:kIdentifier];
        isFav = [decoder decodeBoolForKey:kFav];
        float lat = [decoder decodeFloatForKey:kLat];
        float lang = [decoder decodeFloatForKey:kLong];
        coordinate.latitude = lat;
        coordinate.longitude = lang;
        
        
    }
    
    return self;
}
@end
