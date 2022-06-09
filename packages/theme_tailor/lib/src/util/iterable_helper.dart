import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

const coreIterableTypeChecker = TypeChecker.fromUrl('dart:core#Iterable');
const coreListTypeChecker = TypeChecker.fromUrl('dart:core#List');
const coreSetTypeChecker = TypeChecker.fromUrl('dart:core#Set');

DartType coreIterableGenericType(DartType type) =>
    type.typeArgumentsOf(coreIterableTypeChecker)!.single;
