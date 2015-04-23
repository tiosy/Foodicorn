//
//  TYUtility.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "FDUtility.h"

@implementation FDUtility

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}

+(NSString *) timeSince:(NSDate *) dateCreatedAt{

    NSDate *now = [NSDate date];
    //createdAt:"2011-06-10T18:33:42Z"
    //NSDate *date2 = transaction.createdAt;
    NSString *timeSinceString;
    NSTimeInterval distanceBetweenDates = [now timeIntervalSinceDate:dateCreatedAt];
    double secondsInAnHour = 3600;
    double minsInAnHour = 60;
    NSInteger minsBetweenDates = distanceBetweenDates / minsInAnHour;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    if (minsBetweenDates >= 60) {
        if(hoursBetweenDates>=24){
            NSInteger daysBetweenDates = hoursBetweenDates / 24;
            timeSinceString = [NSString stringWithFormat:@"%dd",(int)ceilf(daysBetweenDates)];
        } else{
            timeSinceString = [NSString stringWithFormat:@"%dh",(int)ceilf(hoursBetweenDates)];
        }
    }else{
        timeSinceString = [NSString stringWithFormat:@"%dm",(int)minsBetweenDates];
    }

    return timeSinceString;


}


@end
