//
//  ViewController.m
//  Foodicorn
//
//  Created by tim on 4/13/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "JustinViewController.h"
#import "Yummly.h"

@interface JustinViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic)  NSArray *recipes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *allowedAllergies;
@property NSArray *allowedDiets;
@property NSArray *allowedCuisines;
@property NSArray *allowedCourses;
@property NSArray *allowedHolidays;

@end

@implementation JustinViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Yummly recipeArrayFromDictionaryArray:^(NSArray *array) {
        self.recipes = array;

        NSLog(@"%@", self.recipes);
    }];


    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];

    self.allowedAllergies = [NSArray arrayWithObjects:@"Dairy-free", @"Egg-free", @"Gluten-free", @"Peanut-free", @"Seafood-free", @"Sesame-free", @"Soy-free", @"Sulfite-free", @"Tree+nut-free", @"Wheat-free", nil];
    self.allowedDiets = [NSArray arrayWithObjects:@"Lacto+vegetarian", @"Ovo+vegetarian", @"Pescetarian", @"Vegan", @"Vegetarian", nil];
    self.allowedCuisines = [NSArray arrayWithObjects:@"American", @"Italian", @"Asian", @"Mexican", @"Southern+&+Soul+Food", @"French", @"Southwestern", @"Barbecue", @"Indian", @"Chinese", @"Cajun+&+Creole", @"English", @"Mediterranean", @"Greek", @"Spanish", @"German", @"Thai", @"Moroccan", @"Irish", @"Japanese", @"Cuban", @"Hawaiin", @"Swedish", @"Hungarian", @"Portugese", nil];
    self.allowedCourses = [NSArray arrayWithObjects:@"Main+Dishes", @"Desserts", @"Side+Dishes", @"Lunch+and+Snacks", @"Appetizers", @"Salads", @"Breads", @"Breakfast+and+Brunch", @"Soups", @"Beverages", @"Condiments+and+Sauces", @"Cocktails", nil];
    self.allowedHolidays = [NSArray arrayWithObjects:@"Christmas", @"Summer", @"Thanksgiving", @"New+Year", @"Super+Bowl+/+Game+Day", @"Halloween", @"Hanukkah", @"4th+of+July", nil];



}

-(void)setRecipes:(NSArray *)recipes
{
    _recipes = recipes;
    [self.tableView reloadData];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipe"];
    Yummly *recipe = [self.recipes objectAtIndex:indexPath.row];
//    cell.textLabel.text = recipe.recipeName;
    cell.textLabel.text = self.allowedAllergies[indexPath.row];
    cell.detailTextLabel.text = recipe.recipeId;

    NSString *thumnailImage = recipe.thumbnailString;
    NSURL *url = [NSURL URLWithString:thumnailImage];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData:data];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0)
//    {
//        return self.allowedAllergies.count;
//    } else if (section == 1)
//    {
//        return self.allowedDiets.count;
//    }else if (section == 2)
//    {
//        return self.allowedCuisines.count;
//    }else if (section == 3)
//    {
//        return self.allowedCourses.count;
//    }else
//    {
//        return self.allowedHolidays.count;
//    }
    return self.recipes.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
@end

