//
//  CSceneGeometry_ConvenienceExtensions.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneGeometry.h"

@class CVertexBufferReference;

@interface CSceneGeometry (CSceneGeometry_ConvenienceExtensions)

+ (CSceneGeometry *)sceneGeometryWithType:(GLenum)inType program:(id)inProgram coordinatesBufferReference:(CVertexBufferReference *)inVertexBufferReference;

@end
