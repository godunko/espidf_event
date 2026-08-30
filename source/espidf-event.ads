--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with System;

with ESPIDF.C_Strings;

package ESPIDF.Event is

   type esp_event_base_t is new ESPIDF.C_Strings.const_char_ptr;

   type esp_event_handler_t is
     access procedure
       (event_handler_arg : System.Address;
        event_base        : esp_event_base_t;
        event_id          : int32_t;
        event_data        : System.Address) with Convention => C;

   type esp_event_handler_instance_t is private;

   ESP_EVENT_ANY_ID : constant int32_t := -1;

   function esp_event_loop_create_default return esp_err_t
     with Import, Convention => C,
          External_Name => "esp_event_loop_create_default";

   procedure esp_event_loop_create_default;

   function esp_event_handler_instance_register
     (event_base        : esp_event_base_t;
      event_id          : int32_t;
      event_handler     : not null esp_event_handler_t;
      event_handler_arg : System.Address;
      instance          : out esp_event_handler_instance_t) return esp_err_t
     with Import, Convention => C,
          External_Name => "esp_event_handler_instance_register";

   procedure esp_event_handler_instance_register
     (event_base        : esp_event_base_t;
      event_id          : int32_t;
      event_handler     : not null esp_event_handler_t;
      event_handler_arg : System.Address;
      instance          : out esp_event_handler_instance_t);

private

   type esp_event_handler_instance_t is new System.Address;

end ESPIDF.Event;
