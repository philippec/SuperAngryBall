//
//  CPhysicsShape_GeometryExtensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsShape_GeometryExtensions.h"

#import "OpenGLTypes.h"
#import "CVertexBufferReference_FactoryExtensions.h"
#import "CVertexBufferReference.h"
#import "CSceneGeometry.h"
#import "CSceneGeometry_ConvenienceExtensions.h"
#import "CVertexBuffer.h"
#import "CGameSceneGeometry.h"

@implementation CPhysicsShape (CPhysicsShape_GeometryExtensions)

- (CSceneNode *)geometry
    {
    if (self.userInfo == NULL)
        {
        CGRect theBounds = {};
        cpShape *theShape = self.shape;

        GLenum theType;
        CVertexBufferReference *theVertexBufferReference = NULL;
        if (self.type == PhysicShapeType_Circle)
            {
            CGPoint theCenter = cpCircleShapeGetOffset(theShape);
            cpFloat theRadius = cpCircleShapeGetRadius(theShape);
            theVertexBufferReference = [CVertexBufferReference vertexBufferReferenceWithCircleWithRadius:theRadius center:theCenter points:MAX(theRadius / 40.0 * 30.0, 16)];
            theType = GL_TRIANGLE_FAN;
            theBounds = (CGRect){
                .origin = { .x = theCenter.x - theRadius, .y = theCenter.y - theRadius },
                .size = { .width = theRadius * 2, .height = theRadius * 2 },
                };
            }
        else if (self.type == PhysicShapeType_Box)
            {
                int theVertexCount = cpPolyShapeGetNumVerts(theShape);
                
                NSMutableData *theData = [NSMutableData dataWithLength:sizeof(Vector2) * (theVertexCount + 1)];
                Vector2 *V = theData.mutableBytes;
                        
                for (int N = 0; N != theVertexCount; ++N)
                    {
                    cpVect theVector = cpPolyShapeGetVert(theShape, N);
                    *V++ = (Vector2){ theVector.x, theVector.y };
                    }

                cpVect theVector = cpPolyShapeGetVert(theShape, 0);
                *V++ = (Vector2){ theVector.x, theVector.y };

                CVertexBuffer *theBuffer = [[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theData];
                theVertexBufferReference = [[CVertexBufferReference alloc] initWithVertexBuffer:theBuffer cellEncoding:@encode(Vector2) normalized:NO];
                theType = GL_TRIANGLE_STRIP;
            }
        else if (self.type == PhysicShapeType_Irregular)
            {
            if (theShape->klass->type == CP_SEGMENT_SHAPE)
                {
                cpVect A = cpSegmentShapeGetA(theShape);
                cpVect B = cpSegmentShapeGetB(theShape);
                Vector2 theVertices[] = {
                    { A.x, A.y },
                    { B.x, B.y },
                    };

                NSData *theData = [NSData dataWithBytes:theVertices length:sizeof(theVertices)];
                CVertexBuffer *theBuffer = [[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theData];
                theVertexBufferReference = [[CVertexBufferReference alloc] initWithVertexBuffer:theBuffer cellEncoding:@encode(Vector2) normalized:NO];
                theType = GL_LINES;
                }
            else if (theShape->klass->type == CP_POLY_SHAPE)
                {
                int theVertexCount = cpPolyShapeGetNumVerts(theShape);
                
                NSMutableData *theData = [NSMutableData dataWithLength:sizeof(Vector2) * (theVertexCount + 1)];
                Vector2 *V = theData.mutableBytes;
                        
                for (int N = 0; N != theVertexCount; ++N)
                    {
                    cpVect theVector = cpPolyShapeGetVert(theShape, N);
                    *V++ = (Vector2){ theVector.x, theVector.y };
                    }

                cpVect theVector = cpPolyShapeGetVert(theShape, 0);
                *V++ = (Vector2){ theVector.x, theVector.y };

                CVertexBuffer *theBuffer = [[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theData];
                theVertexBufferReference = [[CVertexBufferReference alloc] initWithVertexBuffer:theBuffer cellEncoding:@encode(Vector2) normalized:NO];
                theType = GL_LINE_LOOP;
                }
            }

        
        CGameSceneGeometry *theGeometry = [CGameSceneGeometry sceneGeometryWithType:theType program:NULL coordinatesBufferReference:theVertexBufferReference];
        theGeometry.coordinatesBufferReference = theVertexBufferReference;
        theGeometry.bounds = theBounds;
        theGeometry.shape = self;
        
        self.userInfo = theGeometry;
        }
    
    return(self.userInfo);
    }

@end
