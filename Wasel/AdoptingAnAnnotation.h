//
//  AdoptingAnAnnotation.h
//  Wasel
//
//  Created by Abdelrahman Mohamed on 4/18/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AdoptingAnAnnotation : NSObject <MKAnnotation,NSCoding>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain) NSNumber* identifier;
@property (nonatomic) BOOL shouldAlert;

- (id) initWithLatitude:(CLLocationDegrees) lat longitude:(CLLocationDegrees) lng;
-(NSString*) title;
-(void) setTitle:(NSString*) label;

@end
