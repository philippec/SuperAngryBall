//
//  CSceneGraphRenderer.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneRenderer.h"

#import "OpenGLTypes.h"

@class CSceneNode;
@class CSceneStyle;

@interface CSceneGraphRenderer : CSceneRenderer {
}

@property (readwrite, nonatomic, strong) CSceneNode *rootNode;

// TODO These are rendering state objects... Should be in a different object...
@property (readonly, nonatomic, strong) CSceneStyle *mergedStyle;
@property (readonly, nonatomic, assign) Matrix4 mergedTransform;

- (id)init;

- (void)pushStyle:(CSceneStyle *)inStyle;
- (void)popStyle:(CSceneStyle *)inStyle;

- (void)pushTransform:(Matrix4)inTransform;
- (void)popTransform:(Matrix4)inTransform;

@end
