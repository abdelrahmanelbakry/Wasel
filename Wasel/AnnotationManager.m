//
//  AnnotationManager.m
//  Wasel
//
//  Created by Abdelrahman Mohamed on 4/21/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "AnnotationManager.h"

@implementation AnnotationManager

@synthesize annotations;

AnnotationManager* manager =  nil;

+(AnnotationManager*) getAnnotationManager
{
    if(manager == nil)
        manager = [[AnnotationManager alloc] init];
    
    return manager;
}

-(void) serializeAnnotations
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* path = [documentsPath stringByAppendingPathComponent:@"ann.plist"];
    // BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    [NSKeyedArchiver archiveRootObject:annotations toFile:path];
}
-(BOOL) deserializeAnnotations
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* path = [documentsPath stringByAppendingPathComponent:@"ann.plist"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if(fileExists)
    {
        annotations=[NSKeyedUnarchiver unarchiveObjectWithFile:path] ;
        return YES;
    }
    return NO;
}

-(void) deleteAnnotation:(NSNumber*) identifer
{
    for(int i=0;i<[[AnnotationManager getAnnotationManager].annotations count];i++)
    {
        AdoptingAnAnnotation* ann = (AdoptingAnAnnotation*)[[AnnotationManager getAnnotationManager].annotations objectAtIndex:i];
        if( ann.identifier == identifer )
        {
            [[AnnotationManager getAnnotationManager].annotations removeObjectAtIndex:i];
            return;
        }
    }
}
-(AdoptingAnAnnotation*) getAnnotation:(NSNumber*) identifier
{
    for(int i=0;i<[[AnnotationManager getAnnotationManager].annotations count];i++)
    {
        AdoptingAnAnnotation* ann = (AdoptingAnAnnotation*)[[AnnotationManager getAnnotationManager].annotations objectAtIndex:i];
        if( ann.identifier == identifier )
            return (AdoptingAnAnnotation*)[[AnnotationManager getAnnotationManager].annotations objectAtIndex:i];
        
    }
    return nil;
}
-(void) addToAnnotations: (AdoptingAnAnnotation*) annotation
{
    AdoptingAnAnnotation* newAnnotaion = [[AdoptingAnAnnotation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
    newAnnotaion.name = annotation.name;
    newAnnotaion.identifier = annotation.identifier;
    newAnnotaion.shouldAlert = annotation.shouldAlert;
    
    [annotations addObject:newAnnotaion];
}

@end
