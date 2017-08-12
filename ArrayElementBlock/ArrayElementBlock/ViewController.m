//
//  ViewController.m
//  ArrayElementBlock
//
//  Created by 曲终叶落 on 2017/8/13.
//  Copyright © 2017年 曲终叶落. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = @[@"3",@"3",@"3",@"10",@"15",@"15",@"15",@"10",@"10",@"3",@"30",@"30",@"3",@"25",@"25"];
    [self elementBlockWithArray:array];
}


/**
 关键算法

 @param array array
 */
- (void)elementBlockWithArray:(NSArray *)array{
    
    NSString *temp;
    
    NSInteger index = 0;
    
    NSMutableArray *dictArray = [NSMutableArray array];
    
    int i;
    
    for (i = 0; i < array.count ;i++) {
        
        if (![temp isEqualToString:array[i]]) {
            
            temp = array[i];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:temp,@"value",@0,@"length",nil];
            
            if (dictArray.count > 0) {
                [dictArray.lastObject setObject:@(i - index) forKey:@"length"];
            }
            
            [dictArray addObject:dict];
            index = i;
        }
    }
    
    [dictArray.lastObject setObject:@(array.count - index) forKey:@"length"];
    
    [self creatLabelWithDictArray:dictArray];
}

- (void)creatLabelWithDictArray:(NSArray *)dictArray{
    
    CGFloat onceWidth = 25.0;
    
    CGFloat x = 0;
    
    CGFloat y = 50.0;
    
    CGFloat height= 60.0;

    // 间隙
    CGFloat gap = 2.0;
    
    for (int i = 0; i < dictArray.count; i++) {
        
        NSMutableDictionary *dict = dictArray[i];
        
        NSInteger length = [dict[@"length"] integerValue];
        NSString *value = dict[@"value"];
        
        if (i > 0) {
            NSMutableDictionary  *preDict = dictArray[i - 1];
            NSInteger preLength = [preDict[@"length"] integerValue];
            x = x + preLength * onceWidth;
        }

        UILabel *lb = [[UILabel alloc] initWithFrame:(CGRectMake(x+gap/2, y, onceWidth * length - gap, height))];
        lb.numberOfLines = 2;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = [NSString stringWithFormat:@"%@\n%@个",value,dict[@"length"]];
        lb.textColor = [UIColor whiteColor];
        lb.font = [UIFont systemFontOfSize:14];
        if (length == 1) {
            lb.backgroundColor = [UIColor cyanColor];
        }else if (length == 2) {
            lb.backgroundColor = [UIColor redColor];
        }else{
            lb.backgroundColor = [UIColor greenColor];
        }
        
        [self.view addSubview:lb];
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
