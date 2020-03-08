
import 'dart:io';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:agenda_de_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions {orderAZ, orderZA}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper auxiliarContatos = ContactHelper();

  List<Contact> contacts = List();


  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _orderContactList,
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                  child: Text('Ordenar de A-Z'),
                  value: OrderOptions.orderAZ,
              ),

              const PopupMenuItem<OrderOptions>(
                child: Text('Ordenar de Z-A'),
                value: OrderOptions.orderZA,
              ),

            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.deepPurple,

        onPressed: (){
          _showContactPage();
        }
      ),

      body: ListView.builder(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 100),
        itemCount: contacts.length,
        itemBuilder: (context, index){
          return _contactCard(context, index);
        },
      ),

    );
  }


  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(

      onTap: (){
        //_showContactPage(contact: contacts[index]);
        _showContactOptions(context, index);
      },


      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[

                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: (
                            contacts[index].img == null ?
                            //Icons.account_circle :
                            AssetImage('images/nullContactImage2.png'):
                            FileImage(File(contacts[index].img))
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left:10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          contacts[index].name ?? "",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          contacts[index].email ?? "",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          contacts[index].phone ?? "",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
        ),
      ),
    );
  }


  void _showContactOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        child: Text('Ligar',
                          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                        ),

                        onPressed: (){
                          launch("tel:${contacts[index].phone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        child: Text('Editar',
                          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                        ),

                        onPressed: (){
                          Navigator.pop(context);
                          _showContactPage(contact: contacts[index]);
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        child: Text('Excluir',
                          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                        ),

                        onPressed: (){
                          auxiliarContatos.deleteContact(contacts[index].id);
                          setState(() {
                            contacts.removeAt(index);
                            Navigator.pop(context);
                          });

                        },
                      ),
                    ),

                  ],
                ),
              );
            },
          );
        },
    );
  }


  void _showContactPage({Contact contact}) async{
    final savedContact = await(
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)),
      )
    );

    if(savedContact != null){
      print(savedContact.toString());
      if(contact != null){
        await auxiliarContatos.updateContact(savedContact);
      }
      else{
        await auxiliarContatos.saveContact(savedContact);
      }

      _getAllContacts();
    }

  }


  void _getAllContacts(){
    auxiliarContatos.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
    });
  }


  void _orderContactList(OrderOptions result){
    switch(result){
      case OrderOptions.orderZA:
        contacts.sort((a, b){
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;

      case OrderOptions.orderAZ:
      default:
        contacts.sort((a, b){
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
    }

    setState(() {

    });
  }


}


