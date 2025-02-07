enum AppFont { poppinsRegular, poppinsSemiBold, poppinsLight }

extension FontExt on AppFont {
  String get value {
    switch (this) {
      case AppFont.poppinsRegular:
        return "Poppins";
      case AppFont.poppinsSemiBold:
        return "PoppinsSemibold";
      default:
        return "PoppinsLight";
    }
  }
}

extension AssetPathEx on String {
  String path() {
    if (!endsWith(".svg") &&
        !endsWith(".json") &&
        !endsWith(".webp") &&
        !endsWith(".png")) throw "Invalid Icon";
    String assetPath = "assets/images";

    return "$assetPath$this";
  }
}