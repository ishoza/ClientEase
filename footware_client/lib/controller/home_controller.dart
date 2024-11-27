import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footware_client/model/product/product.dart';
import 'package:footware_client/model/product_category/product_category.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<Product> productShowUi = [];

  List<ProductCategory> productCategory = [];
  List<ProductCategory> productCategoryshowUi = [];

  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      productShowUi.assignAll(products);
      Get.snackbar("Success", "Product fetch Sucessfully",
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar("Error", e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot ProductCategorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrievedCategory = ProductCategorySnapshot
          .docs
          .map((doc) =>
              ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      productCategory.clear();
      productCategory.assignAll(retrievedCategory);
      productCategoryshowUi.assignAll(productCategory);
    } catch (e) {
      Get.snackbar("Error", e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    productShowUi.clear();
    productShowUi =
        products.where((products) => products.category == category).toList();
    update();
  }

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productShowUi = products;
    } else {
      List<String> lowerCaseBrands =
          brands.map((brand) => brand.toLowerCase()).toList();
      productShowUi = products
          .where((products) =>
              lowerCaseBrands.contains(products.brand?.toLowerCase()))
          .toList();
    }
    update();
  }

  sortByPrice({required bool ascending}) {
    List<Product> sortedProducts = List<Product>.from(productShowUi);
    sortedProducts.sort((a, b) => ascending
        ? a.price!.compareTo(b.price!)
        : b.price!.compareTo(a.price!));
    productShowUi = sortedProducts;
    update();
  }
}
