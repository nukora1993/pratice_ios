//
//  ViewController.m
//  WhereAmI
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import "Place.h"
@interface ViewController ()

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *previousPoint;
@property (nonatomic) CLLocationDistance totalMovementDistance;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.totalMovementDistance = 0;
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"Authorization status changed to %d", status);
    
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            
            [self.locationManager startUpdatingLocation];
            
            self.mapView.showsUserLocation = YES;
            break;
            
        default:
            [self.locationManager stopUpdatingLocation];
            
            self.mapView.showsUserLocation = NO;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSString *errorType = error.code == kCLErrorDenied ? @"Access Denied" : [NSString stringWithFormat:@"Error %ld", error.code];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Manager Error" message:errorType preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = locations.lastObject;
    if (newLocation) {
        NSString *latitudeString = [NSString stringWithFormat:@"%g \u00B0", newLocation.coordinate.latitude];
        self.latitudeLabel.text = latitudeString;
        
        NSString *longitudeString = [NSString stringWithFormat:@"%g \u00B0", newLocation.coordinate.longitude];
        self.longitudeLabel.text = longitudeString;
        
        NSString *horizontalAccuracyString = [NSString stringWithFormat:@"%g m", newLocation.horizontalAccuracy];
        self.horizontalAccuracyLabel.text = horizontalAccuracyString;
        
        NSString *altitudeString = [NSString stringWithFormat:@"%g m", newLocation.altitude];
        self.altitudeLabel.text = altitudeString;
        
        NSString *verticalAccuracyString = [NSString stringWithFormat:@"%g m", newLocation.verticalAccuracy];
        self.verticalAccuracyLabel.text = verticalAccuracyString;
        
        if (newLocation.horizontalAccuracy < 0) {
            return;
        }
        
        if (newLocation.horizontalAccuracy > 100) {
            return;
        }
        
        if (!self.previousPoint) {
            self.totalMovementDistance = 0;
            
            Place *start = [[Place alloc] initWithTitle:@"Start Point" WithSubtitle:@"This is where we started" WithCoordinate:newLocation.coordinate];
            
            [self.mapView addAnnotation:start];
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100);
            
            [self.mapView setRegion:region];
            
            
        }else{
            NSLog(@"movement distance: "
                  "%f ", [newLocation distanceFromLocation:self.previousPoint]);
            
            self.totalMovementDistance += [newLocation distanceFromLocation:self.previousPoint];
            
        }
        
        self.previousPoint = newLocation;
        
        NSString *distanceString = [NSString stringWithFormat:@"%g m", self.totalMovementDistance];
        self.distanceTavelLabel.text = distanceString;
        
        
    }
}


@end
