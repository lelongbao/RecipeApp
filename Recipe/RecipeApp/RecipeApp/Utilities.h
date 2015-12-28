//
//  Utilities.h
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/24/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (void)addAnimation:(UIView *)view;

/*
 * Filter array duplicate
 */
+ (NSArray*) filterArrayDuplicate:(NSArray *)list;

/*
 * Filter search
 */
+ (NSArray *)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope withArray:(NSArray *)listArray;

/*
 * Detect is search or not
 */
+ (BOOL)isSearchController:(UISearchController *)searchController;

/*
 * Detect ipad
 */
+ (BOOL) isiPad;

/**
 * fix auto layout for iPhone 5/5S, iPhone 6/6S, iPhone 6/6S Plus
 * Check score is 00
 */
+ (void) fixAutolayoutWithDelegate:(nonnull id /*<UIFixAutolayoutDelegate>*/)delegate;

@end
