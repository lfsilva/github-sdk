//
//  TagsViewController.m
//  github-sdk
//
//  Created by Leandro Fernandes on 10/17/2024.
//  Copyright (c) 2024 Leandro Fernandes. All rights reserved.
//

#import "TagsViewController.h"
#import "GitHubSDK.h"
#import "Tag.h"

@interface TagsViewController ()

@property (nonatomic, strong) GitHubSDK *gitHubSDK;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<Tag *> *data;
@property (nonatomic, strong) UILabel *emptyStateLabel;

@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gitHubSDK = [[GitHubSDK alloc] init];
    
    [self setupView];
    [self setupTableView];
    [self setupEmptyView];
    [self setupLoading];
    
    [self hideEmptyView];
    
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupView {
    self.title = @"Tags";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
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

- (void)fetchData {
    [self startLoading];
    
    [self.gitHubSDK tagsOf:self.repo belongsTo:self.user completion:^(NSArray<Tag *> *tags, NSError *error) {
        self.data = tags;
        
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
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
