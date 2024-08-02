import 'package:flutter/material.dart';

class QueueingPage extends StatefulWidget {
  @override
  _QueueingPageState createState() => _QueueingPageState();
}

class _QueueingPageState extends State<QueueingPage> {
  List<String> queue = [];

  final TextEditingController _controller = TextEditingController();

  void _addToQueue() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        queue.add(_controller.text);
        _controller.clear();
      }
    });
  }

  void _removeFromQueue(int index) {
    setState(() {
      queue.removeAt(index);
    });
  }

  void _updateQueue(int index) {
    setState(() {
      if (_controller.text.isNotEmpty) {
        queue[index] = _controller.text;
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queueing'),
        backgroundColor: Color(0xFF6A1B9A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter a name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addToQueue,
              child: Text('Add to Queue'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6A1B9A),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: queue.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(queue[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _controller.text = queue[index];
                              _updateQueue(index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeFromQueue(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
