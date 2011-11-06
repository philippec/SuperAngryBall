//
//  CPhysicsBody.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "chipmunk.h"

#import "Matrix.h"

@class CPhysicsSpace;
@class CPhysicsConstraint;
@class CPhysicsShape;

@interface CPhysicsBody : NSObject {

}

@property (readwrite, nonatomic, weak) CPhysicsSpace *space;

@property (readonly, nonatomic, assign) cpBody *CPBody;

@property (readonly, nonatomic, strong) NSArray *subbodies;
@property (readonly, nonatomic, strong) NSArray *shapes;
@property (readonly, nonatomic, strong) NSArray *constraints;

@property (readwrite, nonatomic, assign) cpVect position;
@property (readwrite, nonatomic, assign) cpVect velocity;
@property (readonly, nonatomic, assign) Matrix4 modelMatrix;

@property (readwrite, nonatomic, assign) cpFloat angle;

@property (readwrite, nonatomic, strong) id userInfo;

- (id)initWithCPBody:(cpBody *)inBody;
- (id)initWithMass:(cpFloat)inMass inertia:(cpFloat)inInertia;
- (id)initWithMass:(cpFloat)inMass inertia:(cpFloat)inInertia shape:(CPhysicsShape *)inShape;

- (void)addSubbody:(CPhysicsBody *)inSubbody;
- (void)addShape:(CPhysicsShape *)inShape;
- (void)addConstraint:(CPhysicsConstraint *)inConstraint;

- (cpVect)convertPointGlobalToLocal:(cpVect)inPoint;

@end
