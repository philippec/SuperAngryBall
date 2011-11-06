//
//  CPhysicsSpace.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsSpace.h"

#import "CPhysicsBody.h"
#import "CPhysicsShape.h"
#import "CPhysicsConstraint.h"

@interface CPhysicsSpace ()
@property (readwrite, nonatomic, strong) NSMutableArray *mutableBodies;
@property (readwrite, nonatomic, strong) NSMutableArray *mutableShapes;
@property (readwrite, nonatomic, strong) NSMutableArray *mutableConstraints;
@end

@implementation CPhysicsSpace

@synthesize space;
@synthesize simulationRate;
@synthesize simulationSteps;

@synthesize mutableBodies;
@synthesize mutableShapes;
@synthesize mutableConstraints;

@synthesize staticBody;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        cpInitChipmunk();

        space = cpSpaceNew();

        cpSpaceSetIterations(space, 10);
        //	cpSpaceSetDamping(space, 0.5);
        cpSpaceSetSleepTimeThreshold(space, 0.5f);
        cpSpaceSetCollisionSlop(space, 0.1f);

        mutableBodies = [[NSMutableArray alloc] init];
        mutableShapes = [[NSMutableArray alloc] init];
        mutableConstraints = [[NSMutableArray alloc] init];
        
        simulationRate = 1.0;
        simulationSteps = 1;
        }
    return(self);
    }

- (void)dealloc
    {
    cpSpaceFree(space);
    space = NULL;
    }
    
- (NSString *)description
    {
    return([NSString stringWithFormat:@"%@ (gravity: %@)", [super description], NSStringFromCGPoint(self.gravity)]);
    }


#pragma mark -

- (cpVect)gravity
    {
    return(self.space->gravity);
    }

- (void)setGravity:(cpVect)inGravity
    {
    self.space->gravity = inGravity;
    }

- (cpFloat)iterations
    {
    return(self.space->iterations);
    }

- (void)setIterations:(cpFloat)inIterations
    {
    self.space->iterations = inIterations;
    }

//- (cpFloat)elasticIterations
//    {
//    return(self.space->elasticIterations);
//    }
//
//- (void)setElasticIterations:(cpFloat)inElasticIterations
//    {
//    self.space->elasticIterations = inElasticIterations;
//    }

- (cpFloat)damping
    {
    return(self.space->damping);
    }

- (void)setDamping:(cpFloat)inDamping
    {
    self.space->damping = inDamping;
    }

- (NSArray *)bodies
    {
    return(self.mutableBodies);
    }

- (NSArray *)shapes
    {
    return(self.mutableShapes);
    }

- (CPhysicsBody *)staticBody
    {
    if (staticBody == NULL)
        {
        staticBody = [[CPhysicsBody alloc] initWithCPBody:cpSpaceGetStaticBody(self.space)];
        staticBody.space = self;
        }
    return(staticBody);
    }

#pragma mark -

- (void)addBody:(CPhysicsBody *)inBody
    {
    inBody.space = self;
    
    cpSpaceAddBody(self.space, inBody.CPBody);
    [self.mutableBodies addObject:inBody];

    for (CPhysicsBody *theSubbody in inBody.subbodies)
        {
        [self addBody:theSubbody];
        }
    
    for (CPhysicsShape *theShape in inBody.shapes)
        {
        [self addShape:theShape];
        }

    for (CPhysicsConstraint *theConstraint in inBody.constraints)
        {
        [self addConstraint:theConstraint];
        }
    }

- (void)addShape:(CPhysicsShape *)inShape;
    {
    cpSpaceAddShape(self.space, inShape.shape);
    [self.mutableShapes addObject:inShape];
    }

- (void)addConstraint:(CPhysicsConstraint *)inConstraint;
    {
    cpSpaceAddConstraint(self.space, inConstraint.constraint);
    [self.mutableConstraints addObject:inConstraint];
    }

#pragma mark -

- (void)step
    {
    for (int N = 0; N != self.simulationSteps * self.simulationRate; ++N)
        {
        cpSpaceStep(self.space, (1.0f / 60.0f) / self.simulationSteps);  
        }
    }

#pragma mark -

- (void)dump
    {
    NSLog(@"%@", self);
    NSLog(@"Bodies:");
    for (CPhysicsShape *theBody in self.bodies)
        {
        NSLog(@"\t%@", theBody);
        }
    NSLog(@"Shapes:");
    for (CPhysicsShape *theShape in self.shapes)
        {
        NSLog(@"\t%@", theShape);
        }
    
    }

@end
