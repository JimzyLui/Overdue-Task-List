//
//  W6ViewController.m
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "W6ViewController.h"

@interface W6ViewController ()

@end

@implementation W6ViewController

//lazy instantiation
-(NSMutableArray *)taskObjects
{
    if(!_taskObjects){
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self;  //so tableview protocol knows to send messages to me
    self.tableView.delegate = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_NSUSERDEFAULT_KEY];
    
    for(NSDictionary *dict in tasksAsPropertyLists){
        W6Task *taskObject = [self taskObjectFromDictionary:dict];
        [self.taskObjects addObject:taskObject];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[W6AddTaskVC class]]){
        W6AddTaskVC *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    
    else if([segue.destinationViewController isKindOfClass:[W6DetailTaskVC class]]){
        W6DetailTaskVC *detailTaskVC = segue.destinationViewController;
        
        NSIndexPath *path = sender;
        W6Task *taskObject = self.taskObjects[path.row];
        detailTaskVC.task = taskObject;
        
        detailTaskVC.delegate = self;
    }
        
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender
{
    if(self.tableView.editing == YES){
        [self.tableView setEditing:NO animated:YES];
    }
    else [self.tableView setEditing:YES animated:YES];
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskVCSegue" sender:nil];
}

#pragma mark - W6AddTaskVCDelegate

-(void)didAddTask:(W6Task *)task
{
    [self.taskObjects addObject:task];
    
    NSLog(@"%@",task.taskName);
    
    NSMutableArray *taskObjectsPlistArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_NSUSERDEFAULT_KEY] mutableCopy];
    if(!taskObjectsPlistArray) taskObjectsPlistArray = [[NSMutableArray alloc] init];
  
    [taskObjectsPlistArray addObject:[self taskObjectToPlistDictionary:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsPlistArray forKey:TASK_NSUSERDEFAULT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - W6DetailVCDelegate
-(void)updateTasks
{
    [self saveTasks];
    [self.tableView reloadData];
}


#pragma mark - helper methods

-(NSDictionary *)taskObjectToPlistDictionary:(W6Task *)taskObject
{
    NSDictionary *dict = @{TASK_TITLE:taskObject.taskName,
                           TASK_DESCRIPTION:taskObject.taskDescription,
                           TASK_DUE_DATE: taskObject.dateDue,
                           TASK_COMPLETED: @(taskObject.isCompleted) };
    return dict;
}

-(W6Task *) taskObjectFromDictionary:(NSDictionary *)dict
{
    W6Task *taskObject = [[W6Task alloc] initWithData:dict];
    return taskObject;
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if(dateInterval > toDateInterval) return YES;
    else return NO;
}

-(void)updateCompletionOfTask:(W6Task *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsPlistArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_NSUSERDEFAULT_KEY] mutableCopy];
    if(!taskObjectsPlistArray) taskObjectsPlistArray = [[NSMutableArray alloc] init];
    
    [taskObjectsPlistArray removeObjectAtIndex:indexPath.row];
    
    task.isCompleted = !task.isCompleted;

    [taskObjectsPlistArray insertObject:[self taskObjectToPlistDictionary:task] atIndex:indexPath.row];

    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsPlistArray forKey:TASK_NSUSERDEFAULT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
 
    [self.tableView reloadData];
}

-(void)saveTasks
{
    NSMutableArray *newTaskObjectsPlistArray = [[NSMutableArray alloc] init];

    for(int x = 0; x < [self.taskObjects count]; x++){
        [newTaskObjectsPlistArray addObject:[self taskObjectToPlistDictionary:self.taskObjects[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsPlistArray forKey:TASK_NSUSERDEFAULT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UITableViewDataSouce

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.taskObjects.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configure cell
    
    W6Task *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.taskName;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATETIME_FORMAT];
    NSString *stringFromDate = [formatter stringFromDate:task.dateDue];
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.dateDue];
    
    if(task.isCompleted == YES) cell.backgroundColor = [UIColor greenColor];
    else if(isOverDue == YES) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    W6Task *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle ==UITableViewCellEditingStyleDelete){
        //remove the selected cell from the array
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        //create a new array and copy the remaining objects to it
        NSMutableArray *newTaskObjectsPlistArray = [[NSMutableArray alloc] init];
        for(W6Task *taskObj in self.taskObjects){
            [newTaskObjectsPlistArray addObject:[self taskObjectToPlistDictionary:taskObj]];
        }
        
        //save the array to the plist
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsPlistArray forKey:TASK_NSUSERDEFAULT_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //update table
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{    
    [self performSegueWithIdentifier:@"toDetailVCSegue" sender:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    W6Task *taskObj = [self.taskObjects objectAtIndex:sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObj atIndex:destinationIndexPath.row];
    
    //NSLog(@"Reordered");
    [self saveTasks];
}


@end
