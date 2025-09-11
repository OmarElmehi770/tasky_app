import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';

class TaskFirebase {
  static CollectionReference<TaskModel> getCollectionTasks() {
    String id = FirebaseAuth.instance.currentUser?.uid ?? "";
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        )
        .doc(id)
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<void> addTask(TaskModel task) async {
    String id = getCollectionTasks().doc().id;
    task.id = id;
    await getCollectionTasks().doc(id).set(task);
  }

  static Future<List<TaskModel>> getNotCompletedTasks() async {
    QuerySnapshot<TaskModel> tasks = await getCollectionTasks()
        .where('isDone', isEqualTo: false)
        .get();
    return tasks.docs.map<TaskModel>((task) => task.data()).toList();
  }

  static Future<List<TaskModel>> getCompletedTasks() async {
    QuerySnapshot<TaskModel> tasks = await getCollectionTasks()
        .where('isDone', isEqualTo: true)
        .get();
    return tasks.docs.map<TaskModel>((task) => task.data()).toList();
  }

  static Future<bool> isEmpty() async {
    QuerySnapshot<TaskModel> tasks = await getCollectionTasks().get();
    return tasks.docs.map<TaskModel>((task) => task.data()).toList().isEmpty;
  }

  static Future<void> deleteTask(String? id) async {
    await getCollectionTasks().doc(id).delete();
  }

  static Future<void> updateDoneTask(String? id) async {
    var task = await getCollectionTasks().doc(id);

    var data = await task.get();
    bool currentDone = await data.data()?.isDone ?? false;
    await task.update({'isDone': !currentDone});
  }
}
