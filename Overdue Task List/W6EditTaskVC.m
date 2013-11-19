//
//  W6EditTaskVC.m
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "W6EditTaskVC.h"

@interface W6EditTaskVC ()

@end

@implementation W6EditTaskVC

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
    self.taskNameTextField.text = self.task.taskName;
    self.taskDetailsTextView.text = self.task.taskDescription;
    self.taskDueDatePicker.date = self.task.dateDue;
    
    [self isCompleted:self.task.isCompleted];  //sets switch settings

    //setup delegates for removing keyboard
    self.taskNameTextField.delegate = self;
    self.taskDetailsTextView.delegate = self;
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
}

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {
    [self updateTask];
    [self.delegate didUpdateTask];
}

-(void)updateTask
{
    self.task.taskName = self.taskNameTextField.text;
    self.task.taskDescription = self.taskDetailsTextView.text;
    self.task.dateDue = self.taskDueDatePicker.date;
    self.task.isCompleted = self.isCompletedSwitch.on;
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskNameTextField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //"this is a hacky solution"  - meaning, not the best
    if([text isEqualToString:@"\n"]){
        [self.taskDetailsTextView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
