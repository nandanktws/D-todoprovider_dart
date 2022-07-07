import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider_dart/Provider/AppState.dart';

class TodoClass extends StatefulWidget {
  const TodoClass({Key? key}) : super(key: key);

  @override
  State<TodoClass> createState() => _TodoClassState();
}

class _TodoClassState extends State<TodoClass> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).fetchdata;
  }

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  final _refreshkey = GlobalKey<RefreshIndicatorState>();
  String input = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Todo Provider",
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
            )),
        body: RefreshIndicator(
          key: _refreshkey,
          onRefresh: () async {
            await context.read<AppState>().fetchdata;
            return Future.delayed(const Duration(seconds: 1));
          },
          child: Center(
              child: Consumer<AppState>(builder: (context, value, child) {
            return value.list.length == 0
                ? const CircularProgressIndicator()
                : value.error
                    ? Text("There is an error. ${value.errormessage}")
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.list.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            title: Text(value.list[index]['title']),
                            subtitle: Text(value.list[index]['description']),
                            leading: Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Text("${value.list[index]['id']}"),
                                ),
                              ],
                            ),
                            trailing: Text(value.list[index]['status']),
                            onTap: () {
                              _controller1.text = value.list[index]['title'];
                              _controller2.text =
                                  value.list[index]['description'];
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Container(
                                        child: Column(
                                          children: [
                                            TextField(
                                              onChanged: (String value) {
                                                input = value;
                                              },
                                              controller: _controller1,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder()),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            TextField(
                                              onChanged: (String value) {
                                                input = value;
                                              },
                                              controller: _controller2,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder()),
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _refreshkey.currentState?.show;
                                              String title = _controller1.text;
                                              String description =
                                                  _controller2.text;
                                              Provider.of<AppState>(context,
                                                      listen: false)
                                                  .deletedata(
                                                      value.list[index]['id'],
                                                      title,
                                                      description);
                                              print(
                                                value.list[index]['id'],
                                              );
                                              print(title);
                                              print(description);
                                            },
                                            child: const Text("Delete")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _refreshkey.currentState?.show;
                                              String title = _controller1.text;
                                              String description =
                                                  _controller2.text;
                                              _controller1.clear();
                                              _controller2.clear();
                                              Provider.of<AppState>(context,
                                                      listen: false)
                                                  .patchdata(
                                                      value.list[index]['id'],
                                                      title,
                                                      description);
                                              print(
                                                value.list[index]['id'],
                                              );
                                              print(title);
                                              print(description);
                                            },
                                            child: const Text("Update"))
                                      ],
                                    );
                                  });
                            },
                          ));
                        });
          })),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Container(
                      height: 150,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (String value) {
                              input = value;
                            },
                            controller: _controller1,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "title"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            onChanged: (String value) {
                              input = value;
                            },
                            controller: _controller2,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "description"),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _refreshkey.currentState?.show;
                            String title = _controller1.text;
                            String description = _controller2.text;
                            Provider.of<AppState>(context, listen: false)
                                .postdata(title, description);
                            // saveTask(input);
                            // print(saveTask);
                            _controller1.clear();
                            _controller2.clear();
                          },
                          child: const Text("Add"))
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
//  void saveTask(String input) {
//   Provider.of<AppState>(context, listen: false).addInput(input);
//   print(saveTask);
//   // print(saveTask(input));
// }
}
