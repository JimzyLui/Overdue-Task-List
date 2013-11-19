//
//  W6DetailTaskVC.m
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "W6DetailTaskVC.h"

@interface W6DetailTaskVC ()

@end

@implementation W6DetailTaskVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //populate the fields
    self.taskNameLabel.text = self.task.taskName;
    self.taskDetailsLabel.text = self.task.taskDescription;
    //[self.taskDetailsLabel sizeToFit];  //doesn't work to top align - save for reference

    [self isCompleted:self.task.isCompleted];  //sets switch settings

    
    //NSLog(@"Details: %@",self.task.taskDescription)
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATETIME_FORMAT];
    NSString *strDate = [formatter stringFromDate:self.task.dateDue];
  
    self.dateLabel.text = strDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)isCompleted:(BOOL)isCompleted
{
    if (isCompleted == YES) {
        self.isCompletedSwitch.on = YES;
        self.isCompletedLabel.text = SWITCH_ON;
    } else {
        self.isCompletedSwitch.on = NO;
        self.isCompletedLabel.text = SWITCH_OFF;
    }
}
- (IBAction)isCompletedSwitchChanged:(UISwitch *)sender {
    if (self.isCompletedSwitch.on) {
        self.isCompletedLabel.text = SWITCH_ON;
        self.task.isCompleted = YES;
    } else{
        self.isCompletedLabel.text = SWITCH_OFF;
        self.task.isCompleted = NO;
    }
    [self.delegate updateTasks];
}



- (IBAction)editTaskBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toEditVCSegue" sender:sender];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[W6EditTaskVC class]]){
        W6EditTaskVC *editTaskVC = segue.destinationViewController;
        editTaskVC.task = self.task;
        editTaskVC.delegate = self;
    }
}

-(void)didUpdateTask
{
    self.taskNameLabel.text = self.task.taskName;
    self.taskDetailsLabel.text = self.task.taskDescription;
    //[self.taskDetailsLabel sizeToFit];  //doesn't work to top align - save for reference
    //[self isCompleted:self.task.isCompleted];  //sets switch settings
    self.task.isCompleted = self.isCompletedSwitch.on;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATETIME_FORMAT];
    NSString *strDate = [formatter stringFromDate:self.task.dateDue];
    self.dateLabel.text = strDate;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTasks];
}

@end
