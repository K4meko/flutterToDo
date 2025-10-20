import 'package:empty_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressBar extends ConsumerWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final tasks = ref.watch(taskProvider);

      final length = tasks.length;
      final completed = tasks.where((element) => element.isDone).length;
      
     final score = length > 0 ? completed / length : 0.0;

      return LinearProgressIndicator(
        value: score,
        
      );


   
  }
}