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

#ifndef CommonGameKit_InputMapGroupComponent_h
#define CommonGameKit_InputMapGroupComponent_h

#include <CommonGameKit/InputMapComponent.h>
#include <CommonC/Common.h>

#define CC_INPUT_MAP_GROUP_COMPONENT_ID (CCInputMapTypeGroup | CC_INPUT_COMPONENT_FLAG)

extern const CCString CCInputMapGroupComponentName;

typedef struct {
    CC_COMPONENT_INHERIT(CCInputMapComponentClass);
    CCOrderedCollection inputMaps;
    _Bool wantsAllActive;
} CCInputMapGroupComponentClass, *CCInputMapGroupComponentPrivate;


void CCInputMapGroupComponentRegister(void);
void CCInputMapGroupComponentDeregister(void);
void CCInputMapGroupComponentElementDestructor(CCCollection Collection, CCComponent *Element);
void CCInputMapGroupComponentDeserializer(CCComponent Component, CCExpression Arg);

/*!
 * @brief Initialize the input map group component.
 * @param Component The component to be initialized.
 * @param id The component ID.
 */
static inline void CCInputMapGroupComponentInitialize(CCComponent Component, CCComponentID id);

/*!
 * @brief Deallocate the input map group component.
 * @param Component The component to be deallocated.
 */
static inline void CCInputMapGroupComponentDeallocate(CCComponent Component);

/*!
 * @brief Get the input maps that belong to this group.
 * @description These are other children of input map components.
 * @param Component The input map group component.
 * @return The input maps apart of this group.
 */
static inline CCOrderedCollection CCInputMapGroupComponentGetInputMaps(CCComponent Component);

/*!
 * @brief Add an input map to the group.
 * @param Component The input map component.
 * @param InputMap The input map to be added to the group. Ownership is transferred to the component.
 */
static inline void CCInputMapGroupComponentAddInputMap(CCComponent Component, CCComponent CC_OWN(InputMap));

/*!
 * @brief Remove an input map from the group.
 * @param Component The input map component.
 * @param InputMap The input map to be removed from the group. The input map will be destroyed.
 */
static inline void CCInputMapGroupComponentRemoveInputMap(CCComponent Component, CCComponent CC_DESTROY(InputMap));

/*!
 * @brief Get whether all input maps in the group need to be active for the group to be
 *        considered active.
 *
 * @param Component The input map group component.
 * @return Whether all inputs maps need to be active.
 */
static inline _Bool CCInputMapGroupComponentGetWantsAllActive(CCComponent Component);

/*!
 * @brief Set whether all input maps in the group need to be active for the group to be
 *        considered active.
 *
 * @param Component The input map component.
 * @param WantsAllActive Whether all input maps need to be active.
 */
static inline void CCInputMapGroupComponentSetWantsAllActive(CCComponent Component, _Bool WantsAllActive);


#pragma mark -

static inline void CCInputMapGroupComponentInitialize(CCComponent Component, CCComponentID id)
{
    CCInputMapComponentInitialize(Component, id);
    ((CCInputMapGroupComponentPrivate)Component)->inputMaps = CCCollectionCreate(CC_STD_ALLOCATOR, CCCollectionHintOrdered | CCCollectionHintHeavyEnumerating | CCCollectionHintSizeSmall, sizeof(CCComponent), (CCCollectionElementDestructor)CCInputMapGroupComponentElementDestructor);
    ((CCInputMapGroupComponentPrivate)Component)->wantsAllActive = FALSE;
}

static inline void CCInputMapGroupComponentDeallocate(CCComponent Component)
{
    CCCollectionDestroy(((CCInputMapGroupComponentPrivate)Component)->inputMaps);
    CCInputMapComponentDeallocate(Component);
}

static inline CCOrderedCollection CCInputMapGroupComponentGetInputMaps(CCComponent Component)
{
    return ((CCInputMapGroupComponentPrivate)Component)->inputMaps;
}

static inline void CCInputMapGroupComponentAddInputMap(CCComponent Component, CCComponent InputMap)
{
    CCOrderedCollectionAppendElement(((CCInputMapGroupComponentPrivate)Component)->inputMaps, &InputMap);
}

static inline void CCInputMapGroupComponentRemoveInputMap(CCComponent Component, CCComponent InputMap)
{
    CCCollectionRemoveElement(((CCInputMapGroupComponentPrivate)Component)->inputMaps, CCCollectionFindElement(((CCInputMapGroupComponentPrivate)Component)->inputMaps, &InputMap, NULL));
}

static inline _Bool CCInputMapGroupComponentGetWantsAllActive(CCComponent Component)
{
    return ((CCInputMapGroupComponentPrivate)Component)->wantsAllActive;
}

static inline void CCInputMapGroupComponentSetWantsAllActive(CCComponent Component, _Bool WantsAllActive)
{
    ((CCInputMapGroupComponentPrivate)Component)->wantsAllActive = WantsAllActive;
}

#endif
