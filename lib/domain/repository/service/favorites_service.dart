part of 'favorites_repository.dart';

class FavoritesService extends FavoritesServiceInterface {
  FavoritesService({required this.dio});
  final Dio dio;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  @override
  Future<void> addFavorite({
    required int id,
    required String name,
    required String description,
    required String firstAppearance,
  }) async {
    try {
      await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorites')
          .doc(name)
          .set({
        'id': id, 
        'name': name,
        'description': description,
        'firstAppearance': firstAppearance,
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      QuerySnapshot snapshot = await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorites')
          .get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> deleteFavorite(String name) async {
    try {
      await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorites')
          .doc(name)
          .delete();
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

}