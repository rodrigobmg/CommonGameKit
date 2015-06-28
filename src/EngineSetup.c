//
//  EngineSetup.c
//  Blob Game
//
//  Created by Stefan Johnson on 27/06/2015.
//  Copyright (c) 2015 Stefan Johnson. All rights reserved.
//

#include "EngineSetup.h"
#include "ComponentSystem.h"
#include "EntityManager.h"

//TODO: Probably make this file generated (could add a define so it knows what functions to call from here)
#include "RenderSystem.h"

#include "RenderComponent.h"

void CCEngineSetup(void)
{
    CCEntityManagerCreate();
    
    //Register Systems
    CCRenderSystemRegister();
    
    //Register Components
    CCRenderComponentRegister();
    
    
    //Initial Scene Setup
#warning demo
    CCEntity Player = CCEntityCreate(1, CC_STD_ALLOCATOR);
    CCComponent Renderer = CCComponentCreate(CC_RENDER_COMPONENT_ID);
    
    CCRenderComponentSetColour(Renderer, (CCColourRGB){ .r = 1.0f, .g = 0.0, .b = 0.0f });
    CCRenderComponentSetRect(Renderer, (CCRect){ .position = CCVector2DZero, .size = CCVector2DMake(1.0f, 1.0f) });
    
    CCEntityAttachComponent(Player, Renderer);
    CCEntityManagerAddEntity(Player);
    CCComponentSystemAddComponent(Renderer);
    
    
    
    Player = CCEntityCreate(1, CC_STD_ALLOCATOR);
    Renderer = CCComponentCreate(CC_RENDER_COMPONENT_ID);
    
    CCRenderComponentSetColour(Renderer, (CCColourRGB){ .r = 0.0f, .g = 0.0, .b = 1.0f });
    CCRenderComponentSetRect(Renderer, (CCRect){ .position = CCVector2DMake(0.25f, 0.25f), .size = CCVector2DMake(0.5f, 0.5f) });
    
    CCEntityAttachComponent(Player, Renderer);
    CCEntityManagerAddEntity(Player);
    CCComponentSystemAddComponent(Renderer);
    
    
    
    
    Renderer = CCComponentCreate(CC_RENDER_COMPONENT_ID);
    
    CCRenderComponentSetColour(Renderer, (CCColourRGB){ .r = 0.0f, .g = 1.0, .b = 0.0f });
    CCRenderComponentSetRect(Renderer, (CCRect){ .position = CCVector2DMake(0.375f, 0.375f), .size = CCVector2DMake(0.25f, 0.25f) });
    
    CCEntityAttachComponent(Player, Renderer);
    CCComponentSystemAddComponent(Renderer);
}
