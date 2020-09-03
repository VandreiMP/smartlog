// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
// import 'package:smartlogproject/src/Entidades/usuario/usuario.dart';

// class HomePage extends StatelessWidget {
//   final _bloc = UsuarioBloc();
//   final _dateFormat = DateFormat("dd/MM/yyyy");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Human Resources"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           var person = Usuario()
//             ..nome = ""
//             ..email = ""
//             ..senha = "";
//         },
//       ),
//       body: Container(
//         child: StreamBuilder<List<Usuario>>(
//           stream:  null,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) return CircularProgressIndicator();

//             return Container(
//               child: ListView(
//                 children: snapshot.data.map((person) {
//                   return Dismissible(
//                     key: Key(person.documentId()),
//                     onDismissed: (direction) {},
//                     child: ListTile(
//                       title: Text(person.nome),
//                       subtitle: Text(person.email),
//                       trailing: Icon(Icons.keyboard_arrow_right),
//                       onTap: () {},
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
