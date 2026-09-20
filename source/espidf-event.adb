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

   -------------------------------------------
   -- esp_event_handler_instance_unregister --
   -------------------------------------------

   function esp_event_handler_instance_unregister
     (event_base : esp_event_base_t;
      event_id   : int32_t;
      instance   : in out esp_event_handler_instance_t) return esp_err_t
   is
      function Imported
        (event_base : esp_event_base_t;
         event_id   : int32_t;
         instance   : esp_event_handler_instance_t) return esp_err_t
        with Import, Convention => C,
             External_Name => "esp_event_handler_instance_unregister";

   begin
      return Result : constant esp_err_t :=
        Imported (event_base, event_id, instance)
      do
         if Result = ESP_OK then
            instance := esp_event_handler_instance_t (System.Null_Address);
         end if;
      end return;
   end esp_event_handler_instance_unregister;

   -------------------------------------------
   -- esp_event_handler_instance_unregister --
   -------------------------------------------

   procedure esp_event_handler_instance_unregister
     (event_base : esp_event_base_t;
      event_id   : int32_t;
      instance   : in out esp_event_handler_instance_t) is
   begin
      Ada_ESP_Check_Error
        (esp_event_handler_instance_unregister
          (event_base,
           event_id,
           instance));
   end esp_event_handler_instance_unregister;

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
