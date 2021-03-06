//
//  Recipe.m
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/23/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe
@dynamic recipeName, recipeDecription, type;

+ (DBIndexDefinition *)indexDefinitionForEntity {
    
    /* if you return an index definition object, then DBAccess will maintain the indexed based on this */
    
    DBIndexDefinition* idx = [DBIndexDefinition new];
    [idx addIndexForProperty:kFieldRecipeName propertyOrder:DBIndexSortOrderAscending];
    return idx;
    
}

/*
 * List recipe
 */
+ (NSArray *)listRecipe {
    return [[Recipe query] fetch];
}

@end
