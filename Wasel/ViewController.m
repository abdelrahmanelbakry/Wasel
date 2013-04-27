//
//  ViewController.m
//  Wasel
//
//  Created by Ali Amin on 4/14/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize longPressGesture;
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)sender
{
    // This is important if you only want to receive one tap and hold event
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateChanged)
        return;
    else
    {
        // Here we get the CGPoint for the touch and convert it to latitude and longitude coordinates to display on the map
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        
        // Then all you have to do is create the annotation and add it to the map
        droppedPin = [[AdoptingAnAnnotation alloc] initWithLatitude:locCoord.latitude longitude:locCoord.longitude];
        droppedPin.isFav = YES;
        
        [self setAnnotationName];
       
        
       // dropPin.coordinate.latitude = [NSNumber numberWithDouble:locCoord.latitude];
       // dropPin.coordinate.longitude = [NSNumber numberWithDouble:locCoord.longitude];
    }
}
-(void) setAnnotationName
{
    
    alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Enter Place Name", @"") message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [[alertView textFieldAtIndex:0] setDelegate:self];
   // [[alertView textFieldAtIndex:0] setText:[AddAlarmTableViewController getAlarmData].alarmBody];
    alertView.tag=1;
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)View clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(buttonIndex == 1 && View.tag == 1)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString* enteredtext = textField.text;
        if([enteredtext isEqualToString:@""])
            enteredtext = @"No Label";
        
        [self.mapView addAnnotation:droppedPin];

       // [AddAlarmTableViewController getAlarmData].alarmBody = enteredtext;
      //  [alarmBodyLabel setText:enteredtext];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}
@end
