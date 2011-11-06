//
//  CGameLevel.h
//  AngryBirdsClone
//
//  Created by Jonathan Wight on 11/6/11.
//  Copyright (c) 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPhysicsSpace;

@interface CGameLevel : NSObject

@property (readwrite, nonatomic, assign) CGSize size;
@property (readwrite, nonatomic, strong) CPhysicsSpace *space;

- (id)init;

- (BOOL)load:(NSURL *)inURL;

@end
