//
//  CPhysicsBody.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody.h"

#import "CPhysicsShape.h"
#import "CPhysicsSpace.h"

@interface CPhysicsBody ()

@property (readwrite, nonatomic, strong) NSMutableArray *mutableSubbodies;
@property (readwrite, nonatomic, strong) NSMutableArray *mutableShapes;
@property (readwrite, nonatomic, strong) NSMutableArray *mutableConstraints;

@end

#pragma mark -

@implementation CPhysicsBody

@synthesize space;
@synthesize CPBody;
@synthesize userInfo;

@synthesize mutableSubbodies;
@synthesize mutableShapes;
@synthesize mutableConstraints;

- (id)initWithCPBody:(cpBody *)inBody;
    {
    if ((self = [super init]) != NULL)
        {
        CPBody = inBody;
        CPBody->data = (TODO_BRIDGE void *)self;
        }
    return(self);
    }

- (id)initWithMass:(cpFloat)inMass inertia:(cpFloat)inInertia
    {
    if ((self = [self initWithCPBody:cpBodyNew(inMass, inInertia)]) != NULL)
        {
        }
    return(self);
    }

- (id)initWithMass:(cpFloat)inMass inertia:(cpFloat)inInertia shape:(CPhysicsShape *)inShape;
    {
    if ((self = [self initWithMass:inMass inertia:inInertia]) != NULL)
        {
        [self addShape:inShape];
        }
    return self;
    }

- (void)dealloc
    {
    if (CPBody)
        {
        cpBodyFree(CPBody);
        CPBody = NULL;
        }
    }
    
- (NSString *)description
    {
    return([NSString stringWithFormat:@"%@ (%@)", [super description], NSStringFromCGPoint(self.position)]);
    }

    
#pragma mark -

- (NSArray *)subbodies
    {
    return(self.mutableSubbodies);
    }
    
- (NSArray *)shapes
    {
    return(self.mutableShapes);
    }
    
- (NSArray *)constraints
    {
    return(self.mutableConstraints);
    }
    
#pragma mark -    

- (cpVect)position
    {
    NSAssert(self.CPBody != NULL, @"No body");
    return(cpBodyGetPos(self.CPBody));
    }

- (void)setPosition:(cpVect)inPosition
    {
    NSAssert(self.CPBody != NULL, @"No body");
    cpBodySetPos(self.CPBody, inPosition);
    }
    
- (cpVect)velocity
    {
    NSAssert(self.CPBody != NULL, @"No body");
    return(cpBodyGetVel(self.CPBody));
    }

- (void)setVelocity:(cpVect)inVelocity
    {
    NSAssert(self.CPBody != NULL, @"No body");
    cpBodySetVel(self.CPBody, inVelocity);
    }
    
- (Matrix4)modelMatrix
    {
    NSAssert(self.CPBody != NULL, @"No body");
    cpVect thePosition = cpBodyGetPos(self.CPBody);
    return(Matrix4MakeTranslation(thePosition.x, thePosition.y, 0));
    }
    
- (cpFloat)angle
    {
    NSAssert(self.CPBody != NULL, @"No body");
    return(cpBodyGetAngle(self.CPBody));
    }

- (void)setAngle:(cpFloat)inAngle
    {
    NSAssert(self.CPBody != NULL, @"No body");
    cpBodySetAngle(self.CPBody, inAngle);
    }


#pragma mark -

- (void)addSubbody:(CPhysicsBody *)inSubbody
    {
    if (self.mutableSubbodies == NULL)
        {
        self.mutableSubbodies = [NSMutableArray array];
        }
    [self.mutableSubbodies addObject:inSubbody];
    }

- (void)addShape:(CPhysicsShape *)inShape
    {
    if (self.space != NULL && self != self.space.staticBody)
        {
        [self.space addShape:inShape];
        }
    
    inShape.body = self;
    
    if (self.mutableShapes == NULL)
        {
        self.mutableShapes = [NSMutableArray array];
        }
    [self.mutableShapes addObject:inShape];
    }

- (void)addConstraint:(CPhysicsConstraint *)inConstraint
    {
    if (self.mutableConstraints == NULL)
        {
        self.mutableConstraints = [NSMutableArray array];
        }
    [self.mutableConstraints addObject:inConstraint];
    }

- (cpVect)convertPointGlobalToLocal:(cpVect)inPoint;
    {
    return((cpVect){ .x = inPoint.x - self.position.x, .y = inPoint.y - self.position.y });
    }


@end
