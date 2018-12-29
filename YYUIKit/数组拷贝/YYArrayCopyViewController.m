//
//  YYArrayCopyViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/26.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYArrayCopyViewController.h"
#import "Son.h"
#import "Person.h"

@interface YYArrayCopyViewController ()

@end

@implementation YYArrayCopyViewController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1、copy与mutableCopy解析
    //[self testOne];//不可变数组进行copy
    //[self testTwo];//可变数组进行copy
    //[self testThree];//不可变数组进行mutableCopy
    //[self testFour];//可变数组进行mutableCopy

    //2、数组中含有模型、进行分析
    //[self testModelArray];//测试mutableCopy对模型是否有效

    //3、测试initWithArray:copyItems
    //[self testModelArrayWithBasicElementUseCopyItems];//测试模型中的基本元素
    //[self testModelArrayWithModelUseCopyItems];//测试模型中的模型
    [self testModelArrayWithModelArrayUseCopyItems];//测试模型中的数组(包含模型)

    //4、测试归档和解档
    //[self testModelArrayWithBasicElementUseNSKeyedArchiver];//测试模型中的基本元素
    //[self testModelArrayWithModelUseNSKeyedArchiver];//测试模型中的模型
    //[self testModelArrayWithModelArrayUseNSKeyedArchiver];//测试模型中的数组(包含模型)
}

#pragma mark - 数组中普通元素
#pragma mark - 不可变数组进行copy(1.1)
//1.1、不会开辟新的内存空间,仍然指向当前数组,说白了就是一个数组
- (void)testOne
{
    NSArray *normalArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    id tempArray = [normalArray copy];
    [tempArray isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");

    NSLog(@"normalArray内存地址 = %p",normalArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempArray);
}

#pragma mark - 可变数组进行copy(1.2)
//1.2、会开辟新的内存空间,生成一个新的不可变数组,两个数组之间不受任何影响
- (void)testTwo
{
    NSMutableArray *normalArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    id tempArray = [normalArray copy];
    [tempArray isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    normalArray[0] = @"1000";//修改数组元素
    NSLog(@"normalArray内存地址 = %p",normalArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempArray);
    NSLog(@"normalArray = %@",normalArray);
    NSLog(@"tempArrayOne = %@",tempArray);
}

#pragma mark - 不可变数组进行mutableCopy(1.3)
//1.3、会开辟新的内存空间、生成一个可变数组、两个数组之间相互不影响
- (void)testThree
{
    NSArray *normalArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    id tempArray = [normalArray mutableCopy];
    [tempArray isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    tempArray[0] = @"1000";//改变数组
    NSLog(@"normalArray = %@",normalArray);
    NSLog(@"tempArrayOne = %@",tempArray);
    NSLog(@"normalArray内存地址 = %p",normalArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempArray);
}

#pragma mark - 可变数组进行mutableCopy(1.4)
//1.4、会开辟新的内存空间、生成一个可变数组、两个数组之间相互不影响
- (void)testFour
{
    NSMutableArray *normalArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    id tempArrayOne = [normalArray mutableCopy];
    [tempArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    normalArray[0] = @"1000";
    NSLog(@"normalArray = %@",normalArray);
    NSLog(@"tempArrayOne = %@",tempArrayOne);
    NSLog(@"normalArray内存地址 = %p",normalArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempArrayOne);
}

#pragma mark - 数组中装有模型元素
#pragma mark - 测试mutableCopy是否有效
- (void)testModelArray
{
    //1、初始数组
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    [normalModelArray addObject:onePerson];
    //2、拷贝数组
    id tempModelArrayOne = [normalModelArray mutableCopy];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、打印模型信息
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
}

#pragma mark - 测试initWithArray:copyItems:
#pragma mark - 模型中的基本元素---copyItems
//生成新的Person模型，开辟新的存储空间，Person模型基本元素相互不影响
- (void)testModelArrayWithBasicElementUseCopyItems
{
    //1、初始数组
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    [normalModelArray addObject:onePerson];
    //2、拷贝数组
    id tempModelArrayOne = [[NSMutableArray alloc] initWithArray:normalModelArray copyItems:YES];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、改变其中一个元素信息
    onePerson.name = @"我改变了哈";
    //4、打印模型信息
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
}

#pragma mark - 模型中的模型---copyItems
//生成新的Son模型，开辟新的存储空间，Son模型基本元素相互不影响
- (void)testModelArrayWithModelUseCopyItems
{
    //1、初始数组
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    onePerson.son.name = @"张三";
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    [normalModelArray addObject:onePerson];
    //2、拷贝数组
    id tempModelArrayOne = [[NSMutableArray alloc] initWithArray:normalModelArray copyItems:YES];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、改变其中一个元素信息
    onePerson.name = @"我改变了哈";
    onePerson.son.name = @"李四";
    //4、打印模型信息
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
}

#pragma mark - 模型中的数组(包含模型)---copyItems
//主模型数组中的模型不会开辟新的内存空间，仍然是同一个对象
- (void)testModelArrayWithModelArrayUseCopyItems
{
    //1、初始数组
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    Son *son = [[Son alloc] init];
    son.name = @"儿子";
    [onePerson.modelArray addObject:son];
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    [normalModelArray addObject:onePerson];
    //2、拷贝数组
    id tempModelArrayOne = [[NSMutableArray alloc] initWithArray:normalModelArray copyItems:YES];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、改变其中一个元素信息
    son.name = @"改变儿子";
    //4、打印模型信息
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
}

#pragma mark - 测试归档和解档
#pragma mark - 模型中的基本元素---归档和解档
//生成新的Person模型，开辟新的存储空间，Person模型基本元素相互不影响
- (void)testModelArrayWithBasicElementUseNSKeyedArchiver
{
    //1、初始数组
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    [normalModelArray addObject:onePerson];
    //2、归档和解档
    NSArray* trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:normalModelArray]];
    id tempModelArrayOne = [[NSMutableArray alloc] initWithArray:trueDeepCopyArray copyItems:YES];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、改变其中一个元素信息
    onePerson.name = @"我改变了哈";
    //4、打印模型信息
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
}

#pragma mark - 模型中的模型---归档和解档
//生成新的Son模型，开辟新的存储空间，Son模型基本元素相互不影响
- (void)testModelArrayWithModelUseNSKeyedArchiver
{
    //1、初始数组
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    onePerson.son.name = @"张三";
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    [normalModelArray addObject:onePerson];
    //2、归档和接档
    NSArray* trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:normalModelArray]];
    id tempModelArrayOne = [[NSMutableArray alloc] initWithArray:trueDeepCopyArray copyItems:YES];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、改变其中一个元素信息
    onePerson.name = @"我改变了哈";
    onePerson.son.name = @"李四";
    //4、打印模型信息
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
}

#pragma mark - 模型中的数组(包含模型)---归档和解档
//主模型数组中的模型会开辟新的内存空间，模型之间相互不影响
- (void)testModelArrayWithModelArrayUseNSKeyedArchiver
{
    //1、初始数组
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    Son *son = [[Son alloc] init];
    son.name = @"儿子";
    [onePerson.modelArray addObject:son];
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    [normalModelArray addObject:onePerson];
    //2、归档和解档
    NSArray* trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:normalModelArray]];
    id tempModelArrayOne = [[NSMutableArray alloc] initWithArray:trueDeepCopyArray copyItems:YES];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、改变其中一个元素信息
    son.name = @"改变儿子";
    //4、打印模型信息
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
}


//以上总结:
//1、对装有简单元素的数组对比解析结果:
//copy会生成一个不可变对象
//mutableCopy会生成一个可变对象
//可变数组不论用copy还是mutableCopy,都会生成新的数组;只不过用copy产生不可变数组,用mutableCopy产生可变数组
//不可变数组用copy不产生新的数组,用mutableCopy产生新的数组,而且是可变数组
//String类型和数组类似

//2、对装有模型的数组对比解析结果:
//数组仍然遵循上面讲的
//但是模型(或者json)都是一样的,不会进行深度拷贝;只有基本元素会可以

//3、打印指针地址
//打印指针的地址（不是指针指向对象的地址）：NSLog(@"aStr指针内存地址：%x",&aStr);
//打印指针所指向对象的地址使用这个 ：NSLog(@"aStr指针所指向对象的地址：%p",aStr);
//CFGetRetainCount((__bridge CFTypeRef)self  ： 打印retainCount

//4、必考问题:
//1、对NSString执行copy后, 是深拷贝还是浅拷贝?
//2、对NSMutableString执行copy后, 是深拷贝还是浅拷贝?
//3、对数组进行Copy后, 是深拷贝还是浅拷贝?
//4、对数组进行Copy后, 修改旧数组内指针执行对象的内容, 新数组对象内容是否改变?
//5、对数组进行mutableCopy呢?
//6、NSArray *newArray = [[NSArray alloc] initWithArray:oldArray]. 对newArray的元素所指的指针进行操作, 会影响oldArray吗?
//7、如何实现数组的内容Copy?

//5、问题隐身:类似引申还有KVO监听数组(普通元素和模型元素)

//参考网址:
//1、https://www.jianshu.com/p/976070ac4949

@end
