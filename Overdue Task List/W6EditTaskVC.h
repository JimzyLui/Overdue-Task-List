//
//  W6EditTaskVC.h
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "W6Task.h"

@protocol W6EditTaskVCDelegate <NSObject>

-(void)didUpdateTask;

@end
@interface W6EditTaskVC : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property(weak,nonatomic)id<W6EditTaskVCDelegate>delegate;

@property(strong,nonatomic)W6Task *task;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailsTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDueDatePicker;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
