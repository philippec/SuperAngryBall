//
//  CSceneGraphNode.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/23/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CSceneNode.h"

#import "CSceneNode.h"
#import "CSceneGraphRenderer.h"

@interface CSceneNode ()
@property (readwrite, nonatomic, assign) BOOL transformIsIdentity;
@property (readwrite, nonatomic, strong) NSMutableArray *mutableSubnodes;
@end

@implementation CSceneNode

@synthesize identifier;
@synthesize supernode;
@synthesize transform;
@synthesize style;
@synthesize subnodes;
@synthesize userInfo;

@synthesize transformIsIdentity;
@synthesize mutableSubnodes;

- (id)init
	{
	if ((self = [super init]) != NULL)
		{
        transform = Matrix4Identity;
        transformIsIdentity = YES;
		}
	return(self);
	}

#pragma mark -

- (NSString *)description
    {
    NSString *theTransform = Matrix4IsIdentity(self.transform) ? @"identity" : [NSStringFromMatrix4(self.transform) stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    
    return([NSString stringWithFormat:@"%@ (id:\"%@\", transform:%@)", [super description], self.identifier, theTransform]);
    }


- (void)setTransform:(Matrix4)inTransform
    {
    transform = inTransform;
    transformIsIdentity = Matrix4IsIdentity(inTransform);
    }

- (NSArray *)subnodes
    {
    return(self.mutableSubnodes);
    }
    
- (void)addSubnode:(CSceneNode *)inSubnode
    {
    if (self.mutableSubnodes == NULL)
        {
        self.mutableSubnodes = [NSMutableArray array];
        }
    [self.mutableSubnodes addObject:inSubnode];
    }

- (void)prerender:(CSceneGraphRenderer *)inRenderer
    {
    if (self.style != NULL)
        {
        [inRenderer pushStyle:self.style];
        }
    
    if (transformIsIdentity == NO)
        {
        [inRenderer pushTransform:self.transform];
        }
    }

- (void)render:(CSceneGraphRenderer *)inRenderer
    {
    for (CSceneNode *theNode in self.subnodes)
        {
        [theNode prerender:inRenderer];
        [theNode render:inRenderer];
        [theNode postrender:inRenderer];
        }
    }

- (void)postrender:(CSceneGraphRenderer *)inRenderer;
    {
    if (self.style != NULL)
        {
        [inRenderer popStyle:self.style];
        }
    
    if (transformIsIdentity == NO)
        {
        [inRenderer popTransform:self.transform];
        }
    }

#pragma mark -

- (CSceneNode *)hitTest:(CGPoint)inPoint;
    {
    CSceneNode *theHitNode = NULL;
    for (CSceneNode *theNode in self.subnodes)
        {
        theHitNode = [theNode hitTest:inPoint];
        if (theHitNode != NULL)
            {
            break;
            }
        }
    return(theHitNode);
    }

- (Matrix4)computedTransform;
    {
    NSMutableArray *theTransforms = [NSMutableArray array];
    
    CSceneNode *theNode = self;
    while (theNode)
        {
        [theTransforms insertObject:NSValueWithMatrix4(theNode.transform) atIndex:0];
        theNode = theNode.supernode;
        }
    
    Matrix4 theMatrix = Matrix4Identity;
    for (NSValue *theValue in theTransforms)
        {
        theMatrix = Matrix4Concat(theMatrix, Matrix4WithNSValue(theValue));
        }
    
    return(theMatrix);
    }

#pragma mark -

- (void)dump
    {
    [self dump:0];
    }
    
- (void)dump:(int)inLevel
    {
    char theTabs[] = "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t";
    NSLog(@"%.*s%@", inLevel, theTabs, [self description]);
    if (self.subnodes.count > 0)
        {
        NSLog(@"%.*s  subnodes: ", inLevel, theTabs);
        for (CSceneNode *theNode in self.subnodes)
            {
            [theNode dump:inLevel + 1];
            }
        }
    }

@end
