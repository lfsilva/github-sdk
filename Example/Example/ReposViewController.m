//
//  ReposViewController.m
//  github-sdk
//
//  Created by Leandro Fernandes on 10/17/2024.
//  Copyright (c) 2024 Leandro Fernandes. All rights reserved.
//

#import "ReposViewController.h"
#import "GitHubSDK.h"
#import "Repo.h"

@interface ReposViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) GitHubSDK *gitHubSDK;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray<Repo *> *data;
@property (nonatomic, strong) UILabel *emptyStateLabel;

@end

@implementation ReposViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gitHubSDK = [[GitHubSDK alloc] init];
    
    [self setupView];
    [self setupTableView];
    [self setupSearchBar];
    [self setupEmptyView];
    [self setupLoading];
    
    [self hideEmptyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupView {
    self.title = @"Repositórios";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

- (void)setupSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Usuário";
    self.searchBar.showsCancelButton = YES;
    [self.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = self.searchBar;
}

- (void)setupEmptyView {
    self.emptyStateLabel = [[UILabel alloc] init];
    self.emptyStateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.emptyStateLabel.text = @"Nenhum resultado encontrado";
    self.emptyStateLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyStateLabel.font = [UIFont boldSystemFontOfSize:18.0];
    self.emptyStateLabel.textColor = [UIColor lightGrayColor];
    
    [self.tableView addSubview:self.emptyStateLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.emptyStateLabel.centerXAnchor constraintEqualToAnchor:self.tableView.centerXAnchor],
        [self.emptyStateLabel.centerYAnchor constraintEqualToAnchor:self.tableView.centerYAnchor]
    ]];
}

- (void)showEmptyView {
    self.emptyStateLabel.hidden = NO;
}

- (void)hideEmptyView {
    self.emptyStateLabel.hidden = YES;
}

- (void)setupLoading {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
}

- (void)startLoading {
    [self.activityIndicator startAnimating];
}

- (void)stoptLoading {
    [self.activityIndicator stopAnimating];
}

- (void)fetchData:(NSString*)user {
    [self startLoading];
    
    [self.gitHubSDK reposOf:user completion:^(NSArray<Repo *> *repos, NSError *error) {
        self.data = repos;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stoptLoading];
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.data.count == 0) {
        [self showEmptyView];
    } else {
        [self hideEmptyView];
    }
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.data[indexPath.row].name;
    cell.detailTextLabel.text = [self.data[indexPath.row].detail isEqual:[NSNull null]] ? @"-" : self.data[indexPath.row].detail;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Selecionado: %@", self.data[indexPath.row].name);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self fetchData:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.data = @[];
    [self.tableView reloadData];
    
    self.searchBar.text = @"";
    
    [searchBar resignFirstResponder];
}

@end
