--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with System;

with ESPIDF.C_Strings;

package ESPIDF.Event is

   type esp_event_base_t is new ESPIDF.C_Strings.const_char_ptr;
   --  Unique pointer to a subsystem that exposes events.

   type esp_event_handler_t is
     access procedure
       (event_handler_arg : System.Address;
        event_base        : esp_event_base_t;
        event_id          : int32_t;
        event_data        : System.Address) with Convention => C;
   --  Function called when an event is posted to the queue.

   type esp_event_handler_instance_t is private;
   --  Context identifying an instance of a registered event handler.

   ESP_EVENT_ANY_ID : constant int32_t := -1;
   --  Register handler for any event id.

   function esp_event_loop_create_default return esp_err_t
     with Import, Convention => C,
          External_Name => "esp_event_loop_create_default";
   --  Create default event loop.
   --  @return
   --    - `ESP_OK`: Success
   --    - `ESP_ERR_NO_MEM`: Cannot allocate memory for event loops list
   --    - `ESP_ERR_INVALID_STATE`: Default event loop has already been
   --      created
   --    - `ESP_FAIL`: Failed to create task loop
   --    - Others: Fail

   procedure esp_event_loop_create_default;
   --  Create default event loop.
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_NO_MEM`: Cannot allocate memory for event loops list
   --    - `ESP_ERR_INVALID_STATE`: Default event loop has already been
   --      created
   --    - `ESP_FAIL`: Failed to create task loop
   --    - Others: Fail

   function esp_event_handler_register
     (event_base        : esp_event_base_t;
      event_id          : int32_t;
      event_handler     : not null esp_event_handler_t;
      event_handler_arg : System.Address := System.Null_Address)
      return esp_err_t
     with Import, Convention => C,
          External_Name => "esp_event_handler_register";
   --  Register an event handler to the system event loop (legacy).
   --
   --  This subprogram can be used to register a handler for either: (1)
   --  specific events, (2) all events of a certain event base, or (3) all
   --  events known by the system event loop.
   --    - specific events: specify exact `event_base` and `event_id`
   --    - all events of a certain base: specify exact `event_base` and use
   --      `ESP_EVENT_ANY_ID` as the `event_id`
   --    - all events known by the loop: use `ESP_EVENT_ANY_BASE` for
   --      `event_base` and `ESP_EVENT_ANY_ID` as the `event_id`
   --
   --  Registering multiple handlers to events is possible. Registering a
   --  single handler to multiple events is also possible. However,
   --  registering the same handler to the same event multiple times would
   --  cause the overwriting of the `event_handler_arg` but the handler will
   --  be kept at the same position in the list associated with the event
   --  that triggers it. It means that the call order of registered handlers
   --  for that event will remain the same.
   --
   --  Note: the event loop library does not maintain a copy of
   --  `event_handler_arg`, therefore the user should ensure that
   --  `event_handler_arg` still points to a valid location by the time the
   --  handler gets called.
   --  @param event_base The base ID of the event to register the handler for
   --  @param event_id The ID of the event to register the handler for
   --  @param event_handler
   --    The handler function which gets called when the event is dispatched
   --  @param event_handler_arg
   --    Data, aside from event data, that is passed to the handler when it
   --    is called
   --  @return
   --    - `ESP_OK`: Success
   --    - `ESP_ERR_NO_MEM`: Cannot allocate memory for the handler
   --    - `ESP_ERR_INVALID_ARG`: Invalid combination of event base and event
   --      ID
   --    - Others: Fail

   procedure esp_event_handler_register
     (event_base        : esp_event_base_t;
      event_id          : int32_t;
      event_handler     : not null esp_event_handler_t;
      event_handler_arg : System.Address := System.Null_Address);
   --  Register an event handler to the system event loop (legacy).
   --
   --  This subprogram can be used to register a handler for either: (1)
   --  specific events, (2) all events of a certain event base, or (3) all
   --  events known by the system event loop.
   --    - specific events: specify exact `event_base` and `event_id`
   --    - all events of a certain base: specify exact `event_base` and use
   --      `ESP_EVENT_ANY_ID` as the `event_id`
   --    - all events known by the loop: use `ESP_EVENT_ANY_BASE` for
   --      `event_base` and `ESP_EVENT_ANY_ID` as the `event_id`
   --
   --  Registering multiple handlers to events is possible. Registering a
   --  single handler to multiple events is also possible. However,
   --  registering the same handler to the same event multiple times would
   --  cause the overwriting of the `event_handler_arg` but the handler will
   --  be kept at the same position in the list associated with the event
   --  that triggers it. It means that the call order of registered handlers
   --  for that event will remain the same.
   --
   --  Note: the event loop library does not maintain a copy of
   --  `event_handler_arg`, therefore the user should ensure that
   --  `event_handler_arg` still points to a valid location by the time the
   --  handler gets called.
   --  @param event_base The base ID of the event to register the handler for
   --  @param event_id The ID of the event to register the handler for
   --  @param event_handler
   --    The handler function which gets called when the event is dispatched
   --  @param event_handler_arg
   --    Data, aside from event data, that is passed to the handler when it
   --    is called
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_NO_MEM`: Cannot allocate memory for the handler
   --    - `ESP_ERR_INVALID_ARG`: Invalid combination of event base and event
   --      ID
   --    - Others: Fail

   function esp_event_handler_instance_register
     (event_base        : esp_event_base_t;
      event_id          : int32_t;
      event_handler     : not null esp_event_handler_t;
      event_handler_arg : System.Address;
      instance          : out esp_event_handler_instance_t) return esp_err_t
     with Import, Convention => C,
          External_Name => "esp_event_handler_instance_register";
   --  Register an instance of event handler to the default loop.
   --
   --  This subprogram does the same as
   --  `esp_event_handler_instance_register_with`, except that it registers
   --  the handler to the default event loop.
   --
   --  Note: the event loop library does not maintain a copy of
   --  `event_handler_arg`, therefore the user should ensure that
   --  `event_handler_arg` still points to a valid location by the time the
   --  handler gets called.
   --  @param event_base The base ID of the event to register the handler for
   --  @param event_id The ID of the event to register the handler for
   --  @param event_handler
   --    The handler function which gets called when the event is dispatched
   --  @param event_handler_arg
   --    Data, aside from event data, that is passed to the handler when it
   --    is called
   --  @param instance
   --    An event handler instance object related to the registered event
   --    handler and data. This needs to be kept if the specific callback
   --    instance should be unregistered before deleting the whole event
   --    loop. Registering the same event handler multiple times is possible
   --    and yields distinct instance objects. The data can be the same for
   --    all registrations.
   --  @return
   --    - `ESP_OK`: Success
   --    - `ESP_ERR_NO_MEM`: Cannot allocate memory for the handler
   --    - `ESP_ERR_INVALID_ARG`: Invalid combination of event base and event
   --      ID
   --    - Others: Fail

   procedure esp_event_handler_instance_register
     (event_base        : esp_event_base_t;
      event_id          : int32_t;
      event_handler     : not null esp_event_handler_t;
      event_handler_arg : System.Address;
      instance          : out esp_event_handler_instance_t);
   --  Register an instance of event handler to the default loop.
   --
   --  This subprogram does the same as
   --  `esp_event_handler_instance_register_with`, except that it registers
   --  the handler to the default event loop.
   --
   --  Note: the event loop library does not maintain a copy of
   --  `event_handler_arg`, therefore the user should ensure that
   --  `event_handler_arg` still points to a valid location by the time the
   --  handler gets called.
   --  @param event_base The base ID of the event to register the handler for
   --  @param event_id The ID of the event to register the handler for
   --  @param event_handler
   --    The handler function which gets called when the event is dispatched
   --  @param event_handler_arg
   --    Data, aside from event data, that is passed to the handler when it
   --    is called
   --  @param instance
   --    An event handler instance object related to the registered event
   --    handler and data. This needs to be kept if the specific callback
   --    instance should be unregistered before deleting the whole event
   --    loop. Registering the same event handler multiple times is possible
   --    and yields distinct instance objects. The data can be the same for
   --    all registrations.
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_NO_MEM`: Cannot allocate memory for the handler
   --    - `ESP_ERR_INVALID_ARG`: Invalid combination of event base and event
   --      ID
   --    - Others: Fail

   function esp_event_handler_instance_unregister
     (event_base : esp_event_base_t;
      event_id   : int32_t;
      instance   : in out esp_event_handler_instance_t) return esp_err_t;
   --  Unregister a handler from the system event loop.
   --
   --  This subprogram does the same as
   --  `esp_event_handler_instance_unregister_with`, except that it
   --  unregisters the handler instance from the default event loop.
   --  @param event_base
   --    The base of the event with which to unregister the handler
   --  @param event_id The ID of the event with which to unregister the handler
   --  @param instance
   --    The instance object of the registration to be unregistered. It is
   --    reset to null value on success.
   --  @return
   --    - `ESP_OK`: Success
   --    - `ESP_ERR_INVALID_ARG`: Invalid combination of event base and event
   --      ID
   --    - Others: Fail

   procedure esp_event_handler_instance_unregister
     (event_base : esp_event_base_t;
      event_id   : int32_t;
      instance   : in out esp_event_handler_instance_t);
   --  Unregister a handler from the system event loop.
   --
   --  This subprogram does the same as
   --  `esp_event_handler_instance_unregister_with`, except that it
   --  unregisters the handler instance from the default event loop.
   --  @param event_base
   --    The base of the event with which to unregister the handler
   --  @param event_id The ID of the event with which to unregister the handler
   --  @param instance
   --    The instance object of the registration to be unregistered. It is
   --    reset to null value on success.
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_INVALID_ARG`: Invalid combination of event base and event
   --      ID
   --    - Others: Fail

private

   type esp_event_handler_instance_t is new System.Address;

end ESPIDF.Event;
