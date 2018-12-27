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
    //[self testOne];
    //[self testTwo];
    //[self testThree];
    //[self testFour];

    //2、数组中含有模型，进行拷贝解析
    //[self testModelOne];
    //[self testModelTwo];
    //[self testModelThree];
    //[self testModelFour];

    //3、测试模型的copy和mutableCopy
    //[self testModel];

    //4、研究如何将数组模型全部拷贝出来
    //[self copySimpleModelArray];
    [self copyModelAndModelArray];
}

#pragma mark - 数组中普通元素
#pragma mark - 可变数组进行copy(1.1)
//1.1、会开辟新的内存空间,生成一个新的不可变数组,两个数组之间不受任何影响
- (void)testOne
{
    NSMutableArray *normalArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    id tempArrayOne = [normalArray copy];
    [tempArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    normalArray[0] = @"1000";
    NSLog(@"normalArray = %@",normalArray);
    NSLog(@"normalArray内存地址 = %p",normalArray);
    NSLog(@"tempArrayOne = %@",tempArrayOne);
    NSLog(@"tempArrayOne内存地址 = %p",tempArrayOne);
}

#pragma mark - 不可变数组进行copy(1.2)
//1.2、不会开辟新的内存空间,仍然指向当前数组,说白了就是一个数组
- (void)testTwo
{
    NSArray *normalArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    id tempArrayOne = [normalArray copy];
    [tempArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    NSLog(@"normalArray = %@",normalArray);
    NSLog(@"normalArray内存地址 = %p",normalArray);
    NSLog(@"normalArray指针地址= %x",&normalArray);
    NSLog(@"tempArrayOne = %@",tempArrayOne);
    NSLog(@"tempArrayOne内存地址 = %p",tempArrayOne);
    NSLog(@"tempArrayOne指针地址= %x",&tempArrayOne);
}

#pragma mark - 可变数组进行mutableCopy(1.3)
//1.3、会开辟新的内存空间、生成一个可变数组、两个数组之间相互不影响
- (void)testThree
{
    NSMutableArray *normalArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    id tempArrayOne = [normalArray mutableCopy];
    [tempArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    normalArray[0] = @"1000";
    NSLog(@"normalArray = %@",normalArray);
    NSLog(@"normalArray内存地址 = %p",normalArray);
    NSLog(@"normalArray指针地址= %x",&normalArray);
    NSLog(@"tempArrayOne = %@",tempArrayOne);
    NSLog(@"tempArrayOne内存地址 = %p",tempArrayOne);
    NSLog(@"tempArrayOne指针地址= %x",&tempArrayOne);
}

#pragma mark - 不可变数组进行mutableCopy(1.4)
//1.4、会开辟新的内存空间、生成一个可变数组、两个数组之间相互不影响
- (void)testFour
{
    NSArray *normalArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    id tempArrayOne = [normalArray mutableCopy];
    [tempArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    NSLog(@"normalArray = %@",normalArray);
    NSLog(@"normalArray内存地址 = %p",normalArray);
    NSLog(@"normalArray指针地址= %x",&normalArray);
    NSLog(@"tempArrayOne = %@",tempArrayOne);
    NSLog(@"tempArrayOne内存地址 = %p",tempArrayOne);
    NSLog(@"tempArrayOne指针地址= %x",&tempArrayOne);
}

#pragma mark - 数组中模型元素
#pragma mark - 可变数组(模型)进行copy(2.1)
//2.1、会开辟新的内存空间,生成一个新的不可变数组;模型一样
- (void)testModelOne
{
    //1、初始数组
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    onePerson.age = 1;
    [normalModelArray addObject:onePerson];
    //2、拷贝数组
    id tempModelArrayOne = [normalModelArray copy];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、打印模型信息
    Person *normalPerson = normalModelArray[0];
    Person *tempPerson = tempModelArrayOne[0];
    tempPerson.name = @"temp";
    NSLog(@"normalPerson.name = %@",normalPerson.name);
    NSLog(@"tempPerson.name = %@",tempPerson.name);
    NSLog(@"-----------------------------------");
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
}

#pragma mark - 不可变数组(模型)进行copy(2.2)
//2.2、不会开辟新的内存空间,仍然指向当前数组,说白了就是一个数组;模型一样
- (void)testModelTwo
{
    //数组都不会生成新的、模型肯定一样
}

#pragma mark - 可变数组(模型)进行mutableCopy(2.3)
//2.3、会开辟新的内存空间、生成一个可变数组;但是里面模型一样
- (void)testModelThree
{
    //1、数组初始化
    NSMutableArray *normalModelArray = [[NSMutableArray alloc] init];
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    onePerson.age = 1;
    [normalModelArray addObject:onePerson];
    //2、拷贝数组
    id tempModelArrayOne = [normalModelArray mutableCopy];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、打印模型
    Person *normalPerson = normalModelArray[0];
    Person *tempPerson = tempModelArrayOne[0];
    tempPerson.name = @"temp";
    NSLog(@"normalPerson.name = %@",normalPerson.name);
    NSLog(@"tempPerson.name = %@",tempPerson.name);
    NSLog(@"-----------------------------------");
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"normalArray指针地址= %x",&normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
    NSLog(@"tempArrayOne指针地址= %x",&tempModelArrayOne);
}

#pragma mark - 不可变数组(模型)进行mutableCopy(2.4)
//2.4、会开辟新的内存空间、生成一个可变数组;但是模型一样
- (void)testModelFour
{
    //1、数组初始化
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"onePerson";
    onePerson.age = 1;
    NSArray *normalModelArray = [[NSArray alloc] initWithObjects:onePerson,nil];
    //2、拷贝数组
    id tempModelArrayOne = [normalModelArray mutableCopy];
    [tempModelArrayOne isKindOfClass:[NSMutableArray class]] ? NSLog(@"tempArrayOne可变数组"):NSLog(@"tempArrayOne不可变数组");
    //3、打印模型
    Person *normalPerson = normalModelArray[0];
    Person *tempPerson = tempModelArrayOne[0];
    tempPerson.name = @"temp";
    NSLog(@"normalPerson.name = %@",normalPerson.name);
    NSLog(@"tempPerson.name = %@",tempPerson.name);
    NSLog(@"-----------------------------------");
    NSLog(@"normalArray = %@",normalModelArray);
    NSLog(@"normalArray内存地址 = %p",normalModelArray);
    NSLog(@"normalArray指针地址= %x",&normalModelArray);
    NSLog(@"tempArrayOne = %@",tempModelArrayOne);
    NSLog(@"tempArrayOne内存地址 = %p",tempModelArrayOne);
    NSLog(@"tempArrayOne指针地址= %x",&tempModelArrayOne);
}

#pragma mark - 测试模型
//1、如果你重写Person的copyWithZone和mutableCopyWithZone里面一致,最终使用没有任何差异.
//2、copyWithZone和mutableCopyWithZone内部依然遵循上面的数组法则
//3、但是使用copy和mutableCopy生成的对象不遵循上述规则、
- (void)testModel
{
    NSLog(@"\n");
    Person *onePerson = [[Person alloc] init];
    onePerson.name = @"张三";
    NSLog(@"onePerson内存地址 = %p",onePerson);
    NSLog(@"onePerson.name = %@",onePerson.name);
    NSLog(@"onePerson.name内存地址 = %p",onePerson.name);
    NSLog(@"\n");

    Person *tempOnePerson = [onePerson copy];
    tempOnePerson.name = @"李四";
    NSLog(@"tempOnePerson内存地址 = %p",tempOnePerson);
    NSLog(@"tempOnePerson.name = %@",tempOnePerson.name);
    NSLog(@"tempOnePerson.name内存地址 = %p",tempOnePerson.name);
    NSLog(@"\n");

    Person *tempTwoPerson = [onePerson mutableCopy];
    tempTwoPerson.name = @"王五";
    NSLog(@"tempTwoPerson内存地址 = %p",tempTwoPerson);
    NSLog(@"tempTwoPerson.name = %@",tempTwoPerson.name);
    NSLog(@"tempTwoPerson.name内存地址 = %p",tempTwoPerson.name);
    NSLog(@"\n");
}

#pragma mark - 简单数组模型拷贝
- (void)copySimpleModelArray
{
    //1、简单模型数组初始化
    Person *person = [[Person alloc] init];
    person.name = @"张三";
    NSMutableArray *targetArray = [[NSMutableArray alloc] init];
    [targetArray addObject:person];
    //2、拷贝模型(前提模型要重写copyWithZone)(利用系统方法)
    NSMutableArray *copyArray = [[NSMutableArray alloc] initWithArray:targetArray copyItems:YES];
    Person *originalPerson = [targetArray firstObject];
    Person *onePerson = [copyArray firstObject];
    onePerson.name = @"李四";
    NSLog(@"onePerson.name = %@",onePerson.name);
    //3、逐一添加
    NSMutableArray *copyModelArray = [[NSMutableArray alloc] init];
    for (Person *model in targetArray)
    {
        [copyModelArray addObject:[model copy]];//这里的copy,就是将arr数组里的每一个对象拷贝一份.
    }
    Person *twoPerson = [copyModelArray firstObject];
    twoPerson.name = @"王五";
    NSLog(@"twoPerson.name = %@",twoPerson.name);
    NSLog(@"originalPerson.name = %@",originalPerson.name);
}

#pragma mark - 模型中含有模型
- (void)copyModelAndModelArray
{
    //1、简单模型数组初始化
    Person *person = [[Person alloc] init];
    person.name = @"张三";
    person.son.name = @"张三-儿子";
    NSMutableArray *targetArray = [[NSMutableArray alloc] init];
    [targetArray addObject:person];
    //2、拷贝模型(前提模型要重写copyWithZone)(利用系统方法)
    NSMutableArray *copyArray = [[NSMutableArray alloc] initWithArray:targetArray copyItems:YES];
    Person *originalPerson = [targetArray firstObject];
    Person *onePerson = [copyArray firstObject];
    onePerson.name = @"李四";
    onePerson.son.name = @"李四-傻子";
    //3、逐一添加
    NSMutableArray *copyModelArray = [[NSMutableArray alloc] init];
    for (Person *model in targetArray)
    {
        [copyModelArray addObject:[model copy]];//这里的copy,就是将arr数组里的每一个对象拷贝一份.
    }
    Person *twoPerson = [copyModelArray firstObject];
    twoPerson.name = @"王五";
    twoPerson.son.name = @"王五-天才";
    NSLog(@"\n");
    NSLog(@"originalPerson.name = %@",originalPerson.name);
    NSLog(@"originalPerson.son.name = %@",originalPerson.son.name);
    NSLog(@"\n");
    NSLog(@"onePerson.name = %@",onePerson.name);
    NSLog(@"onePerson.son.name = %@",onePerson.son.name);
    NSLog(@"\n");
    NSLog(@"twoPerson.name = %@",twoPerson.name);
    NSLog(@"twoPerson.son.name = %@",twoPerson.son.name);
    NSLog(@"\n");
}

#pragma mark - 模型中数组含有模型
- (void)copyModelArrayAndModelArray
{

}

#pragma mark - 运行时研究
- (void)runtimeStudy
{

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
//但是模型都是一样的,不会进行深度拷贝

//3、打印指针地址
//打印指针的地址（不是指针指向对象的地址）：NSLog(@"aStr指针内存地址：%x",&aStr);
//打印指针所指向对象的地址使用这个 ：NSLog(@"aStr指针所指向对象的地址：%p",aStr);
//CFGetRetainCount((__bridge CFTypeRef)self  ： 打印retainCount

//参考网址:
//1、https://www.jianshu.com/p/976070ac4949


//4、类似引申还有KVO监听数组(普通元素和模型元素)

@end
