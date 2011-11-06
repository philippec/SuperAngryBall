//
//  CPhysicsShape_GeometryExtensions.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsShape.h"

@class CSceneNode;

@interface CPhysicsShape (CPhysicsShape_GeometryExtensions)

@property (readonly, nonatomic, strong) CSceneNode *geometry;

@end
