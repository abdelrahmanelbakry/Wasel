//
//  ViewController.h
//  Wasel
//
//  Created by Ali Amin on 4/14/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "FavoritesTableViewController.h"
#import "AnnotationManager.h"

@interface ViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,CLLocationManagerDelegate>
{
    UIAlertView* alertView;
    AdoptingAnAnnotation *droppedPin;
    UIScrollView* scrollView;
    UIPageControl* pageControl;
    BOOL pageControlBeingUsed;
    UIView* searchView;
    BOOL searchViewVisible;
    double degree,minutes,seconds,degreelat,minuteslat,secondslat;
    CLLocationManager *locationManager;
}
@property(nonatomic,retain) UILongPressGestureRecognizer *longPressGesture ;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) IBOutlet UIView* searchView;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property(nonatomic,retain) IBOutlet UIWebView* webView;
-(IBAction) toggleSearchArea;
-(void) setAnnotationName;
- (void)alertView:(UIAlertView *)View clickedButtonAtIndex:(NSInteger)buttonIndex;
- (IBAction)changePage;
-(IBAction) search:(id) sender;
-(BOOL) isPad;
-(IBAction)textFieldReturn:(id)sender;
-(void) getCurrentLongLat:(id)sender;
-(IBAction) showFavorites:(id) sender;
-(IBAction) showAbout:(id) sender;

@end
