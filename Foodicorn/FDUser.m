//
//  FDUser.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//



#import "FDUser.h"

// Import this header to let Armor know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>
#import "FDUtility.h"

@implementation FDUser

@dynamic uid;
@dynamic username;
@dynamic fullName;
@dynamic profileThumbnailPFFile;
@dynamic profileThumbnailNSData;
@dynamic followers;
@dynamic followings;
@dynamic likes;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDUser";
}



//add a user
-(void) addUser:(FDUser *) user  username:(NSString *)username fullname:(NSString *) fullname{

    //FDUser *user = [FDUser object];
    user.uid = user.objectId;
    user.username   =   username;
    user.fullName   =   fullname;

    [user saveInBackground];
}

//add user profile image
+(void) addUserProfileImage:(NSString *)username userProfileImage: (UIImage *) userProfileImage {

    //retrieve the FDUser first
    PFQuery *query = [FDUser query];
    [query whereKey:@"username" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.

            //retrieve the FDUser
            FDUser *fduser = [objects firstObject];

            NSLog(@"%@", fduser.username);

            //UIImage ->  to Thumbnail -> NSData -> PFFile
            UIImage *imageThumbnail = [FDUtility imageWithImage:userProfileImage scaledToSize:CGSizeMake(30.0, 30.0)];
            NSData *imageNSData = UIImagePNGRepresentation(imageThumbnail);
            fduser.profileThumbnailNSData = imageNSData;
            PFFile *imagePFFile = [PFFile fileWithName:fduser.objectId data:imageNSData]; //use uniqe objectId as file name
            fduser.profileThumbnailPFFile = imagePFFile;

            [fduser saveInBackground];

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}




-(void) addFollowing: (FDUser *) followingFDUser{

}


//-(void) addFollowing: (NSString *) currentUID followingUID:(NSString *) uid{
//
//    if(self)
//    {
//        [self addUniqueObject:uid forKey:@"followings"];
//        [self saveInBackground];
//
//        //now write follower(aka currentUID) to uid
//        //retrieve the FDUser
//        PFQuery *query = [FDUser query];
//        [query whereKey:@"uid" equalTo:uid];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (!error) {
//                // The find succeeded.
//
//                //retrieve the fduser
//                FDUser *fduser = [objects firstObject];
//                [fduser addUniqueObject:currentUID forKey:@"followers"];
//                [fduser saveInBackground];
//
//                //add transaction
//
//
//
//
//            } else {
//                // Log details of the failure
//                NSLog(@"Error: %@ %@", error, [error userInfo]);
//            }
//        }];
//        
//        
//    }
//    
//}






@end
