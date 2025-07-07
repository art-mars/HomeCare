import '../models/HomeArea.dart';

// Database of all areas commonly found in homes
// Done
final List<HomeArea> allHomeAreas = [
  HomeArea(id: 'kitchen', name: 'Kitchen'),
  HomeArea(id: 'bathroom', name: 'Bathroom(s)'),
  HomeArea(id: 'bedroom', name: 'Bedroom(s)'),
  HomeArea(id: 'living_room', name: 'Living Room/Family Room'),
  HomeArea(id: 'laundry_room', name: 'Laundry Room'),
  HomeArea(id: 'basement_attic_garage', name: 'Basement/Attic/Garage'),
  HomeArea(id: 'backyard', name: 'Backyard'),
  HomeArea(id: 'general', name: 'General/All Rooms'), // Default for any home
  HomeArea(id: 'other', name: 'Other'),
];