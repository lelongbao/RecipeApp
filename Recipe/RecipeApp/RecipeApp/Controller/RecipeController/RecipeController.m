//
//  RecipeController.m
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/23/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#import "RecipeController.h"

@interface RecipeController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) DBEventHandler* recipeEventHandler;
@property (nonatomic, strong) DataAccess *dataAccess;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, strong) NSArray *listResult;
@property (weak, nonatomic) IBOutlet UITableView *tbvRecipe;

- (IBAction)btnAdd:(id)sender;

@end

@implementation RecipeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self configController];
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Helper Method **
- (void) initData {
    /* get the event object for the MacModel class object */
    self.recipeEventHandler = [Recipe eventHandler];
    
    [self.recipeEventHandler registerBlockForEvents:DBAccessEventDelete |DBAccessEventInsert |DBAccessEventUpdate
                                          withBlock:^(DBEvent *event) {
                                                [self.tbvRecipe reloadData];
                                            } onMainThread:YES];
}

- (void)configController {
    
    // Config table view recipe
    self.tbvRecipe.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tbvRecipe.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Init search controller
    [self initSearchController];
    self.dataAccess = [DataAccess share];
}

/*
 * Init search controller
 */
- (void)initSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"Recipe",@"Recipe"),
                                                          NSLocalizedString(@"Type",@"Type")];
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Search Recipe";
    self.tbvRecipe.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.backgroundColor = [UIColor clearColor];
    self.definesPresentationContext = YES;
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Table view delegate **

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([Utilities isSearchController:self.searchController]) {
        
        // Search
        return [self.listResult count];
    } else {
        
        // Recipe type
        return [[RecipeType listRecipeType] count];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([Utilities isSearchController:self.searchController]) {
        
        // Search
        RecipeType *typeRecipe = self.listResult[section];
        return [self.dataAccess filterRecipeByType:typeRecipe andName:self.searchController.searchBar.text].count;
        
    } else {
        
        // Return row of each section
        RecipeType *typeRecipe = [RecipeType listRecipeType][section];
        return [self.dataAccess listRecipeByType:typeRecipe].count;
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([Utilities isSearchController:self.searchController]) {
        RecipeType *recipeTypeObj = self.listResult[section];
        return recipeTypeObj.recipeType;
    } else {
        RecipeType *recipeType = [RecipeType listRecipeType][section];
        return recipeType.recipeType;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor brownColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Init cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierCellTableView];
    if(!cell) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kIdentifierCellTableView]; }
    
    // Config cell
    Recipe *recipe = nil;
    if ([Utilities isSearchController:self.searchController]) {
        RecipeType *typeRecipe = self.listResult[indexPath.section];
        recipe = [self.dataAccess filterRecipeByType:typeRecipe andName:self.searchController.searchBar.text][indexPath.row];
        
    } else {
        RecipeType *typeRecipe = [RecipeType listRecipeType][indexPath.section];
        recipe = [self.dataAccess listRecipeByType:typeRecipe][indexPath.row];
    }
    
    cell.textLabel.text = recipe.recipeName;
    cell.detailTextLabel.text = recipe.recipeDecription;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell     forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) { [tableView setSeparatorInset:UIEdgeInsetsZero]; }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) { [tableView setLayoutMargins:UIEdgeInsetsZero]; }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) { [cell setLayoutMargins:UIEdgeInsetsZero]; }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     RecipeDetailController *detailController = InitStoryBoardWithIdentifier(kRecipeDetailController);
    
    if ([Utilities isSearchController:self.searchController]) {
        indexPath = [self.tbvRecipe indexPathForSelectedRow];
        RecipeType *typeRecipe = self.listResult[indexPath.section];
        detailController.recipe = [self.dataAccess filterRecipeByType:typeRecipe andName:self.searchController.searchBar.text][indexPath.row];
        
    } else {
        RecipeType *typeRecipe = [RecipeType listRecipeType][indexPath.section];
        detailController.recipe = [self.dataAccess listRecipeByType:typeRecipe][indexPath.row];
    }
    
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    
    // Filter content
    self.listResult = [Utilities filterContentForSearchText:searchString
                               scope:[[self.searchController.searchBar scopeButtonTitles] objectAtIndex:[self.searchController.searchBar selectedScopeButtonIndex]]
                                withArray:[Recipe listRecipe]];
    [self.tbvRecipe reloadData];
}

#pragma mark IBAction

- (IBAction)btnAdd:(id)sender {
    RecipeDetailController *detailController = InitStoryBoardWithIdentifier(kRecipeDetailController);
    [self.navigationController pushViewController:detailController animated:YES];

}
@end
