--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package ESPIDF.Event is

   function esp_event_loop_create_default return esp_err_t
     with Import, Convention => C,
          External_Name => "esp_event_loop_create_default";

   procedure esp_event_loop_create_default;
   
end ESPIDF.Event;
