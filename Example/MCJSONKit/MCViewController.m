//
//  MCViewController.m
//  MCJSONKit
//
//  Created by Rake Yang on 11/04/2017.
//  Copyright (c) 2017 mylcode. All rights reserved.
//

#import "MCViewController.h"
#import <MCFoundation/MCFoundation.h>
#import <MCJSONKit/MCJSONKit.h>

@interface MCViewController ()

@end

@implementation MCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s", MCFoundationVersionString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
