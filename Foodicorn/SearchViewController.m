//
//  SearchViewController2.m
//  Foodicorn
//
//  Created by Justin Haar on 4/14/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "SearchViewController.h"
#import "JustinViewController.h"
#import "UserProfileViewController.h"
#import "ProfileViewController.h"
#import "FDPFUser.h"
#import "Yummly.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *allowedAllergies;
@property NSArray *allowedDiets;
@property NSArray *allowedCuisines;
@property NSArray *allowedCourses;
@property NSArray *allowedHolidays;
@property NSArray *allowedAllergiesStringsArray;//parallel array to add to allowed allergies
@property NSArray *allowedDietsStringsArray;
@property NSArray *allowedCuisinesStringsArray;
@property NSArray *allowedCoursesStringsArray;
@property NSArray *allowedHolidaysStringsArray;
@property NSMutableArray *stringsArray;
@property NSString *urlText;
@property NSMutableArray *cellSelectedArray;
@property NSArray *usersArray;
@property (nonatomic)  NSMutableArray *filteredUsersArray;
@property (unsafe_unretained, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) CGFloat lastContentOffsetY;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;
@property (weak, nonatomic) IBOutlet UIButton *getRecipesButton;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlText = @"";
    self.stringsArray = [NSMutableArray new];
    self.cellSelectedArray = [NSMutableArray new];
    self.title = @"Search";
    self.getRecipesButton.enabled = NO;


    //TODO: Cut down number of arrays. Very difficult to manage multiple arrays in this fashion, would be better off using array of arrays. EX: NSArray *someArray = @[@[], @[], @[]];


    //TODO: Need common custom object class that will be used for all of these selections. Name? possibly SelectionObject. Properties: NSString *name, NSString *urlString, NSNumber *type.

    //TODO: create Plist to house all of this data to be pulled at run time, cut out all of this storage from this VC.


    //TODO: Make custom NSObjects that have a display name property (NSString) that will be the correct value from allowedAllergies. Second property of urlString (NSString) that will be the correct value from allowedAllergiesStringsArray. This will make one array where we were currently using two.
    self.allowedAllergies = [NSArray arrayWithObjects:@"Dairy-free", @"Egg-free", @"Gluten-free", @"Peanut-free", @"Seafood-free", @"Sesame-free", @"Soy-free", @"Sulfite-free", @"Tree nut-free", @"Wheat-free", nil];
    self.allowedAllergiesStringsArray = [NSArray arrayWithObjects:@"&allowedAllergy[]=396^Dairy-Free", @"&allowedAllergy[]=397^Egg-Free", @"&allowedAllergy[]=393^Gluten-Free", @"&allowedAllergy[]=394^Peanut-Free", @"&allowedAllergy[]=398^Seafood-Free", @"&allowedAllergy[]=399^Sesame-Free", @"&allowedAllergy[]=400^Soy-Free", @"&allowedAllergy[]=401^Sulfite-Free", @"&allowedAllergy[]=395^Tree+Nut-Free", @"&allowedAllergy[]=392^Wheat-Free", nil];

    //TODO:
    self.allowedDiets = [NSArray arrayWithObjects:@"Lacto vegetarian", @"Ovo vegetarian", @"Pescetarian", @"Vegan", @"Lacto-ovo Vegetarian", nil];
    self.allowedDietsStringsArray = [NSArray arrayWithObjects:@"&allowedDiet[]=388^Lacto+vegetarian", @"&allowedDiet[]=389^Ovo+vegetarian", @"&allowedDiet[]=390^Pescetarian", @"&allowedDiet[]=386^Vegan", @"&allowedDiet[]=387^Lacto-ovo+vegetarian", nil];

    self.allowedCuisines = [NSArray arrayWithObjects:@"American", @"Italian", @"Asian", @"Mexican", @"Southern & Soul Food", @"French", @"Southwestern", @"Barbecue", @"Indian", @"Chinese", @"Cajun & Creole", @"English", @"Mediterranean", @"Greek", @"Spanish", @"German", @"Thai", @"Moroccan", @"Irish", @"Japanese", @"Cuban", @"Hawaiin", @"Swedish", @"Hungarian", @"Portugese", nil];
    self.allowedCuisinesStringsArray = [NSArray arrayWithObjects:@"&allowedCuisine[]=cuisine^cuisine-american", @"&allowedCuisine[]=cuisine^cuisine-italian", @"&allowedCuisine[]=cuisine^cuisine-asian", @"&allowedCuisine[]=cuisine^cuisine-mexican", @"&allowedCuisine[]=cuisine^cuisine-southern", @"&allowedCuisine[]=cuisine^cuisine-french", @"&allowedCuisine[]=cuisine^cuisine-southwestern", @"&allowedCuisine[]=cuisine^cuisine-barbecue", @"&allowedCuisine[]=cuisine^cuisine-indian", @"&allowedCuisine[]=cuisine^cuisine-chinese", @"&allowedCuisine[]=cuisine^cuisine-cajun", @"&allowedCuisine[]=cuisine^cuisine-english", @"&allowedCuisine[]=cuisine^cuisine-mediterranean", @"&allowedCuisine[]=cuisine^cuisine-greek", @"&allowedCuisine[]=cuisine^cuisine-spanish", @"&allowedCuisine[]=cuisine^cuisine-german", @"&allowedCuisine[]=cuisine^cuisine-thai", @"&allowedCuisine[]=cuisine^cuisine-moroccan", @"&allowedCuisine[]=cuisine^cuisine-irish", @"&allowedCuisine[]=cuisine^cuisine-japanese", @"&allowedCuisine[]=cuisine^cuisine-cuban", @"&allowedCuisine[]=cuisine^cuisine-hawaiin", @"&allowedCuisine[]=cuisine^cuisine-swedish", @"&allowedCuisine[]=cuisine^cuisine-hungarian", @"&allowedCuisine[]=cuisine^cuisine-portugese", nil];

    self.allowedCourses = [NSArray arrayWithObjects:@"Main Dishes", @"Desserts", @"Side Dishes", @"Lunch and Snacks", @"Appetizers", @"Salads", @"Breads", @"Breakfast and Brunch", @"Soups", @"Beverages", @"Condiments and Sauces", @"Cocktails", nil];
    self.allowedCoursesStringsArray = [NSArray arrayWithObjects:@"&allowedCourse[]=course^course-Main+Dishes", @"&allowedCourse[]=course^course-Desserts", @"&allowedCourse[]=course^course-Side+Dishes", @"&allowedCourse[]=course^course-Lunch+And+Snacks", @"&allowedCourse[]=course^course-Appetizers", @"&allowedCourse[]=course^course-Salads", @"&allowedCourse[]=course^course-Breads", @"&allowedCourse[]=course^course-Breakfast+And+Brunch", @"&allowedCourse[]=course^course-Soups", @"&allowedCourse[]=course^course-Beverages", @"&allowedCourse[]=course^course-Condiments+And+Sauces", @"&allowedCourse[]=course^course-Cocktails", nil];

    self.allowedHolidays = [NSArray arrayWithObjects:@"Christmas", @"Summer", @"Thanksgiving", @"New Year", @"Super Bowl / Game+Day", @"Halloween", @"Hanukkah", @"4th of July", nil];
    self.allowedHolidaysStringsArray = [NSArray arrayWithObjects:@"&allowedHoliday[]=holiday^holiday-christmas", @"&allowedholiday[]=holiday^holiday-summer", @"&allowedHoliday[]=holiday^holiday-thanksgiving", @"&allowedHoliday[]=holiday^holiday-new+year", @"&allowedHoliday[]=holiday^holiday-super-bowl", @"&allowedHoliday[]=holiday^holiday-halloween", @"&allowedHoliday[]=holiday^holiday-hanukkah", @"&allowedHoliday[]=holiday^holiday-4th+of+july", nil];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void)viewDidAppear:(BOOL)animated
{

    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        [super viewDidAppear:animated];
        [self.stringsArray removeAllObjects];
        [self.cellSelectedArray removeAllObjects];
        self.searchBar.placeholder = @"Enter Recipe Keyword";

        [self.tableView reloadData];

        self.searchBar.text = @"";
        self.getRecipesButton.enabled = NO;
    

    }else if (self.segmentedControl.selectedSegmentIndex == 1)
    {
        [super viewDidAppear:animated];
        [self.filteredUsersArray removeAllObjects];
        self.searchBar.placeholder = @"Search Users";
        [self.tableView reloadData];
        self.searchBar.text = @"";
        self.getRecipesButton.hidden = YES;
    }

}

-(void)setFilteredUsersArray:(NSMutableArray *)filteredUsersArray
{
    _filteredUsersArray = filteredUsersArray;
    [self.tableView reloadData];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return @"Select Any Allergies";
    }
    else if (section == 1) {
        return @"Select Any Diets";
    }
    else if (section == 2) {
        return @"Select Any Cuisines";
    }
    else if (section == 3) {
        return @"Select Any Courses";
    }
    else {
        return @"Select Any Holidays";
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        return 30.0f;
    }else
    {
        return 0;
    }
}


- (IBAction)segmentedControlIndexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.searchBar.placeholder = @"Enter Recipe Keyword";
            self.getRecipesButton.hidden = NO;
            [self.tableView reloadData];
            break;
        case 1:
            self.searchBar.placeholder = @"Search Users";
            self.getRecipesButton.hidden = YES;
            [self.tableView reloadData];
        default:
            break;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];

    if (self.segmentedControl.selectedSegmentIndex == 0) {

        if ([self.cellSelectedArray containsObject:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }


        if (indexPath.section == 0)
        {
            cell.textLabel.text = self.allowedAllergies[indexPath.row];
            cell.imageView.image = nil;

        } else if (indexPath.section == 1)
        {
            cell.textLabel.text = self.allowedDiets[indexPath.row];
            cell.imageView.image = nil;

        } else if (indexPath.section == 2)
        {
            cell.textLabel.text = self.allowedCuisines[indexPath.row];
            cell.imageView.image = nil;

        } else if (indexPath.section == 3)
        {
            cell.textLabel.text = self.allowedCourses[indexPath.row];
            cell.imageView.image = nil;

        } else
        {
            cell.textLabel.text = self.allowedHolidays[indexPath.row];
            cell.imageView.image = nil;
        }
    } else if (self.segmentedControl.selectedSegmentIndex == 1)
    {
        FDPFUser *user = self.filteredUsersArray[indexPath.row];
        cell.textLabel.text = user.username;

        PFFile *userImageFile = user.profileThumbnailPFFile;
        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error)
         {
             if (!error) {
                 UIImage *userImage = [UIImage imageWithData:imageData];
                 cell.imageView.image = userImage;
                 cell.imageView.layer.borderColor = [UIColor colorWithRed:87/255.0 green:215/255.0 blue:255/255.0 alpha:2].CGColor;
                 cell.imageView.layer.borderWidth = 1.0f;
                 cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
                 cell.imageView.layer.masksToBounds = YES;
             }
         }];

    }

    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        return 5;
    } else
    {
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        if (section == 0)
        {
            return self.allowedAllergies.count;
        } else if (section == 1)
        {
            return self.allowedDiets.count;
        }else if (section == 2)
        {
            return self.allowedCuisines.count;
        }else if (section == 3)
        {
            return self.allowedCourses.count;
        }else
        {
            return self.allowedHolidays.count;
        }
    }else
    {
        return  self.filteredUsersArray.count;
    }
}


//I AM CHANGING THIS- 05/21/15
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        NSString *firstString = [searchBar.text mutableCopy];
        NSMutableString *searchString = [[firstString stringByReplacingOccurrencesOfString:@" " withString:@"+"]mutableCopy];
        NSString *string = [NSString stringWithFormat:@"&q=%@", searchString];
        NSLog(@"%@", string);

        [self.stringsArray addObject:string];
        self.searchBar.returnKeyType = UIReturnKeySearch;
        [searchBar resignFirstResponder];
        self.getRecipesButton.enabled = YES;
    }else
    {
        PFQuery *query = [FDPFUser query];
        [query orderByDescending:@"username"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            self.usersArray = objects;
            self.filteredUsersArray = [self.usersArray mutableCopy];
            [self.filteredUsersArray removeAllObjects];
            for (FDPFUser *user in self.usersArray) {
                NSRange nameRange = [user.username rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
                if (nameRange.location != NSNotFound) {
                    [self.filteredUsersArray addObject:user];
                }
            }
        }
        [self.tableView reloadData];
        }];

        [searchBar resignFirstResponder];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {

        self.getRecipesButton.enabled = YES;


        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([self.cellSelectedArray containsObject:indexPath]) {
            [self.cellSelectedArray removeObject:indexPath];
        } else
        {
            [self.cellSelectedArray addObject:indexPath];
        }
        [self.tableView reloadData];

        if (indexPath.section == 0 && cell.accessoryType == UITableViewCellAccessoryNone)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            NSString *string = self.allowedAllergiesStringsArray[indexPath.row];
            [self.stringsArray addObject:string];


        } else if (indexPath.section == 1 && cell.accessoryType == UITableViewCellAccessoryNone)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            NSString *string = self.allowedDietsStringsArray[indexPath.row];
            [self.stringsArray addObject:string];


        } else if (indexPath.section == 2 && cell.accessoryType == UITableViewCellAccessoryNone)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            NSString *string = self.allowedCuisinesStringsArray[indexPath.row];
            [self.stringsArray addObject:string];


        } else if (indexPath.section == 3 && cell.accessoryType == UITableViewCellAccessoryNone)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            NSString *string = self.allowedCoursesStringsArray[indexPath.row];
            [self.stringsArray addObject:string];


        } else if (indexPath.section == 4 && cell.accessoryType == UITableViewCellAccessoryNone)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            NSString *string = self.allowedHolidaysStringsArray[indexPath.row];
            [self.stringsArray addObject:string];

        } else
        {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [self.stringsArray removeLastObject];
        }

        [self.tableView reloadData];
    }else
    {
        FDPFUser *currentUser = [FDPFUser currentUser];
        FDPFUser *user = self.filteredUsersArray[indexPath.row];
        if ([user.username isEqualToString:currentUser.username])
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
            ProfileViewController *profileVC= [storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
            [self.navigationController pushViewController:profileVC animated:YES];

        }else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainFeed" bundle:nil];
            UserProfileViewController *userVC= [storyboard instantiateViewControllerWithIdentifier:@"UserVC"];
            [self.navigationController pushViewController:userVC animated:YES];
            userVC.user = user;
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JustinViewController *justinVC = segue.destinationViewController;
    self.urlText = [[self.stringsArray valueForKey:@"description"] componentsJoinedByString:@""];
    justinVC.urlText = self.urlText;
    //    NSLog(@"The Url Text is %@", self.urlText);

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
    //    self.lastContentOffsetY = scrollView.contentOffset.y;
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y > 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else if (velocity.y < 0){
        [self.navigationController setNavigationBarHidden:NO];
    }
}


//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    PFQuery *query = [FDPFUser query];
//    [query orderByDescending:@"username"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error)
//        {
//            self.usersArray = objects;
//            self.filteredUsersArray = [self.usersArray mutableCopy];
//
//            if (searchText.length != 0) {
//                [self.filteredUsersArray removeAllObjects];
//                for (FDPFUser *user in self.usersArray) {
//                    NSRange nameRange = [user.username rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
//                    if (nameRange.location != NSNotFound) {
//                        [self.filteredUsersArray addObject:user];
//                    }
//                }
//            }else
//            {
//                [self.filteredUsersArray removeAllObjects];
//            }
//        }
//        [self.tableView reloadData];
//    }];
//
//
//}

//When "Get Recipes" Bar Button Item pressed


//- (IBAction)swipedGestureSwiped:(UISwipeGestureRecognizer *)sender {
//
//    if (self.swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft) {
//        self.segmentedControl.selectedSegmentIndex = 1;
//    }else if (self.swipeGesture.direction == UISwipeGestureRecognizerDirectionRight)
//    {
//        self.segmentedControl.selectedSegmentIndex = 0;
//    }
//}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    self.navigationController.hidesBarsOnSwipe = YES;

//    if (self.lastContentOffsetY > scrollView.contentOffset.y) {
//
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        CGFloat navBarHeight = 60;
//        CGRect frame = CGRectMake(0, 0, self.view.layer.frame.size.width, navBarHeight);
//        [self.navigationController.navigationBar setFrame:frame];
//
//    } else if (self.lastContentOffsetY < scrollView.contentOffset.y) {
//
////        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        CGFloat navBarHeight = 20.0f;
//        CGRect frame = CGRectMake(0.0f, 0.0f, self.view.layer.frame.size.width, navBarHeight);
//        [self.navigationController.navigationBar setFrame:frame];
////        self.navigationController.navigationBar.layer.frame.size.height = 20;
//
//    }

}

@end
