enum TextFormFieldType {
  number,
  command;

  bool get isNumber => this == number;
  bool get isCommand => this == command;
}
