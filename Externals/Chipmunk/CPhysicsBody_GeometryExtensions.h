//
//  CPhysicsBody_GeometryExtensions.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody.h"

@class CSceneNode;

@interface CPhysicsBody (CPhysicsBody_GeometryExtensions)

@property (readonly, nonatomic, strong) CSceneNode *geometry;

@end
