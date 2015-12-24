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

/*
 * Create database sample
 */
- (void) createDataRecipeSample;

/*
 * Insert Recipe
 */
- (BOOL) insertRecipe:(NSString *)nameRecipe
   descriptionRecipe:(NSString *)descriptionRecipe;

/*
 * Update Recipe
 */
- (BOOL) updateRecipe:(Recipe *)recipe
            withName:(NSString *)nameRecipe
   descriptionRecipe:(NSString *)descriptionRecipe;

/*
 * Delete Recipe
 */
- (BOOL) deleteRecipe:(Recipe *)recipe;

@end
