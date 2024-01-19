// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartDataAdapter extends TypeAdapter<CartData> {
  @override
  final int typeId = 0;

  @override
  CartData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartData(
      productName: fields[0] as String,
      category: fields[1] as String,
      price: fields[2] as String,
      stock: fields[3] as String,
      desc: fields[4] as String,
      storename: fields[5] as String,
      storeid: fields[6] as String,
      id: fields[7] as String,
      status: fields[8] as String,
      pimage: fields[9] as String,
      carouselImg: (fields[10] as List).cast<String>(),
      points: fields[11] as int,
      totalrating: fields[12] as dynamic,
      ratingCount: fields[13] as String,
      quantity: fields[14] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, CartData obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.stock)
      ..writeByte(4)
      ..write(obj.desc)
      ..writeByte(5)
      ..write(obj.storename)
      ..writeByte(6)
      ..write(obj.storeid)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.pimage)
      ..writeByte(10)
      ..write(obj.carouselImg)
      ..writeByte(11)
      ..write(obj.points)
      ..writeByte(12)
      ..write(obj.totalrating)
      ..writeByte(13)
      ..write(obj.ratingCount)
      ..writeByte(14)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
