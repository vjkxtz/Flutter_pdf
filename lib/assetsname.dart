class Assetsname {
  final String linename;
  final String description;
  final List line;


  const Assetsname(
      {
    this.linename,
    this.description,
    this.line,
      }
  );
}

final assetsname = [
  new Assetsname(
    linename: "12M",
    description: "Powder coating line, select manual",
    line: ["rog.pdf", "del.pdf"]
  ),
  new Assetsname(
    linename: "9M",
    description: "Powder coating line, select manual",
    line: ["del.pdf"]
  ),
  new Assetsname(
    linename: "FPL",
    description: "Powder coating line, select manual",
    line: ["del.pdf"]
  ),
  new Assetsname(
    linename: "GX",
    description: "Gasperini rollformer, select manual",
    line: ["del.pdf"]
  ),
  new Assetsname(
    linename: "CATWALK",
    description: "Gasperini rollformer, select manual",
    line: ["del.pdf"]
  ),

];
