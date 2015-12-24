//
//  Recipe.h
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/23/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import <DBAccess/DBAccess.h>

@interface Recipe : DBObject

@property (strong, nonatomic) NSString *recipeName;
@property (strong, nonatomic) NSString *recipeDecription;

@end
