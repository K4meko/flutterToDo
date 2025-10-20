
import 'package:empty_flutter_app/main.dart';
import 'package:empty_flutter_app/model/taskmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskState extends Notifier<List<Task>>{
  @override
  List<Task> build(){
    return [Task(isDone: false, name: 'Task 1'),
             Task(isDone: true, name: 'Task 2')];
  }
  void addTask(String name) {
    state = [...state, Task(isDone: false, name: name)]; 
  }
  void completeAll(){
    state = state.map((task) => Task(isDone: true, name: task.name)).toList();
  }
  void toggle(int index) {
    // Create a new list with the updated task
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(isDone: !state[i].isDone, name: state[i].name) 
        else
          state[i], 
    ];
  }
}
class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);
    var name = '';
    return 
     Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           ...task.asMap().entries.map((entry) {
             final index = entry.key;
             final value = entry.value;
       
                 return Row(
                   children: [
                     Checkbox(
                       value: value.isDone,
                       
                       onChanged: (newValue) => ref.read(taskProvider.notifier).toggle(index),
                     ),
                      Text(value.name)
                   ],
                 );
                
           
           }),
        
         
                 
                   Row(
                     children: [
                       TextButton(onPressed: (){if(name.isNotEmpty) ref.read(taskProvider.notifier).addTask( name);}, child: const Text('Add Task')),
                       TextButton(onPressed: (){ref.read(taskProvider.notifier).completeAll();}, child: const Text('Complete All'))
                     ],
                   ),
                   TextField(onChanged: (value) => name = value,)
               

          ]
        ),
      );
  }
}