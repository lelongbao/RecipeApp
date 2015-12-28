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
        
        for (int i = 0; i< kListRecipeTypeDefault.count; i++) {
            RecipeType *recipeType = [RecipeType new];
            recipeType.recipeType = kListRecipeTypeDefault[i];
            [recipeType commit];
        }
        
        NSArray *arrayRecipeType = [[RecipeType query] fetch];
        
        
        for (int i = 0; i< kListRecipeDefault.count; i++) {
            Recipe *recipe = [Recipe new];
            recipe.recipeName = kListRecipeDefault[i];
            recipe.recipeDecription = kListRecipeDecriptionDefault[i];
            recipe.type = arrayRecipeType[i];
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
    descriptionRecipe:(NSString *)descriptionRecipe
             withType:(RecipeType *)recipeType {
    Recipe *recipeNew = [Recipe new];
    recipeNew.recipeName = nameRecipe;
    recipeNew.recipeDecription = descriptionRecipe;
    recipeNew.type = recipeType;
    return [recipeNew commit];
}

/*
 * Update Recipe
 */
- (BOOL) updateRecipe:(Recipe *)recipe
             withName:(NSString *)nameRecipe
    descriptionRecipe:(NSString *)descriptionRecipe
             withType:(RecipeType *)recipeType {
    recipe.recipeName = nameRecipe;
    recipe.recipeDecription = descriptionRecipe;
    recipe.type = recipeType;
    return [recipe commit];
}

/*
 * Delete Recipe
 */
- (BOOL) deleteRecipe:(Recipe *)recipe {
    return [recipe remove];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Get list recipe **
/*
 * Get list recipe
 */
- (NSArray *)listRecipeByType:(RecipeType *)recipeType {
   return [[[Recipe query] whereWithFormat:@"(type == %@ )",recipeType] fetch];
}

/*
 * filter list recipe
 */
- (NSArray *)filterRecipeByType:(RecipeType *)recipeType andName:(NSString *)searchText {
    NSMutableArray *finalList = [[NSMutableArray alloc] init];
    NSArray *list = [[[Recipe query] whereWithFormat:@"(type == %@ )",recipeType] fetch];
    for (Recipe *recipe in list) {
        if ([recipe.recipeName isEqualToString:searchText]) {
            [finalList removeAllObjects];
            [finalList addObject:recipe];
            break;
        }
        else {
            [finalList addObject:recipe];
        }
    }
    
    return finalList;
}

@end
