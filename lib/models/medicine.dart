class Medicine {
  final int? id;
  final String name;
  final String dosage;
  final String time; // Format: "HH:mm"
  final String? voicePath; // रिकॉर्ड की गई आवाज़ का पाथ

  Medicine({
    this.id,
    required this.name,
    required this.dosage,
    required this.time,
    this.voicePath,
  });

  // Database में सेव करने के लिए Map में बदलें
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'time': time,
      'voicePath': voicePath,
    };
  }

  // Database से निकालने के लिए Map से Object बनाएं
  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'],
      name: map['name'],
      dosage: map['dosage'],
      time: map['time'],
      voicePath: map['voicePath'],
    );
  }
}
