//
//  W6AddTaskVC.h
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "W6Task.h"

@protocol W6AddTaskVCDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(W6Task *)task;

@end
@interface W6AddTaskVC : UIViewController<UITextViewDelegate,UITextFieldDelegate>

@property(weak, nonatomic)id<W6AddTaskVCDelegate>delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailsTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateDueDatePicker;
- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
