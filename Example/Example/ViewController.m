//
//  ViewController.m
//  github-sdk
//
//  Created by Leandro Fernandes on 10/17/2024.
//  Copyright (c) 2024 Leandro Fernandes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupLabel];
    [self setupConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupLabel {
    self.label = [[UILabel alloc] init];
    self.label.text = @"Tela Inicial";
    self.label.textColor = [UIColor blackColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.label];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

@end
