//
//  W6Task.m
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import "W6Task.h"

@implementation W6Task

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if(self){
        self.taskName = data[TASK_TITLE];
        self.taskDescription = data[TASK_DESCRIPTION];
        self.dateDue = data[TASK_DUE_DATE];
        self.isCompleted = [data[TASK_COMPLETED] boolValue];
    }
    return self;
}

-(id)init
{
    self = [self initWithData:nil];
    return self;
}

@end
