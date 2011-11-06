//
//  CSceneGraphRenderer.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneGraphRenderer.h"

#import "CSceneNode.h"
#import "CSceneStyle.h"

@interface CSceneGraphRenderer ()
@property (readwrite, nonatomic, strong) NSMutableArray *styleStack;
@property (readwrite, nonatomic, strong) NSMutableArray *transformStack;
@end

#pragma mark -

@implementation CSceneGraphRenderer

@synthesize rootNode;

@synthesize styleStack;
@synthesize transformStack;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        rootNode = [[CSceneNode alloc] init];
        rootNode.identifier = @"root";
        }
    return(self);
    }

- (CSceneStyle *)mergedStyle
    {
    CSceneStyle *theMergedStyle = [[CSceneStyle alloc] init];
    for (CSceneStyle *theStyle in self.styleStack)
        {
        if (theStyle.mask & SceneStyleMask_ColorFlag)
            {
            theMergedStyle.mask |= SceneStyleMask_ColorFlag;
            theMergedStyle.color = theStyle.color;
            }
        if (theStyle.mask & SceneStyleMask_LineWidthFlag)
            {
            theMergedStyle.mask |= SceneStyleMask_LineWidthFlag;
            theMergedStyle.lineWidth = theStyle.lineWidth;
            }
        if (theStyle.mask & SceneStyleMask_TextureFlag)
            {
            theMergedStyle.mask |= SceneStyleMask_TextureFlag;
            theMergedStyle.texture = theStyle.texture;
            }
        if (theStyle.mask & SceneStyleMask_ProgramFlag)
            {
            theMergedStyle.mask |= SceneStyleMask_ProgramFlag;
            theMergedStyle.program = theStyle.program;
            }
        }
    return(theMergedStyle);
    }

- (Matrix4)mergedTransform
    {
    Matrix4 theTransform = Matrix4Identity;
    for (NSValue *theTransformValue in self.transformStack)
        {
        Matrix4 m;
        [theTransformValue getValue:&m];
        theTransform = Matrix4Concat(theTransform, m);
        }
    return(theTransform);
    }
    
#pragma mark -

- (void)prerender
    {
    [super prerender];
    //
    self.styleStack = [NSMutableArray array];
    self.transformStack = [NSMutableArray arrayWithObject:NSValueWithMatrix4(Matrix4Identity)];
    }

- (void)render
    {
    [super render];
    
    [self.rootNode prerender:self];
    [self.rootNode render:self];
    [self.rootNode postrender:self];
    }

#pragma mark -

- (void)pushStyle:(CSceneStyle *)inStyle
    {
    [self.styleStack addObject:inStyle];
    }
    
- (void)popStyle:(CSceneStyle *)inStyle
    {
    NSAssert(self.styleStack.lastObject == inStyle, @"Popping wrong object");
    [self.styleStack removeLastObject];
    }

- (void)pushTransform:(Matrix4)inTransform
    {
    [self.transformStack addObject:NSValueWithMatrix4(inTransform)];
    }
    
- (void)popTransform:(Matrix4)inTransform
    {
    Matrix4 theTopTransform;
    [[self.transformStack lastObject] getValue:&theTopTransform];
    
    NSAssert(Matrix4EqualToTransform(inTransform, theTopTransform), @"Popping a different matrix. WTF?");
    [self.transformStack removeLastObject];
    }


@end
