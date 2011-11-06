//
//  CGeometryNode.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/23/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CSceneNode.h"

#import "OpenGLIncludes.h"

@class CVertexBufferReference;

@interface CSceneGeometry : CSceneNode {
}

@property (readwrite, nonatomic, assign) CGRect bounds;
@property (readwrite, nonatomic, strong) CVertexBufferReference *indicesBufferReference;
@property (readwrite, nonatomic, strong) CVertexBufferReference *coordinatesBufferReference;
@property (readwrite, nonatomic, strong) CVertexBufferReference *textureCoordinatesBufferReference;
@property (readwrite, nonatomic, strong) CVertexBufferReference *colorsBufferReference;
@property (readwrite, nonatomic, strong) NSSet *vertexBuffers;
@property (readwrite, nonatomic, assign) GLenum type;

@end
