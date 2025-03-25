import 'package:alps2alps_test_task/features/main/domain/entities/geo_point.dart';
import 'package:alps2alps_test_task/features/main/presentation/navigation_service.dart';
import 'package:alps2alps_test_task/features/main/presentation/widgets/booking_confirmation.dart';
import 'package:alps2alps_test_task/l10n/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

part 'main_state.dart';

@Injectable()
class MainCubit extends Cubit<MainState> {
  MainCubit(this._router, this._navigationService) : super(MainState());
  final GoRouter _router;
  final NavigationService _navigationService;

  Future<void> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    final currentPostion = await Geolocator.getCurrentPosition();
    emit(state.copyWith(currentPosition: GeoPoint(currentPostion.latitude, currentPostion.longitude)));
  }

  Future<void> onPickUpTapped() async {
    final result = await _router.pushNamed('choose_point', queryParameters: _querryParams());
    if (result != null) {
      final point = result as GeoPoint?;
      emit(state.copyWith(pickUp: point));
    }
  }

  Future<void> onDropOffTapped() async {
    final result = await _router.pushNamed('choose_point', queryParameters: _querryParams());
    if (result != null) {
      final point = result as GeoPoint?;
      emit(state.copyWith(dropOff: point));
    }
  }

  Map<String, String> _querryParams() {
    return state.currentPosition != null
        ? {
            'latitude': state.currentPosition!.latitude.toString(),
            'longitude': state.currentPosition!.longitude.toString()
          }
        : {};
  }

  Future<void> onPassengerNumberTapped() async {
    final number = await _router.pushNamed<int>('select_number');
    emit(state.copyWith(passengersNumber: number));
  }

  Future<void> onDateTapped() async {
    final date = await _navigationService.showDate(
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    emit(state.copyWith(date: date));
  }

  Future<void> onTimeTapped() async {
    final time = await _navigationService.showTime(
      initialTime: TimeOfDay.now(),
    );
    emit(state.copyWith(time: time));
  }

  Future<void> onBookTapped() async {
    final stateIsValid = _validateState();
    if (stateIsValid) {
      final result = await _navigationService.showAlert(builder: (context) => BookingConfirmationScreen());
      if (result != false) {
        ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text(_navigationService.navigatorKey.currentContext!.l10n.sucessfulBookingMessage),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(_navigationService.navigatorKey.currentContext!.l10n.emptyFieldsMessage),
        ),
      );
    }
  }

  bool _validateState() {
    return (state.pickUp != null &&
        state.dropOff != null &&
        state.date != null &&
        state.time != null &&
        state.passengersNumber != null);
  }
}
