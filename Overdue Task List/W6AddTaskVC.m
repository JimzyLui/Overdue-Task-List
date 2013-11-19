//
//  W6AddTaskVC.m
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "W6AddTaskVC.h"

@interface W6AddTaskVC ()

@end

@implementation W6AddTaskVC

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
    self.taskNameTextField.delegate = self;
    self.taskDetailsTextView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(W6Task *)returnNewTaskObject
{
    W6Task *taskObject = [[W6Task alloc] init];
    taskObject.taskName = self.taskNameTextField.text;
    taskObject.taskDescription = self.taskDetailsTextView.text;
    taskObject.dateDue = self.dateDueDatePicker.date;
    taskObject.isCompleted = NO;
    return taskObject;
}

- (IBAction)addTaskButtonPressed:(UIButton *)sender
{
    [self.delegate didAddTask:[self returnNewTaskObject]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
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
