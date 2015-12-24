//
//  DataAccess.m
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/23/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import "DataAccess.h"

@implementation DataAccess 

+ (DataAccess *)share {
    static dispatch_once_t once;
    static DataAccess *share;
    
    dispatch_once(&once, ^{
        share = [[DataAccess alloc] init];
        [share createDataRecipeSample];
    });
    
    return share;
}

/*
 * Create database sample
 */
- (void)createDataRecipeSample {
    if ([self isExistData]) {
        return;
    } else {
        
        for (int i = 0; i< kListRecipeDefault.count; i++) {
            Recipe *recipe = [Recipe new];
            recipe.recipeName = kListRecipeDefault[i];
            recipe.recipeDecription = kListRecipeDecriptionDefault[i];
            [recipe commit];
        }
    }
}

/*
 * Check exist data
 */
- (BOOL)isExistData {
    if ([Recipe query].count)
        return YES;
    else
        return NO;
}

/*
 * Insert Recipe
 */
- (BOOL) insertRecipe:(NSString *)nameRecipe
    descriptionRecipe:(NSString *)descriptionRecipe {
    Recipe *recipeNew = [Recipe new];
    recipeNew.recipeName = nameRecipe;
    recipeNew.recipeDecription = descriptionRecipe;
    return [recipeNew commit];
}

/*
 * Update Recipe
 */
- (BOOL) updateRecipe:(Recipe *)recipe
             withName:(NSString *)nameRecipe
    descriptionRecipe:(NSString *)descriptionRecipe {
    recipe.recipeName = nameRecipe;
    recipe.recipeDecription = descriptionRecipe;
    return [recipe commit];
}

/*
 * Delete Recipe
 */
- (BOOL) deleteRecipe:(Recipe *)recipe {
    return [recipe remove];
}

@end
