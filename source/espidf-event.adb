--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Ada_ESP_Check_Error;

package body ESPIDF.Event is

   -----------------------------------
   -- esp_event_loop_create_default --
   -----------------------------------

   procedure esp_event_loop_create_default is
   begin
      Ada_ESP_Check_Error (esp_event_loop_create_default);
   end esp_event_loop_create_default;

end ESPIDF.Event;
