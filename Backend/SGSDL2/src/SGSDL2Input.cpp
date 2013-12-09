//
//  SGSDL2Input.cpp
//  sgsdl2
//
//  Created by Andrew Cain on 7/12/2013.
//  Copyright (c) 2013 Andrew Cain. All rights reserved.
//

#include "SGSDL2Input.h"
#include "SDL.h"
#include <iostream>
#include "SGSDL2Graphics.h"

void _sgsdl2_handle_window_event(SDL_Event * event)
{
    sg_window_be *window = _sgsdl2_get_window_with_id(event->window.windowID);
    
    if (! window) {
        return;
    }
    
    switch (event->window.event)
    {
        case SDL_WINDOWEVENT_SHOWN:
            window->shown = true;
            //SDL_Log("Window %d shown", event->window.windowID);
            break;
        case SDL_WINDOWEVENT_HIDDEN:
            window->shown = false;
//            SDL_Log("Window %d hidden", event->window.windowID);
            break;
        case SDL_WINDOWEVENT_EXPOSED:
            SDL_Log("Window %d exposed", event->window.windowID);
            break;
        case SDL_WINDOWEVENT_MOVED:
            SDL_Log("Window %d moved to %d,%d",
                    event->window.windowID, event->window.data1,
                    event->window.data2);
            break;
        case SDL_WINDOWEVENT_RESIZED:
            SDL_Log("Window %d resized to %dx%d",
                    event->window.windowID, event->window.data1,
                    event->window.data2);
            break;
        case SDL_WINDOWEVENT_MINIMIZED:
            SDL_Log("Window %d minimized", event->window.windowID);
            break;
        case SDL_WINDOWEVENT_MAXIMIZED:
            SDL_Log("Window %d maximized", event->window.windowID);
            break;
        case SDL_WINDOWEVENT_RESTORED:
            SDL_Log("Window %d restored", event->window.windowID);
            break;
        case SDL_WINDOWEVENT_ENTER:
            window->mouse_over = true;
//            SDL_Log("Mouse entered window %d",
//                    event->window.windowID);
            break;
        case SDL_WINDOWEVENT_LEAVE:
//            SDL_Log("Mouse left window %d", event->window.windowID);
            window->mouse_over = false;
            break;
        case SDL_WINDOWEVENT_FOCUS_GAINED:
            window->has_focus = true;
//            SDL_Log("Window %d gained keyboard focus",
//                    event->window.windowID);
            break;
        case SDL_WINDOWEVENT_FOCUS_LOST:
            window->has_focus = false;
//            SDL_Log("Window %d lost keyboard focus",
//                    event->window.windowID);
            break;
        case SDL_WINDOWEVENT_CLOSE:
//            SDL_Log("Window %d closed", event->window.windowID);
            window->close_requested = true;
            break;
        default:
            SDL_Log("Window %d got unknown event %d",
                    event->window.windowID, event->window.event);
            break;
    }
}

void sgsdl2_process_events()
{
    SDL_Event event;
    
    while (SDL_WaitEventTimeout(&event, 0))
    {
        switch ( event.type )
        {
            case SDL_WINDOWEVENT:
                _sgsdl2_handle_window_event(&event);
                break;
                
            case SDL_QUIT: std::cout << "Quit" << std::endl;
        }
    }
}

void sgsdl2_load_input_fns(sg_interface *functions)
{
    functions->input.process_events = & sgsdl2_process_events;
}