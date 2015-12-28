//
//  RecipeType.h
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/24/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import <DBAccess/DBAccess.h>

@interface RecipeType : DBObject

@property (strong, nonatomic) NSString *recipeType;

/*
 * List recipe type
 */
+ (NSArray *)listRecipeType;

@end
