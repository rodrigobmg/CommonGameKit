/*
 *  Copyright (c) 2015, Stefan Johnson
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without modification,
 *  are permitted provided that the following conditions are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice, this list
 *     of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright notice, this
 *     list of conditions and the following disclaimer in the documentation and/or other
 *     materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "GLGFX_Private.h"
#include "GLBuffer.h"
#include "GLTexture.h"
#include "GLFramebuffer.h"
#include "GLShaderLibrary.h"
#include "GLShader.h"
#include "GLDraw.h"
#include "GLBlit.h"


static const GLenum ColourAttachments[] = {
    GL_COLOR_ATTACHMENT0,
#ifdef GL_COLOR_ATTACHMENT1
    GL_COLOR_ATTACHMENT1,
#endif
#ifdef GL_COLOR_ATTACHMENT2
    GL_COLOR_ATTACHMENT2,
#endif
#ifdef GL_COLOR_ATTACHMENT3
    GL_COLOR_ATTACHMENT3,
#endif
#ifdef GL_COLOR_ATTACHMENT4
    GL_COLOR_ATTACHMENT4,
#endif
#ifdef GL_COLOR_ATTACHMENT5
    GL_COLOR_ATTACHMENT5,
#endif
#ifdef GL_COLOR_ATTACHMENT6
    GL_COLOR_ATTACHMENT6,
#endif
#ifdef GL_COLOR_ATTACHMENT7
    GL_COLOR_ATTACHMENT7,
#endif
#ifdef GL_COLOR_ATTACHMENT8
    GL_COLOR_ATTACHMENT8,
#endif
#ifdef GL_COLOR_ATTACHMENT9
    GL_COLOR_ATTACHMENT9,
#endif
#ifdef GL_COLOR_ATTACHMENT10
    GL_COLOR_ATTACHMENT10,
#endif
#ifdef GL_COLOR_ATTACHMENT11
    GL_COLOR_ATTACHMENT11,
#endif
#ifdef GL_COLOR_ATTACHMENT12
    GL_COLOR_ATTACHMENT12,
#endif
#ifdef GL_COLOR_ATTACHMENT13
    GL_COLOR_ATTACHMENT13,
#endif
#ifdef GL_COLOR_ATTACHMENT14
    GL_COLOR_ATTACHMENT14,
#endif
#ifdef GL_COLOR_ATTACHMENT15
    GL_COLOR_ATTACHMENT15
#endif
};

static GLInternal GLInfo = {
    .limits = {
        .maxColourAttachments = sizeof(ColourAttachments) / sizeof(GLenum)
    }
};

static GFXMainInfo GLGFXInfo = {
    .internal = &GLInfo,
    .buffer = &GLBufferInterface,
    .texture = &GLTextureInterface,
    .framebuffer = &GLFramebufferInterface,
    .library = &GLShaderLibraryInterface,
    .shader = &GLShaderInterface,
    .draw = &GLDrawInterface,
    .blit = &GLBlitInterface
};

GFXMainInfo * const GLGFX = &GLGFXInfo;

void GLGFXSetup(void)
{
    GFXMain = GLGFX;
    CCGLCurrentState = CCGLStateCreate();
    CCGLStateInitializeWithCurrent(CCGLCurrentState);
    
    
    //Log
    CC_LOG_INFO("GFX: OpenGL");
    CC_LOG_INFO("Vendor: %s", glGetString(GL_VENDOR));
    CC_LOG_INFO("Renderer: %s", glGetString(GL_RENDERER));
    CC_LOG_INFO("OpenGL Version: %s", glGetString(GL_VERSION));
    CC_LOG_INFO("GLSL Version: %s", glGetString(GL_SHADING_LANGUAGE_VERSION));
    
    GLint ExtCount;
    glGetIntegerv(GL_NUM_EXTENSIONS, &ExtCount);
    for (GLint Loop = 0; Loop < ExtCount; Loop++)
    {
        CC_LOG_INFO("Extensions: %s", glGetStringi(GL_EXTENSIONS, Loop));
    }
    
    
    //Initialize GLInternal state
#ifdef GL_MAX_COLOR_ATTACHMENTS
    glGetIntegerv(GL_MAX_COLOR_ATTACHMENTS, &GLInfo.limits.maxColourAttachments); CC_GL_CHECK();
#endif
    
    CC_GL_BIND_FRAMEBUFFER(GL_FRAMEBUFFER, 0);
    
#if CC_PLATFORM_OS_X
    /*
     OS X GL context's pixel formats support sRGB. Interestingly GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING will only report that
     the sRGB encoding is being used if GL_FRAMEBUFFER_SRGB is enabled.
     */
    CC_GL_ENABLE(GL_FRAMEBUFFER_SRGB);
#else
    GLint Encoding = 0;
    glGetFramebufferAttachmentParameteriv(GL_DRAW_FRAMEBUFFER, GL_BACK_LEFT, GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING, &Encoding); CC_GL_CHECK();
    
    if (Encoding == GL_SRGB)
    {
        CC_GL_ENABLE(GL_FRAMEBUFFER_SRGB);
    }
#endif
}
