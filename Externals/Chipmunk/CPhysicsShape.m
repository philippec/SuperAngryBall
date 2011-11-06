
//
//  CPhysicsShape.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsShape.h"

#import "CPhysicsBody.h"

@interface CPhysicsShape ()
@property (readwrite, nonatomic, assign) EPhysicShapeType type;
@property (readwrite, nonatomic, strong) id geometry;
@end

@implementation CPhysicsShape

@synthesize type;
@synthesize shape;
@synthesize body;
@synthesize userInfo;

@synthesize geometry;

+ (CPhysicsShape *)shapeWithBallOfRadius:(cpFloat)inRadius center:(cpVect)inCenter
    {
    CPhysicsShape *theShape = [[self alloc] initWithShape:cpCircleShapeNew(NULL, inRadius, inCenter)];
    theShape.type = PhysicShapeType_Circle;
    return(theShape);
    }

+ (CPhysicsShape *)shapeWithBoxOfSize:(CGSize)inSize;
    {
    CPhysicsShape *theShape = [[self alloc] initWithShape:cpBoxShapeNew(NULL, inSize.width, inSize.height)];
    theShape.type = PhysicShapeType_Box;
    return(theShape);
    }
    
+ (CPhysicsShape *)shapeWithCircleOfRadius:(CGFloat)inRadius
    {
    CPhysicsShape *theShape = [[self alloc] initWithShape:cpCircleShapeNew(NULL, inRadius, (CGPoint){ 0, 0 })];
    theShape.type = PhysicShapeType_Circle;
    return(theShape);
    }

+ (CPhysicsShape *)shapeWithRect:(CGRect)inRect;
    {
    CPhysicsShape *theShape = [[self alloc] initWithShape:cpBoxShapeNew2(NULL, (cpBB){ .l = CGRectGetMinX(inRect), .b = CGRectGetMinY(inRect), .r = CGRectGetMaxX(inRect), .t = CGRectGetMaxY(inRect) })];
    theShape.type = PhysicShapeType_Box;
    return(theShape);
    }

+ (CPhysicsShape *)shapeWithPointsOfPolygon:(NSArray *)inPoints;
	{
	NSMutableData *theVertices = [NSMutableData dataWithLength:sizeof(cpVect) * inPoints.count];
	
	cpVect *V = theVertices.mutableBytes;
	for (NSValue *theValue in inPoints)
		{
		*V++ = [theValue CGPointValue];
		}

    CPhysicsShape *theShape = [[self alloc] initWithShape:cpPolyShapeNew(NULL, inPoints.count, (cpVect *)theVertices.bytes, (cpVect){ 0.0, 0.0 })];
    theShape.type = PhysicShapeType_Irregular;

	return(theShape);
	}

+ (CPhysicsShape *)shapeWithSegmentStart:(cpVect)inStart end:(cpVect)inEnd radius:(cpFloat)inRadius
    {
    CPhysicsShape *theShape = [[self alloc] initWithShape:cpSegmentShapeNew(NULL, inStart, inEnd, inRadius)];
    theShape.type = PhysicShapeType_Irregular;
    return(theShape);
    }

- (id)initWithShape:(cpShape *)inShape
    {
    if ((self = [super init]) != NULL)
        {
        shape = inShape;
        shape->data = (TODO_BRIDGE void *)self;
        if (inShape->body)
            {
            body = (TODO_BRIDGE CPhysicsBody *)shape->body->data;
            }
        }
    return(self);
    }

- (void)dealloc
    {
    cpShapeFree(shape);
    shape = NULL;
    }

#pragma mark -

- (void)setBody:(CPhysicsBody *)inBody
    {
    if (body != inBody)
        {
        body = inBody;
        self.shape->body = inBody.CPBody;
        }
    }

- (cpGroup)group
    {
    return(self.shape->group);
    }

- (void)setGroup:(cpGroup)inGroup
    {
    self.shape->group = inGroup;
    }

- (cpFloat)friction
    {
    return(self.shape->u);
    }

- (void)setFriction:(cpFloat)inFriction
    {
    cpShapeSetFriction(self.shape, inFriction);
    }

- (cpFloat)elasticity
    {
    return(self.shape->e);
    }

- (void)setElasticity:(cpFloat)inElasticity
    {
    cpShapeSetElasticity(self.shape, inElasticity);
    }


@end
