//
//  TagsViewController.h
//  github-sdk
//
//  Created by Leandro Fernandes on 10/17/2024.
//  Copyright (c) 2024 Leandro Fernandes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagsViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *repo;

@end
