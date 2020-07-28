import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../constant.dart';

class Store {
  final Firestore _fireStore = Firestore.instance;

  addProduct(Product product) {
    _fireStore.collection(KProductCollection).add({
      KProductCategory: product.category,
      KProductDescription: product.description,
      KProductName: product.name,
      KProductPrice: product.price,
      KProductLocation: product.location
    });
  }


  Stream<QuerySnapshot> loadProducts() {

    return  _fireStore.collection(KProductCollection).snapshots();

  }

   deleteProduct(documentId){
    _fireStore.collection(KProductCollection).document(documentId).delete();
   }

   updateProduct(data,documentId){
    //ال data عبارة عن map من الattributes
    _fireStore.collection(KProductCollection).document(documentId).updateData(data);
   }
//بتعملي retrieve لكل الdocuments مثل ال rows في ال sql
//هادا الحل غلط لانه ما بتنفذ اي اشي بعد ال stream لذلك ما بنفع اعمل return لل list
//  Future<List<Product>> loadProducts() async {
//    List<Product> pl = [];
//    await for (var snapshot in _fireStore.collection(KProductCollection).snapshots()) {
//      //ال snapshot زي كانه table بيحتوي على rows
//
//      for (var doc in snapshot.documents) {
//        //loop on list of documents(rows)
//        //ال doc عبارة عن map بتحتوي ال data
//        var data = doc.data; //map
//        pl.add(Product(
//            name: data[KProductName],
//            price: data[KProductPrice],
//            location: data[KProductLocation],
//            description: data[KProductDescription],
//            category: data[KProductCategory]));
//        //بدي ارجع list of products وبدي اعبي ال attributes تبعتها من ال doc data
//
//      }
//
//    }
//    return pl;
//  }

//بتعملي retrieve لكل الdocuments مثل ال rows في ال sql
//هادا الحل غلط لانه اي تحديث على ال list ما بيظهر الا ازا عملت save
//  Future<List<Product>> loadProducts() async {
//    final snapshot = await _fireStore
//        .collection(KProductCollection)
//        .getDocuments(); //ال snapshot زي كانه table بيحتوي على rows
//    List<Product> pl = [];
//    for (var doc in snapshot.documents) {
//      //loop on list of documents(rows)
//      //ال doc عبارة عن map بتحتوي ال data
//      var data = doc.data; //map
//      pl.add(Product(
//          name: data[KProductName],
//          price: data[KProductPrice],
//          location: data[KProductLocation],
//          description: data[KProductDescription],
//           category: data[KProductCategory]
//      ));
//      //بدي ارجع list of products وبدي اعبي ال attributes تبعتها من ال doc data
//
//    }
//    return pl;
//  }
}
