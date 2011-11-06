//
//  CPhysicsShape.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "chipmunk.h"

@class CPhysicsBody;

typedef enum {
    PhysicShapeType_Circle,
    PhysicShapeType_Box,
    PhysicShapeType_Irregular,
    } EPhysicShapeType;

@interface CPhysicsShape : NSObject {

}

@property (readonly, nonatomic, assign) EPhysicShapeType type;
@property (readonly, nonatomic, assign) cpShape *shape;
@property (readwrite, nonatomic, weak) CPhysicsBody *body;
@property (readwrite, nonatomic, assign) id userInfo;
@property (readwrite, nonatomic, assign) cpGroup group;
@property (readwrite, nonatomic, assign) cpFloat friction;
@property (readwrite, nonatomic, assign) cpFloat elasticity;

+ (CPhysicsShape *)shapeWithBallOfRadius:(cpFloat)inRadius center:(cpVect)inCenter;
+ (CPhysicsShape *)shapeWithBoxOfSize:(CGSize)inSize;
+ (CPhysicsShape *)shapeWithCircleOfRadius:(CGFloat)inRadius;
+ (CPhysicsShape *)shapeWithRect:(CGRect)inRect;
+ (CPhysicsShape *)shapeWithPointsOfPolygon:(NSArray *)inPoints;
+ (CPhysicsShape *)shapeWithSegmentStart:(cpVect)inStart end:(cpVect)inEnd radius:(cpFloat)inRadius;

- (id)initWithShape:(cpShape *)inShape;

@end
