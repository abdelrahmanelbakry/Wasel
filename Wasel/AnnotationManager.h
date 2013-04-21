//
//  AnnotationManager.h
//  Wasel
//
//  Created by Abdelrahman Mohamed on 4/21/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdoptingAnAnnotation.h"

@interface AnnotationManager : NSObject

@property(nonatomic,retain) NSMutableArray* annotations;

+(AnnotationManager*) getAnnotationManager;
-(void) serializeAnnotations;
-(BOOL) deserializeAnnotations;
-(void) addToAnnotations: (AdoptingAnAnnotation*) annotation;
-(void) deleteAnnotation:(NSNumber*) identifer;
-(AdoptingAnAnnotation*) getAnnotation:(NSNumber*) identifier;

@end
