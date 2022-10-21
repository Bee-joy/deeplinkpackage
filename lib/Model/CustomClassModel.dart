class CustomClassModel {
  String title;
  String description;
  String hintText;
  String fieldTitle;
  String nextFormTitle;
  bool? editOption = false;
  bool? phoneTextfield = false;
  bool? showPolicy = true;

  CustomClassModel(this.title, this.description, this.hintText, this.fieldTitle,
      this.nextFormTitle,
      {this.editOption, this.phoneTextfield, this.showPolicy});
}
