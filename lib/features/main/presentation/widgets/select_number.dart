import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SelectNumberScreen extends StatefulWidget {
  const SelectNumberScreen({required this.initialNumber, super.key});
  final int? initialNumber;

  @override
  State<SelectNumberScreen> createState() => _SelectNumberScreenState();
}

class _SelectNumberScreenState extends State<SelectNumberScreen> {
  String? _text;
  late final TextEditingController _textEditingController;

  static const _defaultPadding = 40.0;

  @override
  void initState() {
    super.initState();
    _text = widget.initialNumber?.toString() ?? '';
    _textEditingController = TextEditingController(
      text: widget.initialNumber?.toString(),
    )..addListener(() => _text = _textEditingController.text);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: _defaultPadding,
        left: _defaultPadding,
        right: _defaultPadding,
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: () => context.pop(int.tryParse(_text ?? '')),
            icon: Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
