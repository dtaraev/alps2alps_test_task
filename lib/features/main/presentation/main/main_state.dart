part of 'main_cubit.dart';

@immutable
final class MainState extends Equatable {
  const MainState({
    this.currentPosition,
    this.pickUp,
    this.dropOff,
    this.passengersNumber,
    this.date,
    this.time,
  });

  final GeoPoint? currentPosition;
  final GeoPoint? pickUp;
  final GeoPoint? dropOff;
  final int? passengersNumber;
  final DateTime? date;
  final TimeOfDay? time;

  @override
  List<Object?> get props => [currentPosition, pickUp, dropOff, passengersNumber, date, time];

  MainState copyWith({
    GeoPoint? currentPosition,
    GeoPoint? pickUp,
    GeoPoint? dropOff,
    int? passengersNumber,
    DateTime? date,
    TimeOfDay? time,
  }) {
    return MainState(
      currentPosition: currentPosition ?? this.currentPosition,
      pickUp: pickUp ?? this.pickUp,
      dropOff: dropOff ?? this.dropOff,
      passengersNumber: passengersNumber ?? this.passengersNumber,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
