//
//  ViewController.m
//  PGQAutoEncode
//
//  Created by Lois_pan on 17/2/22.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "ViewController.h"
#import "AnimalModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button1.backgroundColor = [UIColor grayColor];
    [button1 setTitle:@"encode" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(encodeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 100, 100)];
    button2.backgroundColor = [UIColor grayColor];
    [button2 setTitle:@"decode" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(decodeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

- (AnimalModel *)getAnimalModel {

    AnimalModel * animaModel = [AnimalModel new];
    animaModel.category = @"cat";
    animaModel.age = @"9";
    animaModel.weight = @"8";
    return animaModel;
}

- (void)encodeClick {
    
    NSString * fileNameWithPath = [self getFilePath:@"Animal_ClassAA"];
    [NSKeyedArchiver archiveRootObject:[self getAnimalModel] toFile:fileNameWithPath];
    NSLog(@"归档");
//    NSString * fileNameWithPath = [self getFilePath:@"Animal_Class"];
    
    AnimalModel *animalModel = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    
    NSLog(@"category: %@, age: %@, weight: %@", animalModel.category, animalModel.age, animalModel.weight);

}

- (void)decodeClick {
    
    NSString * fileNameWithPath = [self getFilePath:@"Animal_Class"];

    AnimalModel *animalModel = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    
    NSLog(@"category: %@, age: %@, weight: %@", animalModel.category, animalModel.age, animalModel.weight);
    
}

- (NSString *)getFilePath:(NSString *)fileName {

    if (fileName) {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        return [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.archive", fileName]];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
