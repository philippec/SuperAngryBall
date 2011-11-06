//
//  CStyle.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/04/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneStyle.h"


@implementation CSceneStyle

@synthesize mask;
@synthesize color;
@synthesize lineWidth;
@synthesize texture;
@synthesize program;

- (void)setColor:(Color4f)inColor
    {
    self.mask |= SceneStyleMask_ColorFlag;
    color = inColor;
    }

- (NSString *)description
    {
    return([NSString stringWithFormat:@"%@ (mask: %x, color: %@)", [super description], self.mask, NSStringFromColor4f(self.color)]);
    }


@end
