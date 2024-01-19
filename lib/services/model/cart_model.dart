import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartData extends Equatable {
  @HiveField(0)
  final String productName;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String price;

  @HiveField(3)
  final String stock;

  @HiveField(4)
  final String desc;

  @HiveField(5)
  final String storename;

  @HiveField(6)
  final String storeid;

  @HiveField(7)
  final String id;

  @HiveField(8)
  final String status;

  @HiveField(9)
  final String pimage;

  @HiveField(10)
  final List<String> carouselImg;

  @HiveField(11)
  final int points;

  @HiveField(12)
  final dynamic totalrating;

  @HiveField(13)
  final String ratingCount;

  @HiveField(14)
  final dynamic quantity;

  const CartData({
    required this.productName,
    required this.category,
    required this.price,
    required this.stock,
    required this.desc,
    required this.storename,
    required this.storeid,
    required this.id,
    required this.status,
    required this.pimage,
    required this.carouselImg,
    required this.points,
    required this.totalrating,
    required this.ratingCount,
    required this.quantity,
  });

  CartData copyWith({
    String? productName,
    String? category,
    String? price,
    String? stock,
    String? desc,
    String? storename,
    String? storeid,
    String? id,
    String? status,
    String? pimage,
    List<String>? carouselImg,
    int? points,
    dynamic totalrating,
    String? ratingCount,
    int? quantity,
  }) {
    return CartData(
      productName: productName ?? this.productName,
      category: category ?? this.category,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      desc: desc ?? this.desc,
      storename: storename ?? this.storename,
      storeid: storeid ?? this.storeid,
      id: id ?? this.id,
      status: status ?? this.status,
      pimage: pimage ?? this.pimage,
      carouselImg: carouselImg ?? this.carouselImg,
      points: points ?? this.points,
      totalrating: totalrating ?? this.totalrating,
      ratingCount: ratingCount ?? this.ratingCount,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        productName,
        category,
        price,
        stock,
        desc,
        storename,
        storeid,
        id,
        status,
        pimage,
        carouselImg,
        points,
        totalrating,
        ratingCount,
        quantity,
      ];
}
