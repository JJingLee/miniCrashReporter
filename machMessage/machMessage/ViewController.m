//
//  ViewController.m
//  machMessage
//
//  Created by chiehchun on 2019/4/25.
//  Copyright © 2019 chiehchun. All rights reserved.
//

#import "ViewController.h"
#import "AMSignalHandler.h"
#import "AMUncauchExceptionHandler.h"
@interface ViewController ()

@end
typedef struct{
    int a;
    int b;
}Test;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str;
    if (str.length > 0) {}
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    //1.信号量
//    Test pTest = (Test){
//        .a=1,
//        .b=5
//    };
//    free(&pTest);//导致SIGABRT的错误，因为内存中根本就没有这个空间，哪来的free，就在栈中的对象而已
//    pTest.a = 5;
    int b = 0;
    int a = 10/b;
    printf("%i", a);
}
- (IBAction)buttonOCException:(UIButton *)sender
{
    //2.ios崩溃
    NSArray *array= @[@"tom",@"xxx",@"ooo"];
    [array objectAtIndex:5];
}

- (IBAction)testSignalPOSTClick:(UIButton *)sender {
    [AMSignalHandler postSignal:@"testSignal"];
}
- (IBAction)testExceptionPostClick:(UIButton *)sender
{
    [AMUncauchExceptionHandler postException:@"testException"];
}



@end
