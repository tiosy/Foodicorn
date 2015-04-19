//
//  FDTransaction.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//



#import "FDTransaction.h"
// Import this header to let Armor know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>
#import "FDPFUser.h"

@implementation FDTransaction


@dynamic userProfileImageNSData;
@dynamic userProfileImagePFFile;
@dynamic userName;
@dynamic dishID;
@dynamic dishImagePFFile;
@dynamic likedBy;  //each element is FDUser
@dynamic transactionType;



//@property NSData *userProfileImageNSData;
//@property NSString *userName;
//@property NSString *dishID;
//@property PFFile *dishImagePFFile;
//@property NSArray *likes;  //each element is FDUser
//@property NSString *transactionType;



+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"FDTransaction";
}

//RETRIEVE ALL LIKERS FOR DISH
//need to add dishID and set it equal to recipeID.
+(void) addTransaction:(UIImage *)userProfileImage userName:(NSString *)userName dishImage:(UIImage *)dishImage likedBy:(NSArray *)likedBy transactionType:(NSString *)transactionType{

    FDTransaction *xtran = [FDTransaction object];

    //UIImage-> NSData-> PFFile
    NSData *imageNSData = UIImagePNGRepresentation(userProfileImage);
    xtran.userProfileImageNSData = imageNSData;  // must be < 128KB
    NSString *fileWithName = xtran.objectId;
    PFFile *imagePFFile = [PFFile fileWithName:fileWithName data:imageNSData]; //use uniqe objectId as file name
    xtran.userProfileImagePFFile = imagePFFile;

    xtran.userName = userName;
    xtran.dishID = xtran.objectId;

    //UIImage-> NSData-> PFFile
    NSData *imageNSData2 = UIImagePNGRepresentation(dishImage);
    NSString *fileWithName2 = [NSString stringWithFormat:@"dishImage%@",xtran.objectId];
    PFFile *imagePFFile2 = [PFFile fileWithName:fileWithName2 data:imageNSData2]; //use uniqe objectId as file name
    xtran.dishImagePFFile = imagePFFile2;

    xtran.likedBy= likedBy;
    xtran.transactionType = transactionType;

    [xtran saveInBackground];
}


//RETRIEVE ALL DISHES THAT HAVE BEEN LIKED
// custom (^)block :-)
+ (void)retrieveFDTransactionWithCompletion:(void (^)(NSArray *))complete
{
    PFQuery *query = [FDTransaction query];

    //user in the followings[] ?

    //[query whereKey:@"username" equalTo:username];

    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.

            NSMutableArray *superTransactions = [NSMutableArray arrayWithCapacity:objects.count];
            superTransactions = [objects mutableCopy];
            complete(superTransactions);

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

// custom (^)block :-) ----retrieve Only those who I follow
+ (void)retrieveFDTransactionWithCompletion:(NSArray *)followings completionHandler:(void (^)(NSArray *))complete
{
    PFQuery *query = [FDTransaction query];

    //user in the followings[] ?

    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.

            NSMutableArray *superTransactions = [NSMutableArray new];

            //if the Dish's user is in followings, add it
            for (FDTransaction *fdTransaction in objects) {

                if([followings containsObject:fdTransaction.userName]){
                    [superTransactions addObject:fdTransaction];
                }

            }

            complete(superTransactions);

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}




@end
