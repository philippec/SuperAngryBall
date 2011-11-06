//
//  CPhysicsBody_GeometryExtensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody_GeometryExtensions.h"

#import "CPhysicsShape_GeometryExtensions.h"
#import "CSceneNode.h"
#import "CSceneStyle.h"
#import "CPhysicsBody_Extensions.h"

@implementation CPhysicsBody (CPhysicsBody_GeometryExtensions)

- (CSceneNode *)geometry
    {
    if (self.userInfo == NULL)
        {
        CSceneNode *theNode = NULL;
        if (self.subbodies.count == 0 && self.shapes.count == 1)
            {
            theNode = self.shape.geometry;
            }
        else   
            {
            theNode = [[CSceneNode alloc] init];
            theNode.style = [[CSceneStyle alloc] init];

            for (CPhysicsBody *theBody in self.subbodies)
                {
                CSceneNode *theGeometry = theBody.geometry;
                [theNode addSubnode:theGeometry];
                }
            
            for (CPhysicsShape *theShape in self.shapes)
                {
                CSceneNode *theGeometry = theShape.geometry;
                [theNode addSubnode:theGeometry];
                }
            }
        self.userInfo = theNode;
        }
    
    return(self.userInfo); 
    }

@end
