import '../models/MaintenanceItem.dart';
import '../models/MaintenanceTask.dart';

// Database of all items commonly found in each of their respective areas
// Done
final List<MaintenanceItem> allMaintenanceItems = [

  // -----------------------------KITCHEN ITEMS---------------------------------

  MaintenanceItem(id: 'fridge', name: 'Refrigerator', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'fridge_interior', name: 'Clean Interior', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fridge_exterior', name: 'Clean Exterior', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fridge_defrost', name: 'Defrost Freezer (if needed)', frequency: 'bi-annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fridge_coils', name: 'Dust Condenser Coils', frequency: 'bi-annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fridge_seals', name: 'Clean & Inspect Door Seals', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'fridge_dispenser', name: 'Refrigerator w/ Water Dispenser', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'dispenser_nozzle', name: 'Clean Nozzle', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'dispenser_flush', name: 'Flush Water Lines', frequency: 'bi-annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'dispenser_filter', name: 'Replace Water Filter', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'stovetop', name: 'Stovetop', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'stovetop_clean_daily', name: 'Clean Daily', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'stovetop_grates', name: 'Clean Grates & Burners', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'stovetop_inspect', name: 'Professional Inspection', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'oven', name: 'Oven', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'oven_wipe', name: 'Wipe Interior After Each Use', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'oven_deep_clean', name: 'Deep Clean Interior & Inspect Seals', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'oven_inspect', name: 'Professional Inspection', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'range_hood', name: 'Range Hood', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'hood_exterior', name: 'Clean Exterior', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'hood_filter', name: 'Clean/Replace Filter', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'hood_fan_blades', name: 'Deep Clean Fan Blades', frequency: 'quarterly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'microwave', name: 'Microwave', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'microwave_interior', name: 'Wipe Interior After Each Use', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'microwave_exterior', name: 'Clean Exterior & Check for Damage', frequency: 'weekly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'dishwasher', name: 'Dishwasher', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'dishwasher_exterior', name: 'Clean Exterior', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'dishwasher_seal', name: 'Clean & Inspect Door Seal', frequency: 'bi-weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'dishwasher_filter', name: 'Deep Clean Interior & Filter', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'dishwasher_arms', name: 'Clean Spray Arms', frequency: 'quarterly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'kitchen_sink', name: 'Kitchen Sink', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'kitchen_sink_clean', name: 'Clean Sink', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'kitchen_sink_flush', name: 'Flush Sink with Hot Water', frequency: 'weekly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'cabinets', name: 'Cabinets', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'cabinets_exterior', name: 'Wipe Down Exterior', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'cabinets_deep_clean', name: 'Deep Clean Interior & Exterior', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'countertops', name: 'Countertops', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'countertops_clean', name: 'Clean Countertops', frequency: 'daily', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'pantry', name: 'Pantry', areaId: 'kitchen', tasks: [
    MaintenanceTask(id: 'pantry_wipe', name: 'Wipe Down Pantry', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pantry_deep_clean', frequency: 'quarterly', dueDate: DateTime.now(), name: 'Deep Clean Pantry'),
  ]),

  // -----------------------------BATHROOM ITEMS---------------------------------

  MaintenanceItem(id: 'bathroom_exhaust_fan', name: 'Exhaust Fan', areaId: 'bathroom', tasks: [
    MaintenanceTask(id: 'exhaust_fan_dust', name: 'Dust Fan', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'exhaust_fan_deep_clean', name: 'Deep Clean Fan & Check Vent', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'bathroom_sink', name: 'Bathroom Sink', areaId: 'bathroom', tasks: [
    MaintenanceTask(id: 'bathroom_sink_wipe', name: 'Wipe Sink', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'bathroom_sink_clean', name: 'Clean Sink', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'bathroom_sink_flush', name: 'Flush Sink with Hot Water', frequency: 'weekly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'mounted_mirror', name: 'Mounted Mirror', areaId: 'bathroom', tasks: [
    MaintenanceTask(id: 'mirror_clean', name: 'Clean Mirror', frequency: 'weekly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'shower_bathtub', name: 'Shower/Bathtub', areaId: 'bathroom', tasks: [
    MaintenanceTask(id: 'shower_wipe', name: 'Wipe Away Water After Each Use', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'shower_clean', name: 'Clean Shower/Bathtub', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'shower_reseal_grout', name: 'Reseal Grout', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'glass_doors', name: 'Glass Doors (Shower)', areaId: 'bathroom', tasks: [
    MaintenanceTask(id: 'glass_doors_wipe', name: 'Wipe Away Water After Each Use', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'glass_doors_clean', name: 'Clean Glass Doors', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'glass_doors_deep_clean', name: 'Deep Clean Glass Doors', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'glass_doors_reseal_grout', name: 'Reseal Grout', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'toilet', name: 'Toilet', areaId: 'bathroom', tasks: [
    MaintenanceTask(id: 'toilet_clean', name: 'Clean Toilet', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'toilet_check_leaks', name: 'Check for Leaks', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'showerhead', name: 'Showerhead', areaId: 'bathroom', tasks: [
    MaintenanceTask(id: 'showerhead_descale', name: 'Descale Showerhead', frequency: 'quarterly', dueDate: DateTime.now()),
  ]),

  // -----------------------------BEDROOM ITEMS---------------------------------

  MaintenanceItem(id: 'closet', name: 'Closet', areaId: 'bedroom', tasks: [
    MaintenanceTask(id: 'closet_clean', name: 'Clean Closet', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'closet_deep_clean', name: 'Deep Clean Closet', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),

  // ---------------------------LIVING ROOM ITEMS-------------------------------

  MaintenanceItem(id: 'fireplace', name: 'Fireplace', areaId: 'living_room', tasks: [
    MaintenanceTask(id: 'fireplace_damper', name: 'Check Damper Functionality', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fireplace_clean_after_use', name: 'Clean After Each Use', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fireplace_inspect_creosote', name: 'Inspect for Damage/Creosote Buildup', frequency: 'bi-annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fireplace_chimney_inspect', name: 'Schedule Chimney Inspection', frequency: 'annually', dueDate: DateTime.now()),
  ]),

  // ---------------------------LAUNDRY ROOM ITEMS------------------------------

  MaintenanceItem(id: 'washing_machine', name: 'Washing Machine', areaId: 'laundry_room', tasks: [
    MaintenanceTask(id: 'washer_wipe_water', name: 'Wipe Away Water After Each Use', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'washer_dispenser', name: 'Clean Detergent Dispenser & Exterior', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'washer_cleaning_cycle', name: 'Run Cleaning Cycle & Inspect for Damage/Leaks', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'washer_drain_filter', name: 'Clean Drain Pump Filter', frequency: 'quarterly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'washer_hoses', name: 'Replace Hoses', frequency: 'every_3_5_years', dueDate: DateTime.now()), // Custom frequency
  ]),
  MaintenanceItem(id: 'clothes_dryer', name: 'Clothes Dryer', areaId: 'laundry_room', tasks: [
    MaintenanceTask(id: 'dryer_lint_filter', name: 'Clean Lint Filter After Each Use', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'dryer_wipe', name: 'Wipe Interior & Exterior, Wash Lint Filter', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'dryer_vent', name: 'Clean Dryer Vent', frequency: 'bi-annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'dryer_inspect', name: 'Schedule Professional Inspection', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'laundry_sink', name: 'Laundry Sink', areaId: 'laundry_room', tasks: [
    MaintenanceTask(id: 'laundry_sink_clean', name: 'Clean Sink', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'laundry_sink_flush', name: 'Flush Sink with Hot Water', frequency: 'weekly', dueDate: DateTime.now()),
  ]),

  // ----------------------BASEMENT/ATTIC/GARAGE ITEMS--------------------------

  MaintenanceItem(id: 'ac_system', name: 'Air Conditioning System', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'ac_drain_pan', name: 'Inspect & Clean Condensate Drain Pan', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'ac_air_filter', name: 'Replace Air Filter', frequency: 'quarterly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'ac_condenser_inspect', name: 'Inspect Condenser for Damage', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'ac_condenser_clean', name: 'Clean Condenser', frequency: 'bi-annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'ac_professional_inspect', name: 'Schedule Professional Inspection', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'furnace', name: 'Furnace', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'furnace_filter', name: 'Inspect & Clean Filters (heating season)', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'furnace_professional_inspect', frequency: 'annually', dueDate: DateTime.now(), name: 'Schedule Professional Inspection'),
  ]),
  MaintenanceItem(id: 'broiler', name: 'Broiler', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'broiler_clean', name: 'Clean After Each Use', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'broiler_inspect_gas', name: 'Inspect Gas Lines (Professional)', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'plumbing', name: 'Plumbing (General)', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'plumbing_check_leaks', name: 'Check for Leaks', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'plumbing_flush_drains', name: 'Flush Drains with Hot Water', frequency: 'weekly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'water_heater', name: 'Water Heater', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'water_heater_flush', name: 'Flush Sediment', frequency: 'bi-annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'water_heater_test_valve', name: 'Test Pressure Relief Valve', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'water_heater_anode_rod', name: 'Inspect Anode Rod', frequency: 'every_3_5_years', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'electric_panel', name: 'Electric Panel', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'electric_panel_inspect_damage', name: 'Inspect for Damage/Tripped Breakers', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'electric_panel_professional_inspect', frequency: 'every_3_5_years', dueDate: DateTime.now(), name: 'Schedule Professional Inspection'),
  ]),
  MaintenanceItem(id: 'breaker_box', name: 'Breaker Box', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'breaker_box_inspect', name: 'Inspect for Damage/Tripped Breakers', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'sump_pump', name: 'Sump Pump', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'sump_pump_test', name: 'Test Sump Pump (wet seasons)', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'sump_pump_clean_pit', name: 'Clean Sump Pit', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'sump_pit', name: 'Sump Pit', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'sump_pit_clean', name: 'Clean Sump Pit & Remove Debris', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'insulation', name: 'Insulation', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'insulation_inspect', name: 'Inspect for Damage/Pests', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'insulation_check_r_value', frequency: 'every_5_10_years', dueDate: DateTime.now(), name: 'Check R-Value'),
  ]),
  MaintenanceItem(id: 'submersible_pump', name: 'Submersible Pump', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'submersible_pump_inspect', name: 'Inspect for Leaks/Operation', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'submersible_pump_clean_screen', name: 'Clean Screen', frequency: 'quarterly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'sewer_line', name: 'Sewer Line', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'sewer_line_inspect', name: 'Professional Inspection (if slow drains)', frequency: 'every_2_5_years', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'garage_door', name: 'Garage Door(s)', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'garage_door_auto_reverse', name: 'Test Auto-Reverse Function', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'garage_door_lubricate', name: 'Lubricate Moving Parts', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'garage_door_springs_cables', name: 'Check Springs & Cables (Professional)', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'garage_door_opener', name: 'Garage Door Opener(s)', areaId: 'basement_attic_garage', tasks: [
    MaintenanceTask(id: 'opener_safety_reverse', name: 'Test Safety Reversal System', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'opener_lubricate', name: 'Lubricate Chain/Screw Drive', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'opener_remote_battery', name: 'Check Remote Battery', frequency: 'annually', dueDate: DateTime.now()),
  ]),

  // -------------------------------YARD ITEMS----------------------------------

  MaintenanceItem(id: 'hose_faucet', name: 'Hose Faucet', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'hose_faucet_check_leaks', name: 'Check for Leaks', frequency: 'quarterly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'hose_faucet_drain_disconnect', name: 'Drain & Disconnect Hoses (before freezing)', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'sprinklers', name: 'Sprinklers', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'sprinklers_test', name: 'Test System', frequency: 'quarterly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'sprinklers_clean_heads', name: 'Clean Sprinkler Heads', frequency: 'quarterly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'sprinklers_adjust', name: 'Adjust for Optimal Coverage', frequency: 'quarterly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'garden', name: 'Garden', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'garden_weed', name: 'Weed Garden', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'garden_fertilize', name: 'Fertilize Garden', frequency: 'quarterly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'garden_prune', name: 'Prune Plants', frequency: 'quarterly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'lawn', name: 'Lawn', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'lawn_mow', name: 'Mow Lawn (during growing season)', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'lawn_fertilize', name: 'Fertilize Lawn', frequency: 'quarterly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'lawn_aerate', name: 'Aerate Lawn', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'lawn_dethatch', name: 'Dethatch Lawn (as needed)', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'pool', name: 'Pool', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'pool_chemistry', name: 'Test Water Chemistry', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pool_skimmer', name: 'Clean Skimmer Basket', frequency: 'daily', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pool_vacuum', name: 'Vacuum Pool', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pool_filter', name: 'Clean Filter', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pool_open_close', name: 'Professional Opening/Closing', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'porch', name: 'Porch', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'porch_clean', name: 'Clean Porch', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'porch_inspect_damage', name: 'Inspect for Rot/Damage', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'porch_reseal_wood', name: 'Reseal Wood (if applicable)', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'deck', name: 'Deck', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'deck_clean', name: 'Clean Deck', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'deck_inspect_damage', name: 'Inspect for Rot/Damage', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'deck_reseal_wood', name: 'Reseal Wood (if applicable)', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'balcony', name: 'Balcony', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'balcony_clean', name: 'Clean Balcony', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'balcony_inspect_damage', name: 'Inspect for Rot/Damage', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'balcony_reseal_wood', name: 'Reseal Wood (if applicable)', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'shed', name: 'Shed', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'shed_inspect', name: 'Inspect for Leaks/Damage', frequency: 'bi-annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'shed_clean_out', name: 'Clean Out Shed', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'cement_pathways', name: 'Cement Pathways', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'pathways_sweep', name: 'Sweep Pathways', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pathways_power_wash', name: 'Power Wash Pathways', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pathways_inspect_cracks', name: 'Inspect for Cracks', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'driveway', name: 'Driveway', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'driveway_sweep', name: 'Sweep Driveway', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'driveway_inspect_cracks', name: 'Inspect for Cracks', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'driveway_seal', name: 'Seal Driveway', frequency: 'every_2_3_years', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'mailbox', name: 'Mailbox', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'mailbox_check_damage', name: 'Check for Damage', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'mailbox_clean', name: 'Clean Mailbox', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'curb', name: 'Curb', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'curb_inspect_damage', name: 'Inspect for Damage', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'sidewalk', name: 'Sidewalk', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'sidewalk_sweep', name: 'Sweep Sidewalk', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'sidewalk_inspect_cracks', name: 'Inspect for Cracks', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'fence', name: 'Fence', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'fence_inspect_damage', name: 'Inspect for Damage', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fence_clean', name: 'Clean Fence', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fence_stain_seal', name: 'Stain/Seal Wood Fences', frequency: 'every_2_3_years', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'outdoor_light_fixtures', name: 'Outdoor Light Fixtures', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'outdoor_lights_clean', name: 'Clean Fixtures', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'outdoor_lights_check_bulbs', name: 'Check Bulbs', frequency: 'annually', dueDate: DateTime.now()),
    MaintenanceTask(id: 'outdoor_lights_inspect_wiring', name: 'Inspect for Damage/Loose Wiring', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'house_number', name: 'House Number', areaId: 'backyard', tasks: [
    MaintenanceTask(id: 'house_number_clean', name: 'Clean House Number', frequency: 'monthly', dueDate: DateTime.now()),
  ]),

  // --------------------------OTHER/GENERAL ITEMS------------------------------

  MaintenanceItem(id: 'security_system', name: 'Security System', areaId: 'other', tasks: [
    MaintenanceTask(id: 'security_test_sensors', name: 'Test Sensors', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'security_check_battery', name: 'Check Battery Backup', frequency: 'annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'garbage_bins', name: 'Garbage Bins', areaId: 'other', tasks: [
    MaintenanceTask(id: 'garbage_bins_rinse', name: 'Rinse Bins', frequency: 'weekly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'garbage_bins_deep_clean', name: 'Deep Clean Bins', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'pest_control', name: 'Pest Control', areaId: 'other', tasks: [
    MaintenanceTask(id: 'pest_inspect', name: 'Inspect for Pests', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pest_preventative', name: 'Apply Preventative Measures', frequency: 'quarterly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'pest_professional', name: 'Call Professional (as needed)', frequency: 'annually', dueDate: DateTime.now()),
  ]),

  // -----------------------------DEFAULT ITEMS---------------------------------

  MaintenanceItem(id: 'baseboards', name: 'Baseboards', areaId: 'general', tasks: [
    MaintenanceTask(id: 'baseboards_clean', name: 'Clean Baseboards', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'doors', name: 'Doors', areaId: 'general', tasks: [
    MaintenanceTask(id: 'doors_clean', name: 'Clean Doors', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'doors_check_screws_hinges', name: 'Check for Loose Screws & Squeaky Hinges', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'outlets', name: 'Outlets', areaId: 'general', tasks: [
    MaintenanceTask(id: 'outlets_dust', name: 'Dust Outlets (Cover Only)', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'outlets_check_damage', name: 'Check for Loose/Damaged Outlets', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'outlets_test_gfci', name: 'Test GFCI Outlets', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'windows', name: 'Windows', areaId: 'general', tasks: [
    MaintenanceTask(id: 'windows_inside_clean', name: 'Clean Inside Windows & Check for Damage/Mold', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'windows_outside_clean', name: 'Clean Outside Windows & Check for Damage/Mold', frequency: 'bi-annually', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'lightswitch', name: 'Lightswitch', areaId: 'general', tasks: [
    MaintenanceTask(id: 'lightswitch_dust', name: 'Dust Lightswitch (Cover Only)', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'lightswitch_check_mounting', name: 'Check for Loose Mounting/Damage', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'carbon_monoxide_smoke_detector', name: 'Carbon Monoxide/Smoke Detector', areaId: 'general', tasks: [
    MaintenanceTask(id: 'detector_dust_test', name: 'Dust & Test Detector', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'detector_replace', name: 'Replace Detector (every 5-7 years)', frequency: 'every_5_7_years', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'vent_covers', name: 'Vent Covers', areaId: 'general', tasks: [
    MaintenanceTask(id: 'vent_covers_clean', name: 'Clean Vent Covers', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'light_fixtures', name: 'Light Fixtures', areaId: 'general', tasks: [
    MaintenanceTask(id: 'light_fixtures_dust', name: 'Dust Light Fixtures', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'light_fixtures_check_damage', name: 'Check for Damage', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'recess_lighting', name: 'Recess Lighting', areaId: 'general', tasks: [
    MaintenanceTask(id: 'recess_lighting_dust', name: 'Dust Recess Lighting', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'recess_lighting_check_damage', name: 'Check for Damage', frequency: 'monthly', dueDate: DateTime.now()),
  ]),
  MaintenanceItem(id: 'fire_extinguisher', name: 'Fire Extinguisher', areaId: 'general', tasks: [
    MaintenanceTask(id: 'fire_extinguisher_inspect', name: 'Monthly Inspection', frequency: 'monthly', dueDate: DateTime.now()),
    MaintenanceTask(id: 'fire_extinguisher_replace', name: 'Replace (every 10-12 years)', frequency: 'every_10_12_years', dueDate: DateTime.now()),
  ]),
];
