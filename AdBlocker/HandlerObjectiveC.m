//
//  HandlerObjectiveC.m
//  BlockerFinal
//
//  Created by GLB-254 on 1/12/16.
//  Copyright © 2016 globussoft. All rights reserved.
//

#import "HandlerObjectiveC.h"
#import <Parse/Parse.h>
@implementation HandlerObjectiveC
//-(id)generateRules:(PFObject *)obj
//{
//    
//    NSMutableArray * tempArray=[[NSMutableArray alloc]init];
//    
//    NSMutableDictionary * tempDict=[[NSMutableDictionary alloc]init];
//    [tempDict setValue:obj[@"URLFiltre"]  forKey:@"url-filter"];
//  
//    NSMutableDictionary * tempDictActionValues=[[NSMutableDictionary alloc]init];
//    [tempDictActionValues setValue:obj[@"type"]  forKey:@"type"];
//    
//    NSMutableDictionary * tempUrlFiltre=[[NSMutableDictionary alloc]init];
//    [tempUrlFiltre setObject:tempDict forKey:@"trigger"];
//    [tempUrlFiltre setValue:tempDictActionValues   forKey:@"action"];
//    
//    [tempArray addObject:tempUrlFiltre];
//   
//    return tempArray;
//}
-(id)generateRules:(PFObject *)obj
{
    
    //NSMutableArray * tempArray=[[NSMutableArray alloc]init];
    
    NSMutableDictionary * tempDict=[[NSMutableDictionary alloc]init];
    [tempDict setValue:obj[@"URLFilter"]  forKey:@"url-filter"];
    
//    NSMutableDictionary * tempDictActionValues=[[NSMutableDictionary alloc]init];
//    [tempDictActionValues setValue:obj[@"Type"]  forKey:@"type"];
//    
//    
//    NSMutableDictionary * selectorValues=[[NSMutableDictionary alloc]init];
//    [selectorValues setValue:obj[@"Selector"]  forKey:@"selector"];
    

  //  NSArray *actionArr=[NSArray arrayWithObjects:tempDictActionValues,selectorValues, nil];
    
    NSDictionary *actionDict=@{
                               @"type":obj[@"Type"],
                             @"selector":obj[@"Selector"]
                              };
    
    
    NSMutableDictionary * tempUrlFiltre=[[NSMutableDictionary alloc]init];
    [tempUrlFiltre setObject:tempDict forKey:@"trigger"];
    //[tempUrlFiltre setValue:tempDictActionValues   forKey:@"action"];
    [tempUrlFiltre setValue:actionDict forKey:@"action"];
    
    return tempUrlFiltre;
}

@end
