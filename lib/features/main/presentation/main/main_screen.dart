import 'package:alps2alps_test_task/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../di.dart';
import 'main_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<MainCubit>();
    _cubit.getPosition();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numberFormatter = NumberFormat.compactLong();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(context.l10n.mainScreenTitle)),
      ),
      body: Center(
          child: BlocBuilder<MainCubit, MainState>(
        bloc: _cubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.pickUp != null
                        ? '(${numberFormatter.format(state.pickUp!.latitude)}, ${numberFormatter.format(state.pickUp!.longitude)})'
                        : context.l10n.choosePickup),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () => _cubit.onPickUpTapped(),
                      icon: Icon(Icons.location_city),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.dropOff != null
                        ? '(${numberFormatter.format(state.dropOff!.latitude)}, ${numberFormatter.format(state.dropOff!.longitude)})'
                        : context.l10n.chooseDropoff),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () => _cubit.onDropOffTapped(),
                      icon: Icon(Icons.location_city),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.passengersNumber != null
                        ? state.passengersNumber.toString()
                        : context.l10n.passengersNumber),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () => _cubit.onPassengerNumberTapped(),
                      icon: Icon(Icons.person),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.date != null ? DateFormat.yMEd().format(state.date!) : context.l10n.selectDate),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () => _cubit.onDateTapped(),
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.time != null ? state.time!.format(context) : context.l10n.selectTime),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () => _cubit.onTimeTapped(),
                      icon: Icon(Icons.watch_later),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Text(context.l10n.bookButtonTitle),
        onPressed: () => _cubit.onBookTapped(),
      ),
    );
  }
}
