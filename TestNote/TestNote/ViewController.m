//
//  ViewController.m
//  TestNote
//
//  Created by 陈林 on 2018/11/6.
//  Copyright © 2018年 陈林. All rights reserved.
//

#import "ViewController.h"
#import "CLNoteView.h"

@interface ViewController ()

@property (nonatomic, strong)CLNoteView *noteView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.noteView];
}

- (CLNoteView *)noteView {
    if (!_noteView) {
        _noteView = [[CLNoteView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-80)*0.5, (self.view.bounds.size.height-80)*0.5, 80, 80)];
//        _noteView.backgroundColor = [UIColor redColor];
    }
    return _noteView;
}

@end
