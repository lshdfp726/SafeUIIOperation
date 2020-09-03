//
//  ViewController.m
//  ProtectUIOperation
//
//  Created by 刘松洪 on 2020/9/3.
//  Copyright © 2020 刘松洪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *v;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *v = [UIView new];
    v.frame = CGRectMake(0, 0, 100, 100);
    v.backgroundColor = [UIColor redColor];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.view addSubview:v];
    });
    self.v = v;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.v.frame = CGRectMake(self.v.frame.origin.x + 10, self.v.frame.origin.y, self.v.frame.size.width, self.v.frame.size.height);
    });
}

@end
