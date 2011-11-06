//
//  CStyle.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/04/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpenGLTypes.h"

#import "CTexture.h"
#import "CProgram.h"

typedef enum ESceneStyleMask {
    SceneStyleMask_ColorFlag = 0x0001,
	SceneStyleMask_LineWidthFlag = 0x0002,
    SceneStyleMask_TextureFlag = 0x004,
    SceneStyleMask_ProgramFlag = 0x008,
} ESceneStyleMask;

@interface CSceneStyle : NSObject {
    
}

@property (readwrite, nonatomic, assign) ESceneStyleMask mask;
@property (readwrite, nonatomic, assign) Color4f color;
@property (readwrite, nonatomic, assign) GLfloat lineWidth;
@property (readwrite, nonatomic, strong) CTexture *texture;
@property (readwrite, nonatomic, strong) CProgram *program;

@end
