//
//  CSceneGeometry_ConvenienceExtensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneGeometry_ConvenienceExtensions.h"

#import "CProgram.h"
#import "CVertexBuffer.h"
#import "CVertexBufferReference.h"
#import "CSceneStyle.h"
#import "CProgram_Extensions.h"
#import "CFlat.h"

@implementation CSceneGeometry (CSceneGeometry_ConvenienceExtensions)

+ (CSceneGeometry *)sceneGeometryWithType:(GLenum)inType program:(id)inProgram coordinatesBufferReference:(CVertexBufferReference *)inVertexBufferReference;
    {
    CSceneGeometry *theGeometry = [[self alloc] init];
    theGeometry.type = inType;
    theGeometry.coordinatesBufferReference = inVertexBufferReference;

    theGeometry.style.mask = SceneStyleMask_ProgramFlag;

    NSURL *theURL = [[NSBundle mainBundle].resourceURL URLByAppendingPathComponent:@"Shaders/Flat.program.plist"];
    theGeometry.style.program = [[CFlat alloc] initWithURL:theURL];
    
    
    return(theGeometry);
    }
    
@end
