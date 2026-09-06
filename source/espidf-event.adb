--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Ada_ESP_Check_Error;

package body ESPIDF.Event is

   -----------------------------------------
   -- esp_event_handler_instance_register --
   -----------------------------------------

   procedure esp_event_handler_instance_register
     (event_base        : esp_event_base_t;
      event_id          : int32_t;
      event_handler     : not null esp_event_handler_t;
      event_handler_arg : System.Address;
      instance          : out esp_event_handler_instance_t) is
   begin
      Ada_ESP_Check_Error
        (esp_event_handler_instance_register
          (event_base,
           event_id,
           event_handler,
           event_handler_arg,
           instance));
   end esp_event_handler_instance_register;

   --------------------------------
   -- esp_event_handler_register --
   --------------------------------

   procedure esp_event_handler_register
     (event_base        : esp_event_base_t;
      event_id          : int32_t;
      event_handler     : not null esp_event_handler_t;
      event_handler_arg : System.Address := System.Null_Address) is
   begin
      Ada_ESP_Check_Error
        (esp_event_handler_register
          (event_base,
           event_id,
           event_handler,
           event_handler_arg));
   end esp_event_handler_register;

   -----------------------------------
   -- esp_event_loop_create_default --
   -----------------------------------

   procedure esp_event_loop_create_default is
   begin
      Ada_ESP_Check_Error (esp_event_loop_create_default);
   end esp_event_loop_create_default;

end ESPIDF.Event;
