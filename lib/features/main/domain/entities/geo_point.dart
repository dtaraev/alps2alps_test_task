import 'package:equatable/equatable.dart';

class GeoPoint extends Equatable {
  const GeoPoint(this.latitude, this.longitude);
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}
