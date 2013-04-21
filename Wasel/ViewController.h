//
//  ViewController.h
//  Wasel
//
//  Created by Ali Amin on 4/14/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<MapKit/MapKit.h>
#import "AdoptingAnAnnotation.h"

@interface ViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    UIAlertView* alertView;
}
@property(nonatomic,retain) UILongPressGestureRecognizer *longPressGesture ;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

-(void) setAnnotationName;
- (void)alertView:(UIAlertView *)View clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
