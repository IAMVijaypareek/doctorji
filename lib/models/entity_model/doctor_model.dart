class Doctor {
  String name;
  String img;
  String qualification;
  int experience;
  String expert;
  String city;
  String uid;

  Doctor(
      {this.name,
      this.img,
      this.qualification,
      this.experience,
      this.expert,
      this.city,
       this.uid
      });

  Map toMap(Doctor doctor) {
    var map = Map();
    map['name'] = doctor.name;
    map['img'] = doctor.img;
    map['qualification'] = doctor.qualification;
    map['experience'] = doctor.experience;
    map['city'] = doctor.city;
    map['uid'] =doctor.uid;
    return map;
  }

  Doctor.fromMap(Map mapdata) {
    this.name = mapdata['name'];
    this.img = mapdata['img'];
    this.qualification = mapdata['qualification'];
    this.experience = mapdata['experience'];
    this.expert = mapdata['expert'];
    this.city = mapdata['city'];
    this.uid =mapdata['uid'];
  }
}



