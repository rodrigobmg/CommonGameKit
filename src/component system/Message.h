/*
 *  Copyright (c) 2017, Stefan Johnson
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

#ifndef CommonGameKit_Message_h
#define CommonGameKit_Message_h

#include <CommonC/Common.h>
#include "Entity.h"
#include "Component.h"
#include "ComponentSystem.h"


/*!
 * @brief An ID to identify the message.
 */
typedef uint32_t CCMessageID;

/*!
 * @brief A message.
 */
typedef struct CCMessage CCMessage;

/*!
 * @brief A message router.
 */
typedef struct CCMessageRouter CCMessageRouter;

/*!
 * @brief Decide on which system mailboxes to post the message to.
 * @param Router The routing data.
 * @param Message The message to be posted.
 */
typedef void (*CCMessageRouterPost)(CCMessageRouter *Router, CCMessage *Message);

/*!
 * @brief Decide on what message handlers to the message should be delivered to.
 * @param Router The routing data.
 * @param Message The message to be delivered.
 * @param SystemID The system the mailbox this message was taken from.
 */
typedef void (*CCMessageRouterDeliver)(CCMessageRouter *Router, CCMessage *Message, CCComponentSystemID SystemID);

struct CCMessageRouter {
    CCMessageRouterPost post;
    CCMessageRouterDeliver deliver;
};

typedef struct {
    CCMessageRouter header;
    uint8_t data[];
} CCMessageRouterData;

struct CCMessage {
    CCMessageID id;
    CCMessageRouter *router;
};

typedef struct {
    CCMessage header;
    uint8_t data[];
} CCMessageData;


#pragma mark - Creation / Destruction
/*!
 * @brief Allocate and initialize a new router.
 * @param Allocator The allocator to be used for the allocation.
 * @param Post The post callback.
 * @param Deliver The deliver callback.
 * @param Size The size of the data.
 * @param Data The data to initialize the router with. May be NULL.
 * @return A pointer to the created router, or NULL on failure. Must be destroyed to free the memory.
 */
CC_NEW CCMessageRouter *CCMessageRouterCreate(CCAllocatorType Allocator, CCMessageRouterPost Post, CCMessageRouterDeliver Deliver, size_t Size, const void *Data);

/*!
 * @brief Destroy a router.
 * @param Router The router to be destroyed.
 */
void CCMessageRouterDestroy(CCMessageRouter *CC_DESTROY(Router));

/*!
 * @brief Destroy a message.
 * @param Message The message to be destroyed.
 */
void CCMessageDestroy(CCMessage *CC_DESTROY(Message));

#pragma mark - Query
/*!
 * @brief Get a pointer to the data in the router.
 * @param Router The router to get the data of.
 * @return A pointer to the data it contains.
 */
static inline void *CCMessageRouterGetData(CCMessageRouter *Router);

/*!
 * @brief Get a pointer to the data in the message.
 * @param Message The message to get the data of.
 * @return A pointer to the data it contains.
 */
static inline void *CCMessageGetData(CCMessage *Message);


#pragma mark -
static inline void *CCMessageRouterGetData(CCMessageRouter *Router)
{
    return ((CCMessageRouterData*)Router)->data;
}

static inline void *CCMessageGetData(CCMessage *Message)
{
    return ((CCMessageData*)Message)->data;
}

#endif