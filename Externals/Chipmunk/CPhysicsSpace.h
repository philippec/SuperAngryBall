//
//  CPhysicsSpace.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "chipmunk.h"

@class CPhysicsBody;
@class CPhysicsShape;
@class CPhysicsConstraint;

@interface CPhysicsSpace : NSObject {

}

@property (readonly, nonatomic, assign) cpSpace *space;

@property (readwrite, nonatomic, assign) cpFloat simulationRate;
@property (readwrite, nonatomic, assign) cpFloat simulationSteps;;

@property (readwrite, nonatomic, assign) cpVect gravity;
@property (readwrite, nonatomic, assign) cpFloat iterations;
//@property (readwrite, nonatomic, assign) cpFloat elasticIterations;
@property (readwrite, nonatomic, assign) cpFloat damping;

@property (readonly, nonatomic, strong) NSArray *bodies;
@property (readonly, nonatomic, strong) NSArray *shapes;

@property (readonly, nonatomic, strong) CPhysicsBody *staticBody;

- (id)init;

- (void)addBody:(CPhysicsBody *)inBody;
- (void)addShape:(CPhysicsShape *)inShape;

- (void)addConstraint:(CPhysicsConstraint *)inConstraint;

- (void)step;

- (void)dump;

@end
