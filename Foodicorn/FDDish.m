//
//  FDDish.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//



#import "FDDish.h"
// Import this header to let Armor know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>

#import "FDPFUser.h"
#import "FDTransaction.h"
#import "FDUtility.h"


@implementation FDDish
@dynamic fid;
@dynamic imagePFFile;
@dynamic imageThumbnailNSData;
@dynamic comments;
@dynamic likedBy;
@dynamic user;


+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDDish";
}

+(void) addDish:(UIImage *) imageUIImage username: (NSString *) username{


    FDDish *fddish = [FDDish object];
    fddish.fid = fddish.objectId; //NSString

    //UIImage -> NSData -> PFFile
    NSData *imageNSData = UIImagePNGRepresentation(imageUIImage);
    PFFile *imagePFFile = [PFFile fileWithName:fddish.objectId data:imageNSData]; //use uniqe objectId as file name
    fddish.imagePFFile = imagePFFile;
    //UIImage ->  to Thumbnail -> NSData -> PFFile
    UIImage *imageThumbnail = [FDUtility imageWithImage:imageUIImage scaledToSize:CGSizeMake(60.0, 60.0)];
    NSData *imageThumbnailNSData = UIImagePNGRepresentation(imageThumbnail);
    fddish.imageThumbnailNSData = imageThumbnailNSData;

//    fddish.uploadedBy = username;

    [fddish saveInBackground];


    //add transaction
   // [FDTransaction addTransaction:username



}

///??? TBD
-(void) likeDish: (NSString *) username{

//
//    //self is the TUPhoto
//
//    [self addUniqueObject:username forKey:@"likedBy"];
//    [self saveInBackground];
//
//    //retrieve the TUUser who likes this TUPhoto
//    PFQuery *query = [TUUser query];
//    [query whereKey:@"username" equalTo:username];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            // The find succeeded.
//
//            //retrieve the TUPhoto
//            TUUser *tuuser = [objects firstObject];
//            [tuuser addUniqueObject:self.pid forKey:@"likes"];
//            [tuuser saveInBackground];
//
//            //add transaction
//
//
//
//
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
//
//


}


-(void) commentDish: (NSString *) uid comment:(NSString *) comment{

//    //self is the TUPhoto
//
//    [self addUniqueObject:uid forKey:@"comments"];
//    [self saveInBackground];
//
//    //adding a comment to TUComment  //i know i know...just add here instead
//    FDComment *fdcomment = [FDComment object];
//    fdcomment.uid = uid;
//    fdcomment.pid = self.pid;
//    fdcomment.pid = self.objectId;
//    fdcomment.text = comment;
//
//    [tucomment saveInBackground];
//
//    //add transaction
}



+ (void)retrieveFDDishWithCompletion:(void (^)(NSArray *))complete
{
    PFQuery *query = [FDDish query];
    //[query whereKey:@"username" equalTo:username];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.


            NSMutableArray *superDishes = [NSMutableArray arrayWithCapacity:objects.count];
            superDishes = [objects mutableCopy];
            complete(superDishes);

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end





//for (TUPhoto *tuphoto in objects) {
//    NSMutableDictionary *dic = [NSMutableDictionary new];
//    [dic  setObject:tuphoto.pid forKey:@"pid"];
//    [dic  setObject:tuphoto.imagePFFile forKey:@"imagePFfile"];
//    [dic  setObject:tuphoto.imageThumbnailNSData   forKey:@"imageThumbnailNSData"];
//    [dic  setObject:tuphoto.comments forKey:@"comments"];
//    [dic  setObject:tuphoto.likedBy forKey:@"likedBy"];
//    NSString  *numlikes = [NSString stringWithFormat:@"%ld", tuphoto.likedBy.count];
//    [dic  setObject:numlikes forKey:@"numLikes"];
//    [dic  setObject:tuphoto.uploadedBy forKey:@"uploadedBy"];
//    [dic  setObject:tuphoto.createdAt forKey:@"createdAt"];
//
//
//    [superPictures addObject:dic];
//}

//NSMutableArray *pictures = [NSMutableArray new];
//for (TUPhoto *tuphoto in objects) {
//
//    //retrieving image from Parse
//    PFFile *imagePFile = tuphoto.imagePFFile;
//    [imagePFile getDataInBackgroundWithBlock:^(NSData *imageNSData, NSError *error) {
//        if (!error) {
//            UIImage *img = [UIImage imageWithData:imageNSData];
//
//            NSMutableDictionary *dic = [NSMutableDictionary new];
//
//            [dic  setObject:img forKey:@"picture"];
//            [dic  setObject:tuphoto.uploadedBy forKey:@"username"];
//            [dic  setObject:tuphoto.createdAt forKey:@"time"];
//            NSString  *numlikes = [NSString stringWithFormat:@"%ld", tuphoto.likedBy.count];
//            [dic  setObject:numlikes forKey:@"numLikes"];
//            [dic setObject:tuphoto.comments forKey:@"comments"];
//
//            [pictures addObject:dic];
//
//            NSLog(@"===%ld",pictures.count);
//        }
//    }];
//}
//
//complete(pictures);
//

