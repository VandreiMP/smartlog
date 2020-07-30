
// import 'package:firebase/firestore.dart';
// import 'package:smartlogproject/src/screen/teste2.dart';
// import 'package:flutter/material.dart';


// class CarrosFavoritosPage extends StatefulWidget {
//   final String userDocId;

//   CarrosFavoritosPage(this.userDocId);

//   @override
//   _CarrosFavoritosPageState createState() => _CarrosFavoritosPageState();
// }

// class _CarrosFavoritosPageState extends State<CarrosFavoritosPage> {

//   final _firebaseService = FavoritosService();

//   @override
//   void initState() {
//     var initState = super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BreadCrumb(
//       child: _streams(),
//     );
//   }

//    _streams() {
//     return StreamBuilder(
//       stream: _firebaseService.getStreamCarros(widget.userDocId),
//       builder: (context, snapshot) {
//         // if (snapshot.hasError) {
//         //   return print("Não foi possível buscar os carros");
//         // }

//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         List<DocumentSnapshot> docs = snapshot.data;

//         return RefreshIndicator(
//           onRefresh: _onRefresh,
//           child: _grid(docs),
//         );
//       },
//     );
//   }

//   int _columns(constraints) {
//     int columns = constraints.maxWidth > 800 ? 3 : 2;
//     if (constraints.maxWidth <= 500) {
//       columns = 1;
//     }
//     return columns;
//   }

//   _grid(List<DocumentSnapshot> docs) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         int columns = _columns(constraints);

//         return Container(
//           padding: EdgeInsets.all(16),
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: columns,
//               childAspectRatio: 1.8,
//               mainAxisSpacing: 20,
//               crossAxisSpacing: 20,
//             ),
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               // Firestore
//               DocumentSnapshot doc = docs[index];

//               // Converte o carro para usuário :-)
//               // O carro é favoritado e salvo no Firestore no app Flutter
//               Carro c = Carro.fromMap(doc.data());

//               return StackMaterialContainer(
//                 child: _cardCarro(c),
//                 onTap: () => _onClickCarro(c),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   _cardCarro(Carro c) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double font = constraints.maxWidth * 0.05;

//         return Card(
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Center(
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: 240,
//                       maxHeight: 120,
//                     ),
//                     child: c.urlFoto != null
//                         ? Image.network(
//                             c.urlFoto,
//                             fit: BoxFit.cover,
//                           )
//                         : FlutterLogo(
//                             size: 100,
//                           ),
//                   ),
//                 ),
//                 Center(
//                   child: text(
//                     "${c.nome}",
//                     fontSize: fontSize(font),
//                     maxLines: 1,
//                     ellipsis: true,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   _onClickCarro(Carro c) {
//     if (AppModel.get(context).user.isAdmin()) {
//       PagesModel nav = PagesModel.get(context);
//       nav.push(PageInfo(c.nome, CarroFormPage(carro: c)));
//     } else {
//       push(context, CarroPage(c));
//     }
//   }

//   Future<void> _onRefresh() {
//    return null;
//   }

//   @override
//   void dispose() {
//     super.dispose();

//   }
// }