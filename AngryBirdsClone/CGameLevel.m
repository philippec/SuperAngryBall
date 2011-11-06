//
//  CGameLevel.m
//  AngryBirdsClone
//
//  Created by Jonathan Wight on 11/6/11.
//  Copyright (c) 2011 toxicsoftware.com. All rights reserved.
//

#import "CGameLevel.h"

#import "CSceneGeometry.h"
#import "CSceneGeometry_ConvenienceExtensions.h"
#import "CVertexBufferReference_FactoryExtensions.h"
#import "CSceneStyle.h"
#import "UIColor_OpenGLExtensions.h"
#import "CPhysicsSpace.h"
#import "CPhysicsShape_GeometryExtensions.h"
#import "CPhysicsBody.h"
#import "CPhysicsBody_GeometryExtensions.h"
#import "CSceneNode.h"
#import "CGameLevel.h"

inline static CGRect CGRectVerticalInvert(CGRect inRect, CGFloat height)
    {
    inRect.origin.y = height - inRect.origin.y - inRect.size.height;
    return(inRect);
    }

@interface CGameLevel ()
@end

@implementation CGameLevel

@synthesize size;
@synthesize space;

//		<dict>
//			<key>Bounds</key>
//			<string>{{700, 400}, {10, 70}}</string>
//			<key>Class</key>
//			<string>ShapedGraphic</string>
//			<key>ID</key>
//			<integer>7</integer>
//			<key>Shape</key>
//			<string>Rectangle</string>
//			<key>Style</key>
//			<dict>
//				<key>fill</key>
//				<dict>
//					<key>Color</key>
//					<dict>
//						<key>b</key>
//						<string>0.128339</string>
//						<key>g</key>
//						<string>1</string>
//						<key>r</key>
//						<string>0.337378</string>
//					</dict>
//				</dict>
//				<key>shadow</key>
//				<dict>
//					<key>Draws</key>
//					<string>NO</string>
//				</dict>
//			</dict>
//		</dict>

- (BOOL)load:(NSURL *)inURL
    {
    NSDictionary *theTemplates = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"ObjectTemplates" withExtension:@"plist"]];
    
    NSDictionary *theDictionary = [NSDictionary dictionaryWithContentsOfURL:inURL];
    NSLog(@"%@", inURL);
    
    self.size = CGSizeFromString([theDictionary objectForKey:@"CanvasSize"]);
    
    NSArray *theGraphicsList = [theDictionary objectForKey:@"GraphicsList"];
    theGraphicsList = [theGraphicsList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Class == \"ShapedGraphic\""]];
    for (NSDictionary *theDictionary in theGraphicsList)
        {
        CGRect theBounds = CGRectFromString([theDictionary objectForKey:@"Bounds"]);
        theBounds = CGRectVerticalInvert(theBounds, self.size.height);
        
        
        CGPoint thePosition = (CGPoint){
            .x = CGRectGetMidX(theBounds),
            .y = CGRectGetMidY(theBounds),
            };
        BOOL theIsStaticFlag = NO;

        NSDictionary *theUserInfo = [theDictionary objectForKey:@"UserInfo"];
        NSString *theTemplateName = [theUserInfo objectForKey:@"template"];
        NSDictionary *theTemplate = [theTemplates objectForKey:theTemplateName];
        
        theIsStaticFlag = [[theTemplate objectForKey:@"static"] boolValue];

        CPhysicsShape *theShape = NULL;
        
        cpFloat theMass = [theTemplate objectForKey:@"mass"] ? [[theTemplate objectForKey:@"mass"] floatValue] : 1.0;
        cpFloat theMoment = 1.0;
        
        NSString *theShapeType = [theDictionary objectForKey:@"Shape"];
        if ([theShapeType isEqualToString:@"Rectangle"])
            {
            theMoment = cpMomentForBox(theMass, theBounds.size.width, theBounds.size.height);
            
            if (theIsStaticFlag == YES)
                {
                theShape = [CPhysicsShape shapeWithRect:theBounds];
                }
            else
                {
                theShape = [CPhysicsShape shapeWithBoxOfSize:theBounds.size];
                }
            }
        else if ([theShapeType isEqualToString:@"Circle"])
            {
            NSAssert(theBounds.size.width == theBounds.size.height, @"Not a true circle");

            theMoment = cpMomentForCircle(theMass, theBounds.size.width, 0, CGPointZero);

            if (theIsStaticFlag == YES)
                {
                theShape = [CPhysicsShape shapeWithBallOfRadius:theBounds.size.width * 0.5 center:thePosition];
                }
            else
                {
                theShape = [CPhysicsShape shapeWithCircleOfRadius:theBounds.size.width * 0.5];
                }
            }

        theShape.friction = [theTemplate objectForKey:@"friction"] ? [[theTemplate objectForKey:@"friction"] floatValue] : 1.0;
        theShape.elasticity = [theTemplate objectForKey:@"elasticity"] ? [[theTemplate objectForKey:@"elasticity"] floatValue] : 0.0;

        NSLog(@"%g %g %g", theMass, theShape.friction, theShape.elasticity);

        NSDictionary *theFillColorDictionary = [theDictionary valueForKeyPath:@"Style.fill.Color"];
        Color4f theColor = { .a = 1.0 };
        theColor.r = [[theFillColorDictionary objectForKey:@"r"] floatValue];
        theColor.g = [[theFillColorDictionary objectForKey:@"g"] floatValue];
        theColor.b = [[theFillColorDictionary objectForKey:@"b"] floatValue];

        theShape.geometry.style.color = theColor;


        if (theIsStaticFlag == YES)
            {
            [self.space.staticBody addShape:theShape];
            [self.space addShape:theShape];
            }
        else
            {
            
            
            CPhysicsBody *theBody = [[CPhysicsBody alloc] initWithMass:theMass inertia:theMoment shape:theShape];
            theBody.position = thePosition;
            [self.space addBody:theBody];
            }

        }
    return(YES);
    }

@end
