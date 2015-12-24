//
//  RecipeDetailController.m
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/23/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import "RecipeDetailController.h"

@interface RecipeDetailController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) DBEventHandler* recipeEventHandler;
@property (nonatomic, strong) DataAccess *dataAccess;
@property (weak, nonatomic) IBOutlet UITextField *txtRecipeName;
@property (weak, nonatomic) IBOutlet UITextView *tvRecipeDecription;
- (IBAction)btnUpdate:(id)sender;
- (IBAction)btnDelete:(id)sender;

@end

@implementation RecipeDetailController

//*****************************************************************************
#pragma mark -
#pragma mark - ** Life cycle **
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self config];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Helper **
/*
 * Config
 */
- (void)config {
    if (self.recipe) {
        self.txtRecipeName.text = self.recipe.recipeName;
        self.tvRecipeDecription.text = self.recipe.recipeDecription;
    }
    
    
    /* get the event object for the MacModel class object */
    self.recipeEventHandler = [Recipe eventHandler];
    [self.recipeEventHandler registerBlockForEvents:DBAccessEventDelete
     |DBAccessEventInsert
     |DBAccessEventUpdate
                                          withBlock:^(DBEvent *event) {
                                              
                                              
                                          } onMainThread:YES];
    
    self.dataAccess = [DataAccess share];
 
}

/*
 * Pop to view controller
 */
- (void)popToRecipeController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Text field delegate **

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** IBAction **

- (IBAction)btnUpdate:(id)sender {
    if (self.recipe) {
        // Update
        [self.dataAccess updateRecipe:self.recipe
                             withName:self.txtRecipeName.text
                    descriptionRecipe:self.tvRecipeDecription.text];
        
    } else {
        // Insert
        [self.dataAccess insertRecipe:self.txtRecipeName.text
                    descriptionRecipe:self.tvRecipeDecription.text];

    }
    [self popToRecipeController];
}

- (IBAction)btnDelete:(id)sender {
    
    [self.dataAccess deleteRecipe:self.recipe];
    
    [self popToRecipeController];
    
}
@end
