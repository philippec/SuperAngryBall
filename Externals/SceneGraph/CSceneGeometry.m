//
//  CGeometryNode.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/23/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CSceneGeometry.h"

#import <QuartzCore/QuartzCore.h>

#import "OpenGLTypes.h"
#import "CVertexBuffer.h"
#import "CProgram.h"
#import "CShader.h"
#import "CTexture.h"
#import "CVertexBufferReference.h"
#import "CSceneGraphRenderer.h"
#import "CSceneStyle.h"
#import "CFlat.h"

@implementation CSceneGeometry

@synthesize bounds;
@synthesize indicesBufferReference;
@synthesize coordinatesBufferReference;
@synthesize textureCoordinatesBufferReference;
@synthesize colorsBufferReference;
@synthesize vertexBuffers;
@synthesize type;

- (CSceneStyle *)style
    {
    CSceneStyle *theStyle = [super style];
    if (theStyle == NULL)
        {
        theStyle = [[CSceneStyle alloc] init];
        [super setStyle:theStyle];
        }
    return(theStyle);
    }

- (void)render:(CSceneGraphRenderer *)inRenderer;
    {
    Matrix4 theModelTransform = [inRenderer mergedTransform];
    CSceneStyle *theStyle = [inRenderer mergedStyle];
    
    // Use shader program
    CFlat *theProgram = (CFlat *)theStyle.program;
    
    [theProgram use];

    AssertOpenGLNoError_();


    // Update uniform value
    theProgram.projectionMatrix = inRenderer.projectionTransform;

    theProgram.modelViewMatrix = theModelTransform;


    theProgram.positions = self.coordinatesBufferReference;

    // Validate program before drawing. This is a good check, but only really necessary in a debug build. DEBUG macro must be defined in your debug configurations if that's not already the case.
    if (theStyle != NULL)
        {
        Color4f theStrokeColor = theStyle.color;
        
        theProgram.color = theStrokeColor;
        }

    if (theStyle.mask & SceneStyleMask_LineWidthFlag)
        {
        glLineWidth(theStyle.lineWidth);
        }

#if defined(DEBUG)
    NSError *theError = NULL;
    if ([theProgram validate:&theError] == NO)
        {
        NSAssert(0, @"OOPS");
        NSLog(@"Failed to validate program (2): %@", theError);
        return;
        }
#endif

    if (self.indicesBufferReference)
        {
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indicesBufferReference.vertexBuffer.name);
        glDrawElements(self.type, self.indicesBufferReference.rowCount, self.indicesBufferReference.type, NULL);
        }
    else
        {
        glDrawArrays(self.type, 0, self.coordinatesBufferReference.rowCount);
        }
    }

- (CSceneNode *)hitTest:(CGPoint)inPoint;
    {
    if (CGRectIsEmpty(self.bounds) == YES)
        {
        NSLog(@"Geometry has no bounds. This is a bug.");
        return(NULL);
        }
    
    Matrix4 theTransform = self.computedTransform;
    CGAffineTransform theComputedTransform = CGAffineTransformFromMatrix4(theTransform);
    CGRect theRect = CGRectApplyAffineTransform(self.bounds, theComputedTransform);
    if (CGRectContainsPoint(theRect, inPoint) == YES)
        {
        return(self);
        }
    else
        {
        return(NULL);
        }
    }

@end
