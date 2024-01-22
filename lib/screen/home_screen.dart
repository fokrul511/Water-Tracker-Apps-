import 'package:flutter/material.dart';
import 'package:water_tracker_apps/data/water_tracker_data.dart';
import 'package:intl/intl.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

List<WaterTrackerGlass> listOfWater = [];

class _WaterTrackerState extends State<WaterTracker> {
  final TextEditingController _watercountTexController =
      TextEditingController(text: '1');
  final TextEditingController _noteTexController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Water Tracker',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(40.0),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  onTap: () {
                    if (_globalKey.currentState!.validate()) {
                      if (_watercountTexController.text.isEmpty) {
                        _watercountTexController.text = '1';
                      }
                      final noOfGlasse = _watercountTexController.text.trim();
                      int value = int.tryParse(noOfGlasse) ?? 1;

                      listOfWater.insert(
                          0,
                          WaterTrackerGlass(
                              _noteTexController.text, value, DateTime.now()));
                      setState(() {});
                      _watercountTexController.clear();
                      _noteTexController.clear();
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add Glass',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _watercountTexController,
                      decoration: InputDecoration(hintText: '1'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Your Drink Session'),
                      validator: (String? value) {
                        String v = value ?? '';
                        if (v.isEmpty) {
                          return 'Enter Your Opinion';
                        }
                        return null;
                      },
                      controller: _noteTexController,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: listOfWater.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            listOfWater[index].noOfGlass.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(listOfWater[index].note),
                        subtitle: Text(DateFormat.yMEd()
                            .add_jms()
                            .format(listOfWater[index].time)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            listOfWater.removeAt(index);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
