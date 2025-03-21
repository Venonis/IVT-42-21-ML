import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'favorites_service.dart';

abstract class FavoritesServiceInterface {
  Future<void> addFavorite({
    required int id,
    required String name,
    required String description,
    required String firstAppearance,
  });
  Future<List<Map<String, dynamic>>> getFavorites();
  Future<void> deleteFavorite(String name);
}