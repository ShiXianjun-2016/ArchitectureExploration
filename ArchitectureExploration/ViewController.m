//
//  ViewController.m
//  ArchitectureExploration
//
//  Created by 石显军 on 2019/3/28.
//  Copyright © 2019 石显军. All rights reserved.
//
#import <JKCategories/JKCategories.h>
#import "ViewController.h"
#import "UITableViewCellModel.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input : %@", input);
       
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
           
            [subscriber sendNext:@"发送数据"];
            
            [subscriber sendError:[NSError errorWithDomain:@"错误" code:-1 userInfo:@{@"error" : @"hhhhh"}]];
            
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    [command execute:@{@"name" : @"shixianjun"}];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"x : %@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error : %@", error);
    } completed:^{
        NSLog(@"完成");
    }];
    
}


@end
