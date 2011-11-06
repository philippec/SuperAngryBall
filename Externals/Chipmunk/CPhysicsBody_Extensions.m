//
//  CPhysicsBody_Extensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody_Extensions.h"

#import "CPhysicsShape.h"
#import "CPhysicsConstraint.h"
#import "OpenGLTypes.h"

@implementation CPhysicsBody (CPhysicsBody_Extensions)

- (CPhysicsShape *)shape
    {
    
    
    NSAssert(self.shapes.count <= 1, @"Expected just 1 shape");
    return([self.shapes lastObject]);
    }

//- (CPhysicsBody *)addWheelAt:(cpVect)inPosition radius:(cpFloat)inRadius motorized:(BOOL)inMotorized rate:(cpFloat)inRate;
//    {
//    CPhysicsBody *theWheelBody = [[CPhysicsBody alloc] initWithMass:1 inertia:cpMomentForCircle(1, 0.0, inRadius, cpvzero)];
//    theWheelBody.position = inPosition;
//
//    CPhysicsShape *theWheelShape = [CPhysicsShape shapeWithBallOfRadius:inRadius];
//    theWheelShape.group = 1;
//    theWheelShape.elasticity = 1.0;
//    theWheelShape.friction = 1.0;
//    [theWheelBody addShape:theWheelShape];
//
//    cpVect theLocalPoint = [self convertPointGlobalToLocal:inPosition];
//
//    CPhysicsConstraint *thePivot = [[CPhysicsConstraint alloc] initWithConstraint:cpPivotJointNew2(self.body, theWheelBody.body, theLocalPoint, cpvzero)];
//    [self addConstraint:thePivot];
//
//    if (inMotorized)
//        {
//        CPhysicsConstraint *theMotor = [[CPhysicsConstraint alloc] initWithConstraint:cpSimpleMotorNew(theWheelBody.body, self.body, inRate)];
//        [self addConstraint:theMotor];
//        }
//
//    [self addSubbody:theWheelBody];
//    
//    return(theWheelBody);
//    }
//
//- (CPhysicsBody *)addShockAbsorberAt:(cpVect)inPosition
//    {
//    return([self addShockAbsorberStart:inPosition end:(cpVect){ inPosition.x, inPosition.y - 20 }]);
//
//////    CPhysicsShape *theCylinderShape = [CPhysicsShape rectShapeWithBody:self frame:(CGRect){ inPosition.x - 5, inPosition.y -5, 10, 10 }];
//////    theCylinderShape.group = 1;
////////    theWheelShape.elasticity = 1.0;
////////    theWheelShape.friction = 5.0;
//////    [self addShape:theCylinderShape];
////
////    CPhysicsBody *theRodBody = [[[CPhysicsBody alloc] initWithMass:1 inertia:cpMomentForBox(1, 2.5, 10)] autorelease];
////    theRodBody.position = (cpVect){ inPosition.x, inPosition.y - 10.0 };
////
////    CPhysicsShape *theRodShape = [CPhysicsShape shapeWithBoxOfSize:(CGSize){ 2.5, 20 }];
////    theRodShape.group = 1;
////    theRodShape.elasticity = 1.0;
////    theRodShape.friction = 1.0;
////    [theRodBody addShape:theRodShape];
////
////    [self addSubbody:theRodBody];
////    
////    cpVect theLocalPoint = [self convertPointGlobalToLocal:inPosition];
////    
////    cpVect P1 = { 0, 0 };
////    cpVect P2 = { 0, +10 };
////    cpVect P3 = theLocalPoint;
////    
////    CPhysicsConstraint *theGroove1 = [[[CPhysicsConstraint alloc] initWithConstraint:cpGrooveJointNew(theRodBody.body, self.body, P1, P2, P3)] autorelease];
////    [self addConstraint:theGroove1]; 
////
////    CPhysicsConstraint *theGear = [[[CPhysicsConstraint alloc] initWithConstraint:cpGearJointNew(theRodBody.body, self.body, 0, 1)] autorelease];
////    [self addConstraint:theGear]; 
////
////
////    CPhysicsConstraint *theSpring = [[[CPhysicsConstraint alloc] initWithConstraint:cpDampedSpringNew(self.body, theRodBody.body, P1, P2, 20, 20, 1.5)] autorelease];
////    [self addConstraint:theSpring]; 
////
////
////    return(theRodBody);
//    }
//
//- (CPhysicsBody *)addShockAbsorberStart:(cpVect)inStart end:(cpVect)inEnd
//    {
//    cpVect theDelta = cpvsub(inEnd, inStart);
//    CGSize theSize = (CGSize){ cpvlength(theDelta) * 0.2, cpvlength(theDelta) };
//    
//    CPhysicsBody *theRodBody = [[CPhysicsBody alloc] initWithMass:1 inertia:cpMomentForBox(1, theSize.width, theSize.height)];
//    theRodBody.position = (cpVect){ (inStart.x + inEnd.x) * 0.5, (inStart.y + inEnd.y) * 0.5 };
//    
//    
//    theRodBody.angle = cpvtoangle(theDelta) + DegreesToRadians(90.0);
//    
//    CPhysicsShape *theRodShape = [CPhysicsShape shapeWithBoxOfSize:theSize];
//    theRodShape.group = 1;
//    theRodShape.elasticity = 1.0;
//    theRodShape.friction = 1.0;
//    [theRodBody addShape:theRodShape];
//
//    [self addSubbody:theRodBody];
//
//    ////////
//    
//    cpVect P1 = [self convertPointGlobalToLocal:inStart];
//    cpVect P2 = [self convertPointGlobalToLocal:inEnd];
//    cpVect P3 = [theRodBody convertPointGlobalToLocal:inStart];
//    
//    CPhysicsConstraint *theGroove1 = [[CPhysicsConstraint alloc] initWithConstraint:cpGrooveJointNew(self.body, theRodBody.body, P1, P2, P3)];
//    [self addConstraint:theGroove1]; 
//
//    CPhysicsConstraint *theGear = [[CPhysicsConstraint alloc] initWithConstraint:cpGearJointNew(self.body, theRodBody.body, 0, 1)];
//    [self addConstraint:theGear]; 
//
//
//    CPhysicsConstraint *theSpring = [[CPhysicsConstraint alloc] initWithConstraint:cpDampedSpringNew(self.body, theRodBody.body, P1, P2, 20, 20, 1.5)];
//    [self addConstraint:theSpring]; 
//
//
//    
//    return(theRodBody);
//    }


@end
