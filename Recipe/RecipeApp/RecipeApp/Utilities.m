//
//  Utilities.m
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/24/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import "Utilities.h"

#define kDeviceIsPhoneSmallerOrEqual35 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 480.0)
#define kDeviceIsPhoneSmallerOrEqual40 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 568.0)
#define kDeviceIsPhoneSmallerOrEqual47 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 667.0)
#define kDeviceIsPhoneSmallerOrEqual55 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 1104.0)
#define kDeviceIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

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

/*
 * Detect ipad
 */
+ (BOOL) isiPad
{
    static BOOL isIPad = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    });
    return isIPad;
}

/**
 * fix auto layout for iPhone 5/5S, iPhone 6/6S, iPhone 6/6S Plus
 */
+ (void) fixAutolayoutWithDelegate:(nonnull id /*<UIFixAutolayoutDelegate>*/)delegate{
    
    static SEL s_selector = nil;
    if (!s_selector) {
        if (kDeviceIsPhoneSmallerOrEqual35) {
            s_selector = NSSelectorFromString(@"fixAutolayoutFor35");
        }
        else if (kDeviceIsPhoneSmallerOrEqual40) {
            s_selector = NSSelectorFromString(@"fixAutolayoutFor40");
        }
        else if (kDeviceIsPhoneSmallerOrEqual47) {
            s_selector = NSSelectorFromString(@"fixAutolayoutFor47");
        }
        else if (kDeviceIsPhoneSmallerOrEqual55) {
            s_selector = NSSelectorFromString(@"fixAutolayoutFor55");
        } else if (kDeviceIpad) {
            s_selector = NSSelectorFromString(@"fixAutolayoutForIpad");
        }
    }
    
    id<FixAutolayoutDelegate> realDelegate = delegate;
    if ([realDelegate respondsToSelector:s_selector]) {
        IMP imp = [delegate methodForSelector:s_selector];
        void (*func)(id, SEL) = (void *)imp;
        func(realDelegate, s_selector);
    }
}

@end
