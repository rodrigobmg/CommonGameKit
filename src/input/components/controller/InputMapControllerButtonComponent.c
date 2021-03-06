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

#include "InputMapControllerButtonComponent.h"
#include "ComponentExpressions.h"

const CCString CCInputMapControllerButtonComponentName = CC_STRING("input_map_controller_button");

static const CCComponentExpressionDescriptor CCInputMapControllerButtonComponentDescriptor = {
    .id = CC_INPUT_MAP_CONTROLLER_BUTTON_COMPONENT_ID,
    .initialize = NULL,
    .deserialize = CCInputMapControllerButtonComponentDeserializer,
    .serialize = NULL
};

void CCInputMapControllerButtonComponentRegister(void)
{
    CCComponentRegister(CC_INPUT_MAP_CONTROLLER_BUTTON_COMPONENT_ID, CCInputMapControllerButtonComponentName, CC_STD_ALLOCATOR, sizeof(CCInputMapControllerButtonComponentClass), CCInputMapControllerButtonComponentInitialize, NULL, CCInputMapControllerButtonComponentDeallocate);
    
    CCComponentExpressionRegister(CC_STRING("input-controller-button"), &CCInputMapControllerButtonComponentDescriptor, TRUE);
}

void CCInputMapControllerButtonComponentDeregister(void)
{
    CCComponentDeregister(CC_INPUT_MAP_CONTROLLER_BUTTON_COMPONENT_ID);
}

static CCComponentExpressionArgumentDeserializer Arguments[] = {
    { .name = CC_STRING("button:"), .serializedType = CCExpressionValueTypeUnspecified, .setterType = CCComponentExpressionArgumentTypeInt32, .setter = (CCComponentExpressionSetter)CCInputMapControllerButtonComponentSetButton },
    { .name = CC_STRING("ramp:"), .serializedType = CCExpressionValueTypeUnspecified, .setterType = CCComponentExpressionArgumentTypeFloat32, .setter = (CCComponentExpressionSetter)CCInputMapControllerButtonComponentSetRamp }
};

void CCInputMapControllerButtonComponentDeserializer(CCComponent Component, CCExpression Arg)
{
    if (!CCComponentExpressionDeserializeArgument(Component, Arg, Arguments, sizeof(Arguments) / sizeof(typeof(*Arguments))))
    {
        CCInputMapControllerComponentDeserializer(Component, Arg);
    }
}
