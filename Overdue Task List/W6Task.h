//
//  W6Task.h
//  Overdue Task List
//
//  Created by Jimzy Lui on 11/16/2013.
//  Copyright (c) 2013 Jimzy Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface W6Task : NSObject
@property(strong,nonatomic)NSString *taskName;
@property(strong,nonatomic)NSString *taskDescription;
@property(strong,nonatomic)NSDate *dateDue;
@property(nonatomic)BOOL isCompleted;
//@property(nonatomic)int priority;

-(id)initWithData:(NSDictionary *)data;

@end
