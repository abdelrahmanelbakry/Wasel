//
//  ViewController.m
//  Wasel
//
//  Created by Ali Amin on 4/14/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ViewController.h"
#import "time.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize longPressGesture;
@synthesize mapView;
@synthesize scrollView;
@synthesize pageControl;
@synthesize searchView;
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
    pageControlBeingUsed = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = 3;
	// Do any additional setup after loading the view, typically from a nib.
    self->searchViewVisible = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:@"UIKeyboardDidHideNotification"
                                               object:nil];
    
    //Set a timer to update the clock
    [NSTimer scheduledTimerWithTimeInterval:1800
                                     target:self
                                   selector:@selector(getCurrentLongLat:)
                                   userInfo:nil
                                    repeats:YES];
    
    degreelat=0;degree=0;minutes=0;minuteslat=0;seconds=0;secondslat=0;
    
}
-(BOOL) isPad
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    return NO;
}

- (void) keyboardWillShow:(NSNotification *)note
{
    NSDictionary *userInfo = [note userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    NSLog(@"Keyboard Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // move the view up by 30 pts
    CGRect frame = self.searchView.frame;
    if([self isPad])
        frame.origin.y -= 264;
    else
        frame.origin.y -= 216;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.searchView.frame = frame;
    }];
}
- (void) keyboardDidHide:(NSNotification *)note
{
    
    // move the view back to the origin
    CGRect frame = self.searchView.frame;
    if([self isPad])
        frame.origin.y += 264;
    else
        frame.origin.y += 216;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.searchView.frame = frame;
    }];
}
-(IBAction) toggleSearchArea
{
    if(self->searchViewVisible)
    {
        CGRect basketTopFrame = self.searchView.frame;
        basketTopFrame.origin.y += basketTopFrame.size.height - 25;
        
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.searchView.frame = basketTopFrame;
                         }
                         completion:^(BOOL finished){
                         }];
        self->searchViewVisible = NO;
    }
    else
    {
        self->searchViewVisible = YES;
        CGRect basketTopFrame = self.searchView.frame;
        basketTopFrame.origin.y -= basketTopFrame.size.height -25;
        
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.searchView.frame = basketTopFrame;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}
-(IBAction) search:(id) sender
{
    [self.view endEditing:YES];
    UIButton* btnSearch = (UIButton*) sender;
    UITextField* myControl;
    
    
    switch (btnSearch.tag)
    {
        case 1:
        {
            [self.mapView setHidden:YES];
            [self.webView setHidden:NO];
            
            myControl = (UITextField*)[self.view viewWithTag:11];
            if(myControl.text.length>0) //Then the user has entered some text
                degree = [myControl.text intValue];
            
            myControl = (UITextField*)[self.view viewWithTag:12];
            if(myControl.text.length>0) //Then the user has entered some text
                minutes = [myControl.text intValue];
            
            myControl = (UITextField*)[self.view viewWithTag:13];
            if(myControl.text.length>0) //Then the user has entered some text
                seconds = [myControl.text intValue];
            
            [self.webView setDelegate:self];
            
            NSString *urlAddress = [NSString stringWithFormat:@"https://maps.google.com/maps?q=%i.%i.%i",(int)degree,(int)minutes,(int)seconds];
            NSURL *url = [NSURL URLWithString:urlAddress];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:requestObj];
            
            break;
        }
        case 2:
            [self.mapView setHidden:NO];
            [self.webView setHidden:YES];
            
            myControl = (UITextField*)[self.view viewWithTag:21];
            if(myControl.text.length>0) //Then the user has entered some text
            {
                //Check if the user has entered the text separated by comma
                NSRange range = [myControl.text rangeOfString:@","];
                if (range.location != NSNotFound)
                {
                    //Now we have to separate the data entered
                    NSArray* data = [myControl.text componentsSeparatedByString:@","];
                  
                    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[NSString stringWithFormat:@"%@",[data objectAtIndex:0]] doubleValue], [[NSString stringWithFormat:@"%@",[data objectAtIndex:1]] doubleValue]);
                    //Navigate only if it is a valid co-ordinate
                    if(CLLocationCoordinate2DIsValid(coord))
                        [self.mapView setCenterCoordinate:coord animated:YES];
                }
            }
            break;
            
        case 3:
            [self.mapView setHidden:NO];
            [self.webView setHidden:YES];
            myControl = (UITextField*)[self.view viewWithTag:31];
            if(myControl.text.length>0) //Then the user has entered some text
                degree = [myControl.text doubleValue];
            
            myControl = (UITextField*)[self.view viewWithTag:32];
            if(myControl.text.length>0) //Then the user has entered some text
                minutes = [myControl.text doubleValue];
            
            myControl = (UITextField*)[self.view viewWithTag:33];
            if(myControl.text.length>0) //Then the user has entered some text
                seconds = [myControl.text doubleValue];
            
            myControl = (UITextField*)[self.view viewWithTag:34];
            if(myControl.text.length>0) //Then the user has entered some text
                degreelat = [myControl.text doubleValue];
            
            myControl = (UITextField*)[self.view viewWithTag:35];
            if(myControl.text.length>0) //Then the user has entered some text
                minuteslat = [myControl.text doubleValue];
            
            myControl = (UITextField*)[self.view viewWithTag:36];
            if(myControl.text.length>0) //Then the user has entered some text
                secondslat = [myControl.text doubleValue];
            double totalSeconds = (minutes*60)+ seconds;
            double frac = totalSeconds/3600;
            degree+=frac;
            degree*= -1;
            
            double totalSecondslat = (minuteslat*60)+ secondslat;
            double fraclat = totalSecondslat/3600;
            degreelat+=fraclat;
            degreelat*= -1;
            
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(degree, degreelat);
            //Navigate only if it is a valid co-ordinate
            if(CLLocationCoordinate2DIsValid(coord))
                [self.mapView setCenterCoordinate:coord animated:YES];
            
            break;
    }
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
        //droppedPin.shouldAlert = YES;
        
        [self setAnnotationName];
       
        
       // dropPin.coordinate.latitude = [NSNumber numberWithDouble:locCoord.latitude];
       // dropPin.coordinate.longitude = [NSNumber numberWithDouble:locCoord.longitude];
    }
}
-(void) setAnnotationName
{
    
    alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ادخل اسم لامكان", @"") message:@"" delegate:self cancelButtonTitle:@"الغاء" otherButtonTitles:NSLocalizedString(@"موافق", @""), nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [[alertView textFieldAtIndex:0] setDelegate:self];
   // [[alertView textFieldAtIndex:0] setText:[AddAlarmTableViewController getAlarmData].alarmBody];
    alertView.tag=2;
    [alertView show];
    
}
-(void) setShouldAlert
{
    alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"هل تريد التنبيه عند الاقتراب", @"") message:@"" delegate:self cancelButtonTitle:@"لا" otherButtonTitles:NSLocalizedString(@"موافق", @""), nil];
    [alertView setAlertViewStyle:UIAlertViewStyleDefault];
    // [[alertView textFieldAtIndex:0] setText:[AddAlarmTableViewController getAlarmData].alarmBody];
    alertView.tag=2;
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
        
        droppedPin.name = enteredtext;
        [self.mapView addAnnotation:droppedPin];
        [self setShouldAlert];
       //
       // [AddAlarmTableViewController getAlarmData].alarmBody = enteredtext;
      //  [alarmBodyLabel setText:enteredtext];
    }
    if(buttonIndex == 1 && View.tag == 2)
        droppedPin.shouldAlert = YES;
    else if(buttonIndex == 2 && View.tag == 2)
        droppedPin.shouldAlert = NO;
    if(View.tag==2)
    {
        long key = time(NULL);
        droppedPin.identifier = [NSNumber numberWithLong:key];
       [[AnnotationManager getAnnotationManager]addToAnnotations:droppedPin];
    }
    
}

-(IBAction) showFavorites:(id) sender
{
    //FavoritesController
    FavoritesTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoritesController"];
    [self presentViewController:vc animated:YES completion:nil];

}
-(IBAction) showAbout:(id) sender
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}
- (IBAction)changePage
{
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(page!=0)
    {
        [self.mapView setHidden:NO];
        [self.webView setHidden:YES];
    }
    
    self.pageControl.currentPage = page;
}
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
- (void)viewDidUnload
{
    [self setMapView:nil];
    self.scrollView = nil;
	self.pageControl = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

-(void) getCurrentLongLat:(id)sender
{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"خطأ" message:@"تعذر محاولة الوصول الي موقعك الحالي" delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [locationManager stopUpdatingLocation];
    UIApplication *app = [UIApplication sharedApplication];

    NSLog(@"didUpdateToLocation: %@", newLocation);
    
    for(int i=0;i<[[[AnnotationManager getAnnotationManager] annotations] count];i++)
    {
        AdoptingAnAnnotation* ann = [[[AnnotationManager getAnnotationManager] annotations] objectAtIndex:i];
        if(ann.shouldAlert)
        {
            if(ann.coordinate.latitude-newLocation.coordinate.latitude <2)
            {
                if(ann.coordinate.longitude-newLocation.coordinate.longitude <2)
                {
                    //Schedule a Local Notification
                    NSDate* currentDate = [NSDate date];
                    NSDateComponents* comp =  [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit|NSTimeZoneCalendarUnit fromDate:currentDate ];
                    //Create a New Notification
                    UILocalNotification* alarmNotification = [[UILocalNotification alloc] init];
                    
                    alarmNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:60];
                    
                    alarmNotification.timeZone = [comp timeZone];//[NSTimeZone defaultTimeZone];
                    //alarmNotification.repeatInterval = alarm.snoozeInterval;
                    alarmNotification.soundName = UILocalNotificationDefaultSoundName;
                    alarmNotification.alertBody = [NSString stringWithFormat:@"أنت تقترب من %@", ann.name];
                    
                    alarmNotification.hasAction =YES;
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    
                    [app scheduleLocalNotification:alarmNotification];
                }
            }
        }
    }
    

    
}

@end
