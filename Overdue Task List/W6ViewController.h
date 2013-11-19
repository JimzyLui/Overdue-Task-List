//
//  W6ViewController.h
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "W6AddTaskVC.h"
#import "W6DetailTaskVC.h"

@interface W6ViewController : UIViewController<W6AddTaskVCDelegate, UITableViewDataSource, UITableViewDelegate,W6DetailTaskVCDelegate>

@property (strong,nonatomic)NSMutableArray *taskObjects;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
