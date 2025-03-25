import 'package:alps2alps_test_task/features/main/domain/entities/geo_point.dart';
import 'package:alps2alps_test_task/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChoosePointScreen extends StatefulWidget {
  const ChoosePointScreen({this.initialPosition, super.key});
  final GeoPoint? initialPosition;

  @override
  State<ChoosePointScreen> createState() => _ChoosePointScreenState();
}

class _ChoosePointScreenState extends State<ChoosePointScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _onConfirm() {
    if (_selectedLocation != null) {
      Navigator.pop(context, GeoPoint(_selectedLocation!.latitude, _selectedLocation!.longitude));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.confirmLocationMessage)),
      );
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.chooseLocationTitle)),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            onTap: _onMapTapped,
            initialCameraPosition: CameraPosition(
              target: widget.initialPosition != null
                  ? LatLng(widget.initialPosition!.latitude, widget.initialPosition!.longitude)
                  : const LatLng(37.7749, -122.4194),
              zoom: 12,
            ),
            markers: _selectedLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId('selected'),
                      position: _selectedLocation!,
                    ),
                  }
                : {},
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: _onConfirm,
              icon: const Icon(Icons.check),
              label: Text(context.l10n.confirmLocationButtonTitle),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
