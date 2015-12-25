//
//  RecipeDetailController.m
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/23/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import "RecipeDetailController.h"

@interface RecipeDetailController () <UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DBEventHandler* recipeEventHandler;
@property (nonatomic, strong) DataAccess *dataAccess;
@property (nonatomic, strong) RecipeType *recipeTypeSelected;
@property (nonatomic, strong) NSArray *listRecipeType;
@property (nonatomic, strong) IBOutlet UITableView *tbvRecipeType;
@property (weak, nonatomic) IBOutlet UITextField *txtRecipeName;
@property (weak, nonatomic) IBOutlet UITextField *txtRecipeType;
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
    self.listRecipeType = [[RecipeType query] fetch];
    self.recipeTypeSelected = self.recipe.type;
    self.txtRecipeType.text = self.recipe.type.recipeType;
    
    [self initTapGesture];
}

/*
 * Pop to view controller
 */
- (void)popToRecipeController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
 * Show table view recipy type
 */
- (void)showListRecipeType {
    [Utilities addAnimation:self.tbvRecipeType];
    self.tbvRecipeType.hidden = NO;
}

- (void)hideListRecipe {
    [Utilities addAnimation:self.tbvRecipeType];
    self.tbvRecipeType.hidden = YES;
}

/*
 * Init tap gesture
 */
- (void)initTapGesture {
    // Create tap gesture to dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

/*
 * Dismiss Keyboard
 */
-(void)dismissKeyboard:(UITapGestureRecognizer *)gesture {
    
    CGPoint touchPoint= [gesture locationInView:self.tbvRecipeType];
    CGPoint pointView = [gesture locationInView:self.view];
    if (CGRectContainsPoint(self.tbvRecipeType.frame, pointView)) {
        NSIndexPath *indexPath = [self.tbvRecipeType indexPathForRowAtPoint:touchPoint];
        if (indexPath) {
            [self tableView:self.tbvRecipeType didSelectRowAtIndexPath:indexPath];
        }
    } else {
        [self hideListRecipe];
        [self.view endEditing:YES];
    }
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Text field delegate **

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.txtRecipeType]) {
        [self showListRecipeType];
        [textField resignFirstResponder];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Table view delegate **

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Recipe Type";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor lightGrayColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}


/*
 * TABLE VIEW STATE
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifer = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    RecipeType *recipeType = [self.listRecipeType objectAtIndex:indexPath.row];
    cell.textLabel.text = recipeType.recipeType;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listRecipeType.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeType *recipeType = [self.listRecipeType objectAtIndex:indexPath.row];
    self.txtRecipeType.text = recipeType.recipeType;
    self.recipeTypeSelected = recipeType;
    
    // Hide list recipe
    [self hideListRecipe];

}
//*****************************************************************************
#pragma mark -
#pragma mark - ** IBAction **

- (IBAction)btnUpdate:(id)sender {
    if (self.recipe) {
        // Update
        [self.dataAccess updateRecipe:self.recipe
                             withName:self.txtRecipeName.text
                    descriptionRecipe:self.tvRecipeDecription.text
                             withType:self.recipeTypeSelected];
        
    } else {
        // Insert
        [self.dataAccess insertRecipe:self.txtRecipeName.text
                    descriptionRecipe:self.tvRecipeDecription.text
                             withType:self.recipeTypeSelected];

    }
    [self popToRecipeController];
}

- (IBAction)btnDelete:(id)sender {
    
    [self.dataAccess deleteRecipe:self.recipe];
    
    [self popToRecipeController];
    
}
@end
