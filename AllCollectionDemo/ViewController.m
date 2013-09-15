//
//  ViewController.m
//  AllCollectionDemo
//
//  Created by techmaster on 9/14/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+Dump.h"
#import "NSArray+NSArray_Extent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)basicArray:(id)sender {
    NSArray * array = @[@"a String", @3.14158, self, self.view];
    NSLog(@"tuannv");
    [array display];
    
    NSLog(@"display");
    
    for (id object in array) {
        NSLog(@"%@", object);
    }
    
    NSArray * twoDArray = @[@[@"C11", @"C12", @"C13"],
                            @[@"C21", @"C22", @"C23", @"C24"],
                            @[@"C31", @"C32", @"C33"]];
    
    for (id subArray in twoDArray) {
        for (id object in subArray) {
            NSLog(@"%@", object);  //thử in các phần tử cùng hàng chỉ trên một hàng thì bằng cách nào?
        }
    }
    
    id aObject = twoDArray[2][2];
    NSLog(@"%@", aObject);
    
    @try {
        id aGhostObject = twoDArray[2][5];
        NSLog(@"%@", aGhostObject);
    }
    @catch (NSException *exception) {
        NSLog(@"Error: %@", exception.name);
    }
        
}

- (IBAction)cArray:(id)sender {
    int intArray[] = {12, 13, 15, 16, 17, 18, 19};
    int count =  sizeof(intArray)/sizeof(intArray[0]);
    for (int i = 0; i < count; i++) {
        printf("%d\n", intArray[i]);
    }
    
    id funArray[] = {@"Hello World", self, self.view, @3.14158}; //Đây là C array lưu trữ các phần tử NSObject
    for (int i=0; i < 4; i++) {
        NSLog(@"%@", funArray[i]);
    }
}

- (IBAction)loadDataFromPlist:(id)sender {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"array" ofType:@"plist"];
    NSLog(@"Path: %@",dataPath);
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:dataPath];
    for (id object in array) {
        NSLog(@"%@", object);
    }
    
    [array dump];

}
- (IBAction)explodeString:(id)sender {
    NSString *string = @"This.is.a.monkey.in.the.air";
    NSArray *array = [string componentsSeparatedByString:@"."];    
    [array dump];
}

- (IBAction)mutableArray:(id)sender {
    NSMutableArray *muArray = [[NSMutableArray alloc] initWithArray:
    @[@"MU", @"Barcelona", @"Real Madrid", @"Asernal"]];
    
    [muArray exchangeObjectAtIndex:0 withObjectAtIndex:3];
    [muArray dump];
    
    [muArray addObjectsFromArray:@[@"Everton", @"Chievo", @"AC Milan", @"TheCong"]];
    [muArray dump];
}
- (IBAction)demoPredicate:(id)sender {
    //http://nshipster.com/nspredicate/
    NSArray *numArr = @[@3.14158, @2, @-2, @-100, @110, @98, @-108];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF > 0.0 && SELF < 100"];
    
    NSArray *positiveArray = [numArr filteredArrayUsingPredicate:pred];
    
    [positiveArray dump];
    static NSString * FNKey = @"fname";
    static NSString * LNKey = @"lname";
    NSArray *peopeArr = @[@{FNKey: @"Trinh", LNKey: @"Cuong"},
                          @{FNKey: @"Nguyen", LNKey: @"Thanh"}];
    NSPredicate *predS = [NSPredicate predicateWithFormat:@"SELF[fname] like 'Trinh'"];
    
}


//Bai tap ve nha.
- (IBAction)action_random:(id)sender {
    

        NSString* path = [[NSBundle mainBundle] pathForResource:@"putin"
                                                         ofType:@"txt"];
        NSString* content = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        
    
        
    NSArray *arrayString = [content componentsSeparatedByString:@" "];
    NSCountedSet *countedSet = [[NSCountedSet alloc]initWithArray:arrayString];
    NSArray *sortedArray = [NSArray arrayWithArray:[countedSet allObjects]];
    
    sortedArray = [sortedArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    static NSString * FNKey = @"fname"; //ten tu
    static NSString * LNKey = @"lname"; //chieu dai tu
    NSMutableArray *keyWordArr = [[NSMutableArray alloc]init];
    NSLog(@"-----sort alpha string------");
    for (id object in sortedArray) {
        
        int count = [countedSet countForObject:object];
        NSLog(@"%@ - %d ", object, count);
        [keyWordArr addObject:@{FNKey : object, LNKey: [NSNumber numberWithInt:count]}];
        
    }  
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"lname"
                                                                      ascending:YES];
   
    NSArray *arraySortedLeng = [keyWordArr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    NSLog(@"-----sort length string------");
    for (id object in arraySortedLeng) {
        NSLog(@"%@", object );
    }
     
}
@end
