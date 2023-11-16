import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeAgo extends StatefulWidget {
  const TimeAgo({
    super.key,
    required this.date,
    this.textStyle,
  });

  final DateTime date;
  final TextStyle? textStyle;

  @override
  State<TimeAgo> createState() => _TimeAgoState();
}

class _TimeAgoState extends State<TimeAgo> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        //
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeago.format(
        widget.date,
        locale: Localizations.localeOf(context).languageCode,
      ),
      style: widget.textStyle != null
          ? widget.textStyle!.merge(context.textTheme.labelSmall)
          : context.textTheme.labelSmall,
    );
  }
}
