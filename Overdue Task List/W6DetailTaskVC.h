//
//  W6DetailTaskVC.h
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "W6Task.h"
#import "W6EditTaskVC.h"

@protocol W6DetailTaskVCDelegate <NSObject>

-(void)updateTasks;

@end
@interface W6DetailTaskVC : UIViewController<W6EditTaskVCDelegate>

@property(weak,nonatomic)id<W6DetailTaskVCDelegate>delegate;

@property(strong,nonatomic)W6Task *task;
@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDetailsLabel;
@property (strong, nonatomic) IBOutlet UISwitch *isCompletedSwitch;

@property (strong, nonatomic) IBOutlet UILabel *isCompletedLabel;
- (IBAction)isCompletedSwitchChanged:(UISwitch *)sender;



- (IBAction)editTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
