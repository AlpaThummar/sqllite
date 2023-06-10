import 'package:flutter/material.dart';
import 'package:sqllite/main.dart';

class View_contact extends StatefulWidget {
  const View_contact({Key? key}) : super(key: key);

  @override
  State<View_contact> createState() => _View_contactState();
}

class _View_contactState extends State<View_contact> {
  List<Map> l = [];
  bool t = false; // from listview print if not blank data than print

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data();
  }

  get_data() async {
    //data get from 1st page

    String sql = "select * From Contatc_book";
    l = await home.database!.rawQuery(sql);
    print(l);
    t = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Wrap(children: [IconButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return home();
        },));
        
        
      }, icon: Icon(Icons.add))],)],
        title: Text("View Contact"),
      ),
      body: (t==true)
          ? ListView.builder( itemCount: l.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(

                      title: Text("${l[index]['name']}"),
                      subtitle: Text("${l[index]['number']}"),

                    trailing: Wrap(children: [IconButton(onPressed: () {
                      String sql="delete from Contatc_book where id=${l[index]['id']}";
                      home.database!.rawDelete(sql);
                      setState(() {});
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return View_contact();
                      },));

                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return home(l[index]);
                      },));

                    }, icon: Icon(Icons.add))

                    ]),

                  ),

                );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}
