//
//  ViewController.m
//  testStrong & copy
//
//  Created by 黄少华 on 15/12/22.
//  Copyright © 2015年 黄少华. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *strongArray;
@property (nonatomic, copy)   NSMutableArray *copArray;

@property (nonatomic, strong) NSString *string;
@property (nonatomic, copy) NSString *copString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self immuatableCopyString];
//    [self mutableCopyString];
//    [self immutableCopySet];
//    [self mutableCopyArray];
//    [self testStrongProperty];
//    [self testCopyProperty];
//    [self testArray];
    [self testString];
}

- (void)testString
{
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"MT哥"];
    NSLog(@"str == %@,%p",str,str);
    self.string = str;
    NSLog(@"string == %@,%p",self.string,self.string);//指针拷贝,内存地址一样
    self.copString = str;
    NSLog(@"copyString == %@,%p",self.copString,self.copString);//内容拷贝,指针地址不一样
    
    NSLog(@"修改字符串");
    [str appendString:@"真帅啊"];
    NSLog(@"str == %@,%p",str,str);
    NSLog(@"string == %@,%p",self.string,self.string);
    NSLog(@"copyString == %@,%p",self.copString,self.copString);
}

- (void)testArray{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
    NSLog(@"array = %@,%p",array,array);
    
    self.strongArray = array;//使用strong的是指针拷贝,内存地址一样
    NSLog(@"strongArray = %@,%p",self.strongArray,self.strongArray);
    
    self.copArray = array;//使用copy内容拷贝,内存地址变了
    NSLog(@"copArray = %@,%p",self.copArray,self.copArray);
    
    //修改原来数组内容
    NSLog(@"修改原来数组内容");
    [array removeLastObject];
    NSLog(@"array = %@,%p",array,array);
    NSLog(@"strongArray = %@,%p",self.strongArray,self.strongArray);//跟原来保持一致
    NSLog(@"copArray = %@,%p",self.copArray,self.copArray);//跟原来无关啦

}

- (void)testCopyProperty
{
    NSMutableString *T = [[NSMutableString alloc] initWithString:@"T"];
    
    self.copArray = [NSMutableArray arrayWithArray:@[@"M",T,@"哥"]];
    NSLog(@"copArray = %@,%p,%@,%p,%@,%p",self.copArray,self.copArray,self.copArray[0],self.copArray[0],self.copArray[1],self.copArray[1]);
    
    NSMutableArray *copyArray = [self.copArray copy];
    NSLog(@"copyArray = %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);
    
    NSLog(@"*************修改原来数组内容**************");
    [self.copArray removeLastObject];
    NSLog(@"strongArray = %@,%p,%@,%p,%@,%p",self.copArray,self.copArray,self.copArray[0],self.copArray[0],self.copArray[1],self.copArray[1]);
    NSLog(@"copyArray = %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);
    
    NSLog(@"*************修改新的数组内容**************");
    [self.copArray addObject:@"哥"];
    NSLog(@"copArray = %@,%p,%@,%p,%@,%p",self.copArray,self.copArray,self.copArray[0],self.copArray[0],self.copArray[1],self.copArray[1]);
    NSLog(@"copyArray = %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);
    
    //使用了copy之后再对内容进行修改会报错,因为copy返回的是一个不可变的对象
}

/**
 *  测试用strong关键字修饰的属性
 */
- (void)testStrongProperty
{
    NSMutableString *T = [[NSMutableString alloc] initWithString:@"T"];

    self.strongArray = [NSMutableArray arrayWithArray:@[@"M",T,@"哥"]];
    NSLog(@"strongArray = %@,%p,%@,%p,%@,%p",self.strongArray,self.strongArray,self.strongArray[0],self.strongArray[0],self.strongArray[1],self.strongArray[1]);
    
    NSMutableArray *copyArray = [self.strongArray copy];
    NSLog(@"copyArray = %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);
    
    NSLog(@"*************修改原来数组内容**************");
    [self.strongArray removeLastObject];
    NSLog(@"strongArray = %@,%p,%@,%p,%@,%p",self.strongArray,self.strongArray,self.strongArray[0],self.strongArray[0],self.strongArray[1],self.strongArray[1]);
    NSLog(@"copyArray = %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);

    NSLog(@"*************修改新的数组内容**************");
    [self.strongArray addObject:@"哥"];
    NSLog(@"strongArray = %@,%p,%@,%p,%@,%p",self.strongArray,self.strongArray,self.strongArray[0],self.strongArray[0],self.strongArray[1],self.strongArray[1]);
    NSLog(@"copyArray = %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);

    //可以看出,使用了strong关键字,再进行了copy操作,会复制出一份新的数组,导致copyArray跟原array内存地址不一样,这样修改原来数组,不会影响新数组
}

/**
 *  可变容器的拷贝
 */
- (void)mutableCopyArray
{
    NSMutableString *T = [[NSMutableString alloc] initWithString:@"T"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"M",T,@"哥"]];
    NSLog(@"array == %@,%p,%@,%p,%@,%p",array,array,array[0],array[0],array[1],array[1]);//对于集合类,我们还要看其内容是否被拷贝
    
    NSMutableArray *copyArray = [array copy];
    NSLog(@"copyArray == %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);
    
    NSMutableArray *mutableCopyArray = [array mutableCopy];
    NSLog(@"mutableCopyArray == %@,%p,%@,%p,%@,%p",mutableCopyArray,mutableCopyArray,mutableCopyArray[0],mutableCopyArray[0],mutableCopyArray[1],mutableCopyArray[1]);
    //对可变集合类进行copy操作,会复制容器本身,不会复制内容. 即容器内存地址改变,内容内存地址不变.
    //             mutableCopy操作,同上
    
    NSLog(@"*************可变容器修改内容之后***************");
    [T appendFormat:@"MMMMMMM"];
    NSLog(@"array == %@,%p,%@,%p,%@,%p",array,array,array[0],array[0],array[1],array[1]);//对于集合类,我们还要看其内容是否被拷贝
    NSLog(@"copyArray == %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);
    NSLog(@"mutableCopyArray == %@,%p,%@,%p,%@,%p",mutableCopyArray,mutableCopyArray,mutableCopyArray[0],mutableCopyArray[0],mutableCopyArray[1],mutableCopyArray[1]);
    
    //由于内容地址不变,修改原有内容会导致后面数组里面元素也跟着发生改变
}

/**
 *  对不可变集合类进行拷贝
 */
- (void)immutableCopySet{
    
    NSMutableString *T = [[NSMutableString alloc] initWithString:@"T"];
    NSArray *array = @[@"M",T,@"哥"];
    NSLog(@"array == %@,%p,%@,%p,%@,%p",array,array,array[0],array[0],array[1],array[1]);//对于集合类,我们还要看其内容是否被拷贝
    
    NSArray *copyArray = [array copy];
    NSLog(@"copyArray == %@,%p,%@,%p,%@,%p",copyArray,copyArray,copyArray[0],copyArray[0],copyArray[1],copyArray[1]);//对不可变集合进行copy操作,是浅拷贝,集合内存地址不变,内容内存地址不变
    
    NSArray *mutableCopyArray = [array mutableCopy];
    NSLog(@"mutableCopyArray == %@,%p,%@,%p,%@,%p",mutableCopyArray,mutableCopyArray,mutableCopyArray[0],mutableCopyArray[0],mutableCopyArray[1],mutableCopyArray[1]);//对于不可变集合进行mutableCopy操作,仅仅会拷贝集合本身,集合本身的内存地址改变.但是不会拷贝其内部对象,内部对象内存地址还是一样的.
    
    //总结:对不可变集合来说,copy操作不会复制容器本身,也不会复制容器内部内容,所以容器内存地址跟原容器一致,内容地址一样
//                       mutableCopy操作会对容器本身进行复制,但是不会复制内部内容,所以容器内存地址发生改变,内容不变
}

/**
 *  对可变字符串进行拷贝
 */
- (void)mutableCopyString{
    NSLog(@"非容器类可变对象进行拷贝");
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"MT哥"];
    NSLog(@"str == %@,%p",str,str);
    
    NSMutableString *copyStr = [str copy];
    NSLog(@"copyStr == %@,%p",copyStr,copyStr);
    
    NSMutableString *mutableCopyStr = [str mutableCopy];
    NSLog(@"mutableCopyStr == %@,%p",mutableCopyStr,mutableCopyStr);
    
    NSLog(@"******************修改了原先的内容之后***************");
    [str appendFormat:@"非常帅"];
    NSLog(@"str == %@,%p",str,str);
    NSLog(@"copyStr == %@,%p",copyStr,copyStr);
    NSLog(@"mutableCopyStr == %@,%p",mutableCopyStr,mutableCopyStr);

    //总结: 对可变字符串进行copy与mutableCopy都是深拷贝,内存地址改变,返回结果都是可变对象
    //修改原内容之后不会影响copy的副本
}

/**
 *  对字符串(可以衍生为非容器类对象)进行拷贝测试
 */
- (void)immuatableCopyString{
    NSLog(@"非容器类不可变对象拷贝NSString");
    NSString *str = @"MT哥";
    NSLog(@"str == %@,%p",str,str);
    
    NSString *copyStr = [str copy];
    NSLog(@"copyStr == %@,%p",copyStr,copyStr);//内存地址跟刚才的一样.对非容器类对象进行copy,是浅拷贝,仅仅拷贝内存地址,并不会复制其内容,其返回的是一个不可变对象
    
    NSString *mutableCopyStr = [str mutableCopy];
    NSLog(@"mutableCopyStr == %@,%p,%@",mutableCopyStr,mutableCopyStr,NSStringFromClass([mutableCopyStr class]));//内存地址发生了改变.对于非容器来对象进行mutableCopy,是深拷贝,会拷贝内容,返回的类型是一个可变对象
    
    //对不可变对象进行copy:内存地址不变
    //对不可变对象进行mutableCopy,内存地址改变
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
