//
//  CommonString.h
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/23/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#ifndef CommonString_h
#define CommonString_h

#define kIdentifierCellTableView @"identifierCellRecipe"
#define kNameDatabase @"RecipeDB"
#define kFieldRecipeName @"recipeName"
#define kListRecipeDefault @[@"Recipe 1", @"Recipe 2", @"Recipe 3", @"Recipe 4", @"Recipe 5"]
#define kListRecipeDecriptionDefault @[@"This is a sample for recipe 1", @"This is a sample for recipe 2", @"This is a sample for recipe 3", @"This is a sample for recipe 4", @"This is a sample for recipe 5"]
#define InitStoryBoardWithIdentifier(identifier) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier]

#endif /* CommonString_h */
