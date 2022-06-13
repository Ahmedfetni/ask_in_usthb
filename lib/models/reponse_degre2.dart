class ReponseDegre2 {
  String id;
  String text;
  int vote;
  String date;
  String nomUtilisateur;

  ReponseDegre2({
    required this.id,
    required this.nomUtilisateur,
    required this.text,
    this.vote = 0,
    required this.date,
  });

  String get getText => text;
  String get getNomUtilisateur => nomUtilisateur;
  int get getVote => vote;
  String get getDate => date;

  void plusVote() {
    vote++;
  }

  void moinsVote() {
    vote--;
  }
}
