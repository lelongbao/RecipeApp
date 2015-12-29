//
//  Utilities.h
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/24/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (void)addAnimation:(nonnull UIView *)view;

/*
 * Filter array duplicate
 */
+ (nonnull NSArray*) filterArrayDuplicate:(nonnull NSArray *)list;

/*
 * Filter search
 */
+ (nonnull NSArray *)filterContentForSearchText:(nonnull NSString*)searchText scope:(nonnull NSString*)scope withArray:(nonnull NSArray *)listArray;

/*
 * Detect is search or not
 */
+ (BOOL)isSearchController:(nonnull UISearchController *)searchController;

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
