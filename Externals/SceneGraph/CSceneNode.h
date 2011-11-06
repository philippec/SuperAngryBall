//
//  CSceneGraphNode.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/23/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Matrix.h"

@class CSceneGraphRenderer;
@class CSceneStyle;

@interface CSceneNode : NSObject {
}

@property (readwrite, nonatomic, strong) NSString *identifier;
@property (readonly, nonatomic, assign) CSceneNode *supernode;
@property (readwrite, nonatomic, assign) Matrix4 transform;
@property (readwrite, nonatomic, strong) CSceneStyle *style;
@property (readonly, nonatomic, strong) NSArray *subnodes;
@property (readwrite, nonatomic, strong) id userInfo;

- (void)prerender:(CSceneGraphRenderer *)inRenderer;
- (void)render:(CSceneGraphRenderer *)inRenderer;
- (void)postrender:(CSceneGraphRenderer *)inRenderer;

- (void)addSubnode:(CSceneNode *)inSubnode;

- (void)dump;
- (void)dump:(int)inLevel;

- (CSceneNode *)hitTest:(CGPoint)inPoint;

- (Matrix4)computedTransform;

@end
