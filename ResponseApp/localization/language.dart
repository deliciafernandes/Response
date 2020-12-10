class Language {
  final int id;
  // final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "English", "en"),
      Language(4, "हिंदी", "hi"),
      Language(7, "मराठी", "mr"),
    ];
  }
}
