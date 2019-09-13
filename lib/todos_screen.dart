import 'package:flutter/material.dart';

import 'network_utils.dart';

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({this.userId, this.id, this.title, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed']
    );
  }

}

class NetworkPage extends StatefulWidget {
  @override
  createState() => _NetworkPageView();
}

abstract class _NetworkPageState extends State<NetworkPage> {

  ApiClient _apiClient = ApiClient();

  Future<List<Todo>> fetchTodos() {
    return _apiClient.fetchTodos();
  }

  Future<Todo> fetchTodo(int id) {
    return _apiClient.fetchTodo(id);
  }

}

class _NetworkPageView extends _NetworkPageState {

  Widget _buildFuture() => FutureBuilder<List<Todo>> (
    future: fetchTodos(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                snapshot.data[index].title,
                style: TextStyle(
                    color: snapshot.data[index].completed ? Colors.green : Colors.black54
                ),
              ),
            );
          },
        );

        /*return Text(
          snapshot.data.title
        );*/
      } else {
        /*return Text(
          'Erro fetching data'
        );*/
      }

      return CircularProgressIndicator();
    },
  );

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      title: Text(
        'Todo List',
        style: Theme.of(context).textTheme.title,
      ),
      centerTitle: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: _buildFuture(),
      ),
    );
  }

}