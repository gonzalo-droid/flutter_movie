

class Cast{
  List<Actor> actors =new List();
  Cast();
  Cast.fromJsonList(List<dynamic> jsonList){

   if(jsonList == null ) return ;

    jsonList.forEach((item) {
      final actor = new Actor.fromJsonMap(item);
      actors.add(actor);
    });
  }
}



class Actor {
  bool adult;
  int gender;
  int id;
  Department knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  Department department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

   Actor.fromJsonMap(Map<String, dynamic> json){

    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    // knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];

  }


  getPhoto(){

    if(profilePath == null){
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9hGlyysBiE-h2e6dQLPVf95r8cqePaOdicw&usqp=CAU';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}

enum Department { DIRECTING, ACTING, PRODUCTION, CAMERA, WRITING, SOUND, ART, COSTUME_MAKE_UP, CREW, LIGHTING, EDITING }
