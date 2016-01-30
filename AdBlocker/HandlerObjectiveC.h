//
//  HandlerObjectiveC.h
//  BlockerFinal
//
//  Created by GLB-254 on 1/12/16.
//  Copyright © 2016 globussoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface HandlerObjectiveC : NSObject
-(id)generateRules:(PFObject *)obj;
@end
