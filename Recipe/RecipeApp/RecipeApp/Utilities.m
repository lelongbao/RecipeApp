//
//  Utilities.m
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/24/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (void)addAnimation:(UIView *)view {
    [UIView transitionWithView:view
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
}

/*
 * Filter array duplicate
 */
+ (NSArray*) filterArrayDuplicate:(NSArray *)list
{
    
    NSMutableArray *tmp = [NSMutableArray array];
    NSMutableSet *names = [NSMutableSet set];
    for (id item in list) {
        NSString *destinationName = [item recipeType];
        if (![names containsObject:destinationName]) {
            [tmp addObject:item];
            [names addObject:destinationName];
        }
    }
    return [NSArray arrayWithArray:tmp];
}

/*
 * Filter search
 */
+ (NSArray *)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope withArray:(NSArray *)listArray
{
    NSMutableArray *listRecipeObj = [[NSMutableArray alloc] init];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"recipeName contains %@", searchText];
    NSArray *listRecipeFilter = [listArray filteredArrayUsingPredicate:resultPredicate];
    for (Recipe *recipe in listRecipeFilter) {
        [listRecipeObj addObject:recipe.type];
    }
    return  [Utilities filterArrayDuplicate:listRecipeObj];
}

/*
 * Detect is search or not
 */
+ (BOOL)isSearchController:(UISearchController *)searchController {
    if (![searchController.searchBar.text isEqualToString:kEmptyString]) {
        return YES;
    } else {
        return NO;
    }
}

@end
