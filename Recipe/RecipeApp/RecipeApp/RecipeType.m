//
//  RecipeType.m
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/24/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import "RecipeType.h"

@implementation RecipeType

@dynamic recipeType;

/*
 * List recipe type
 */
+ (NSArray *)listRecipeType {
    return [[RecipeType query] fetch];
}



@end
