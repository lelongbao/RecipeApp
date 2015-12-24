//
//  DataAccess.h
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/23/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataAccess : NSObject

+ (DataAccess *)share;

//*****************************************************************************
#pragma mark -
#pragma mark - ** Create - Insert - Update - Delete **

/*
 * Create database sample
 */
- (void) createDataRecipeSample;

/*
 * Insert Recipe
 */
- (BOOL) insertRecipe:(NSString *)nameRecipe
    descriptionRecipe:(NSString *)descriptionRecipe
             withType:(RecipeType *)recipeType;

/*
 * Update Recipe
 */
- (BOOL) updateRecipe:(Recipe *)recipe
            withName:(NSString *)nameRecipe
   descriptionRecipe:(NSString *)descriptionRecipe
             withType:(RecipeType *)recipeType;

/*
 * Delete Recipe
 */
- (BOOL) deleteRecipe:(Recipe *)recipe;

//*****************************************************************************
#pragma mark -
#pragma mark - ** Get list recipe **
/*
 * Get list recipe
 */
- (NSArray *)listRecipeByType:(RecipeType *)recipeType;

@end
