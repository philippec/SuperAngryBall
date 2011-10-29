//
//  Shader.fsh
//  AngryBirdsClone
//
//  Created by Jonathan Wight on 10/29/11.
//  Copyright (c) 2011 toxicsoftware.com. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
