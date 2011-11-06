//
//  CMyRenderer.m
//  AngryBirdsClone
//
//  Created by Jonathan Wight on 11/6/11.
//  Copyright (c) 2011 toxicsoftware.com. All rights reserved.
//

#import "CGameRenderer.h"

#import "CSceneGeometry.h"
#import "CSceneGeometry_ConvenienceExtensions.h"
#import "CVertexBufferReference_FactoryExtensions.h"
#import "CSceneStyle.h"
#import "UIColor_OpenGLExtensions.h"
#import "CPhysicsSpace.h"
#import "CPhysicsShape_GeometryExtensions.h"
#import "CPhysicsBody.h"
#import "CPhysicsBody_GeometryExtensions.h"
#import "CSceneNode.h"
#import "CGameLevel.h"
#import "CPhysicsBody_Extensions.h"

static void updateShape(cpShape *shape, void *data);

@interface CGameRenderer ()

@property (readwrite, nonatomic, strong) CSceneGeometry *geometry;
@property (readwrite, nonatomic, strong) CPhysicsSpace *space;

@end

#pragma mark -

@implementation CGameRenderer

@synthesize geometry;
@synthesize space;
@synthesize playing;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        self.space = [[CPhysicsSpace alloc] init];
        self.space.gravity = (CGPoint){ .y = -100 };
        
        CGameLevel *theLevel = [[CGameLevel alloc] init];
        theLevel.space = self.space;

        NSURL *theURL = [[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"Levels/Blank.graffle/data.plist"];
        [theLevel load:theURL];

        for (CPhysicsShape *theShape in self.space.shapes)
            {
            theShape.geometry.identifier = @"Body";
            
            [self.rootNode addSubnode:theShape.geometry];
            }

//        for (CPhysicsBody *theBody in self.space.bodies)
//            {
//            theBody.geometry.transform = theBody.modelMatrix;
//            }

        [self.space step];
        cpSpaceEachShape(self.space.space, updateShape, nil);
        }
    return self;
    }
    
- (void)prerender
    {
    [super prerender];
    
    GLfloat theAspectRatio = self.size.width / self.size.height;
    
    Matrix4 theTransform = Matrix4Identity;
    theTransform = Matrix4Translate(theTransform, self.size.width * -0.5, self.size.height * -0.5, 0);
    
    CGFloat F = 1.0 / self.size.width * 2.0 * 1.0;
    
    theTransform = Matrix4Scale(theTransform, F, F, 1.0);

    theTransform = Matrix4Scale(theTransform, 1.0, 1.0 * theAspectRatio, 1.0);


    self.projectionTransform = theTransform;

//        NSLog(@"%@", NSStringFromCGSize(self.size));
    }

- (void)render
    {
    if (self.playing == YES)
        {
        [self.space step];
        }
        
    cpSpaceEachShape(self.space.space, updateShape, nil);

    [super render];
    }

@end


static void updateShape(cpShape *shape, void *data)
    {
	// Get our shape
    CPhysicsShape *theShape = (__bridge CPhysicsShape *)(shape)->data;
    NSCAssert(theShape != NULL, @"No shape");

    CPhysicsBody *theBallBody = theShape.body;

    NSCAssert(theBallBody != NULL, @"No body");
    
    CSceneGeometry *theBallNode = theShape.userInfo;
    
    cpVect thePosition = theBallBody.position;
    cpFloat theAngle = cpBodyGetAngle(theBallBody.CPBody);
    
    Matrix4 theTransform = Matrix4MakeRotation(-theAngle, 0, 0, 1);
    theTransform = Matrix4Translate(theTransform, thePosition.x, thePosition.y, 0);
    
    theBallNode.transform = theTransform;
    }
