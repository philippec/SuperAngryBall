//
//  CPhysicsBody_Extensions.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody.h"

@class CPhysicsShape;

@interface CPhysicsBody (CPhysicsBody_Extensions)

@property (readonly, nonatomic, strong) CPhysicsShape *shape;

//- (CPhysicsBody *)addWheelAt:(cpVect)inPosition radius:(cpFloat)inRadius motorized:(BOOL)inMotorized rate:(cpFloat)inRate;
//- (CPhysicsBody *)addShockAbsorberAt:(cpVect)inPosition;
//- (CPhysicsBody *)addShockAbsorberStart:(cpVect)inStart end:(cpVect)inEnd;


@end
