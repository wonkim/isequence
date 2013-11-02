//
//  ViewController.m
//  iSequenceDiagram
//
//  Created by Wonil Kim on 13. 3. 10..
//  Copyright (c) 2013년 Wonil Kim. All rights reserved.
//

#import "ViewController.h"
#import "DiagramView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    DiagramView *diagramView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    diagramView = [[DiagramView alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
