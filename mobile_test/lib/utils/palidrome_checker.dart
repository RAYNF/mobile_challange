bool checkPalidrom(String text) {
  String clean = text.toLowerCase().replaceAll(" ", "");
  String reverse = clean.split("").reversed.join("");

  return clean == reverse;
}
