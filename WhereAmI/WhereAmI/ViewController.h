//
//  ViewController.h
//  WhereAmI
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic) IBOutlet UILabel *latitudeLabel;
@property (nonatomic) IBOutlet UILabel *longitudeLabel;
@property (nonatomic) IBOutlet UILabel *horizontalAccuracyLabel;
@property (nonatomic) IBOutlet UILabel *altitudeLabel;
@property (nonatomic) IBOutlet UILabel *verticalAccuracyLabel;
@property (nonatomic) IBOutlet UILabel *distanceTavelLabel;
@property (nonatomic) IBOutlet MKMapView *mapView;


@end

