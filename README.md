# ArrayElementBlock


数组相邻且相等元素进行分块形成新的数组


![image](https://raw.githubusercontent.com/quzhongyeluo/ArrayElementBlock/master/Simulator%20Screen%20Shot%202017%E5%B9%B48%E6%9C%8813%E6%97%A5%2001.52.43.png)

定义一个数组
```
NSArray *array = @[@"3",@"3",@"3",@"10",@"15",@"15",@"15",@"10",@"10",@"3",@"30",@"30",@"3",@"25",@"25"];
```


关键方法
```
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

}
```
根据字典数组创建Label
```
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
```
