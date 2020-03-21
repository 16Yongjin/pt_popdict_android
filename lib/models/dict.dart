class Dict {
  String entry;
  String pron;
  List<Mean> means;

  Dict({this.entry, this.pron, this.means});

  Dict.fromJson(Map<String, dynamic> json) {
    entry = json['entry'];
    pron = json['pron'];
    if (json['means'] != null) {
      means = new List<Mean>();
      json['means'].forEach((v) {
        means.add(new Mean.fromJson(v));
      });
    }
  }
}

class Mean {
  String mean;
  String part;

  Mean({this.mean, this.part});

  Mean.fromJson(Map<String, dynamic> json) {
    mean = json['mean'];
    part = json['part'];
  }
}
