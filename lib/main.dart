import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqllite/view_contact.dart';

void main(){

  runApp(MaterialApp(home: home(),
  debugShowCheckedModeBanner: false,

  ));
}
class home extends StatefulWidget {
  //const home({Key? key}) : super(key: key);
  Map ?m;
  home([this.m]);

  static Database? database;

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    create_deb();
    if(widget.m!=null)
      {
        t1.text=widget.m!['name'];
        t2.text=widget.m!['number'];

      }else{


    }


  }
  create_deb() async { //for creat the data based



      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'cdmi.db');
      home.database  = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                'CREATE TABLE Contatc_book (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, number TEXT)');
          });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: (widget.m!=null)?Text("Update Contact"):Text("Add Contact"),),
      body: SingleChildScrollView(
        child: Column(children: [
          TextField(controller: t1,),
          TextField(controller: t2,),
          ElevatedButton(onPressed: () {
            String name=t1.text;
            String number=t2.text;

            if(widget.m!=null){

              String sql="update Contatc_book set name='$name',number='$number' where id=${widget.m!['id']}";
              home.database!.rawInsert(sql); //update qury
            }else{
              String qry="INSERT INTO Contatc_book(name,number) values('$name','$number')";

              home.database!.rawInsert(qry);//inster quy

            }

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return View_contact();
            },));


          }, child: Text("Add Contact")),
          ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return View_contact();
              },));
          }, child:(widget.m!=null)? Text("Update Contact"):Text("View Contact")),

        ]),
      ),


    );
  }
}
