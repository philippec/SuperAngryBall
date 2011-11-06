//
//  CGameSceneGeometry.h
//  AngryBirdsClone
//
//  Created by Jonathan Wight on 11/11/11.
//  Copyright (c) 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneGeometry.h"

@class CPhysicsShape;

@interface CGameSceneGeometry : CSceneGeometry

@property (readwrite, nonatomic, weak) CPhysicsShape *shape;

@end
