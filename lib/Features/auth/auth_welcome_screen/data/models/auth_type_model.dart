import '../../../../../core/utils/assets.dart';

class AuthTypeModel {
  final String title;
  final String iconPath;

  AuthTypeModel({required this.title, required this.iconPath});
}

final List<AuthTypeModel> authTypes = [
  AuthTypeModel(title: 'Apple', iconPath: AssetsData.apple),
  AuthTypeModel(title: 'Google', iconPath: AssetsData.google),
  AuthTypeModel(title: 'Snapchat', iconPath: AssetsData.snapchat),
  AuthTypeModel(title: 'Facebook', iconPath: AssetsData.facebook),
];
