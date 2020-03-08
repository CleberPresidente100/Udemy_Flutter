
import 'dart:io';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  bool _contactChanged = false;
  Contact _editedContact;

  final _nameControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _phoneControler = TextEditingController();

  final _nameFocus = FocusNode();


  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = Contact();
    }
    else{
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameControler.text = _editedContact.name;
      _emailControler.text = _editedContact.email;
      _phoneControler.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text(_editedContact.name ?? "Novo Contato", style: TextStyle(color: Colors.white,),),
            centerTitle: true,
          ),

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.save),

            onPressed: (){
              //print('Botão Salvar');

              if(_editedContact.name != null && _editedContact.name.isNotEmpty){
                Navigator.pop(context, _editedContact);
              }
              else{
                FocusScope.of(context).requestFocus(_nameFocus);
              }

            },
          ),

          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[

                GestureDetector(
                  child: Container(
                    //alignment: Alignment.center,
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: (
                            _editedContact.img == null ?
                            //Icons.account_circle:
                            AssetImage('images/nullContactImage2.png'):
                            FileImage(File(_editedContact.img))
                        ),
                      ),
                    ),
                  ),

                  onTap: (){
                    //print('Imagem Contato');
                    ImagePicker.pickImage(source: ImageSource.camera).then((file){
                      if(file == null) return;
                      setState(() {
                        _editedContact.img = file.path;
                      });

                    });
                  },
                ),

                TextField(
                  focusNode: _nameFocus,
                  controller: _nameControler,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),

                  onChanged: (text){
                    _contactChanged = true;
                    setState(() {
                      _editedContact.name = text;
                    });
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextField(
                    controller: _emailControler,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'e-Mail',
                    ),

                    onChanged: (text){
                      _contactChanged = true;
                      _editedContact.email = text;
                    },
                  ),
                ),

                TextField(
                  controller: _phoneControler,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                  ),

                  onChanged: (text){
                    _contactChanged = true;
                    _editedContact.phone = text;
                  },
                ),

              ],
            ),
          ),

        ),
    );
  }

  Future<bool> _requestPop(){
    if(_contactChanged){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Descartar Alterações ?'),
              content: Text('Saindo, as alterações serão perdidas.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Descartar'),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),

                FlatButton(
                  child: Text('Ficar'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),

              ],
            );
          },
      );

      return Future.value(false);
    }
    else{
      return Future.value(true);
    }
  }
}



