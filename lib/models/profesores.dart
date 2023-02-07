// To parse this JSON data, do
//
//     final profesor = profesorFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Profesor {
    Profesor({
         this.dias,
         this.imagen,
    });

    Dias? dias;
    String? imagen;

    factory Profesor.fromRawJson(String str) => Profesor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Profesor.fromJson(Map<String, dynamic> json) => Profesor(
        dias: Dias.fromJson(json["dias"]),
        imagen: json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "dias": dias!.toJson(),
        "imagen": imagen,
    };
      Map<String, dynamic> toMap() => {
        "dias": dias!.toJson(),
        "imagen": imagen,
    };
}

class Dias {
    Dias({
        required this.jueves,
        required this.lunes,
        required this.martes,
        required this.miercoles,
        required this.viernes,
    });

    Jueves jueves;
    Jueves lunes;
    Jueves martes;
    Jueves miercoles;
    Jueves viernes;

    factory Dias.fromRawJson(String str) => Dias.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dias.fromJson(Map<String, dynamic> json) => Dias(
        jueves: Jueves.fromJson(json["jueves"]),
        lunes: Jueves.fromJson(json["lunes"]),
        martes: Jueves.fromJson(json["martes"]),
        miercoles: Jueves.fromJson(json["miercoles"]),
        viernes: Jueves.fromJson(json["viernes"]),
    );

    Map<String, dynamic> toJson() => {
        "jueves": jueves.toJson(),
        "lunes": lunes.toJson(),
        "martes": martes.toJson(),
        "miercoles": miercoles.toJson(),
        "viernes": viernes.toJson(),
    };
}

class Jueves {
    Jueves({
        required this.materias,
    });

    Materias materias;

    factory Jueves.fromRawJson(String str) => Jueves.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Jueves.fromJson(Map<String, dynamic> json) => Jueves(
        materias: Materias.fromJson(json["materias"]),
    );

    Map<String, dynamic> toJson() => {
        "materias": materias.toJson(),
    };
}

class Materias {
    Materias({
        required this.materia1,
        required this.materia2,
        required this.materia3,
    });

    Materia materia1;
    Materia materia2;
    Materia materia3;

    factory Materias.fromRawJson(String str) => Materias.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Materias.fromJson(Map<String, dynamic> json) => Materias(
        materia1: Materia.fromJson(json["materia1"]),
        materia2: Materia.fromJson(json["materia2"]),
        materia3: Materia.fromJson(json["materia3"]),
    );

    Map<String, dynamic> toJson() => {
        "materia1": materia1.toJson(),
        "materia2": materia2.toJson(),
        "materia3": materia3.toJson(),
    };
}

class Materia {
    Materia({
        required this.alumnos,
        required this.carrera,
        required this.horaFin,
        required this.horaIni,
        required this.laboratorio,
        required this.malla,
        required this.materia,
        required this.temas,
    });

    int alumnos;
    String? carrera;
    int horaFin;
    int horaIni;
    String laboratorio;
    String? malla;
    String materia;
    Temas temas;

    factory Materia.fromRawJson(String str) => Materia.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Materia.fromJson(Map<String, dynamic> json) => Materia(
        alumnos: json["alumnos"],
        carrera: json["carrera"],
        horaFin: json["horaFin"],
        horaIni: json["horaIni"],
        laboratorio: json["laboratorio"],
        malla: json["malla"],
        materia: json["materia"],
        temas: Temas.fromJson(json["temas"]),
    );

    Map<String, dynamic> toJson() => {
        "alumnos": alumnos,
        "carrera": carrera,
        "horaFin": horaFin,
        "horaIni": horaIni,
        "laboratorio": laboratorio,
        "malla": malla,
        "materia": materia,
        "temas": temas.toJson(),
    };
}

enum Carrera { COMPUTACIN, EMPTY, SISTEMAS }

final carreraValues = EnumValues({
    "Computación": Carrera.COMPUTACIN,
    "": Carrera.EMPTY,
    "Sistemas": Carrera.SISTEMAS
});

enum Malla { REAJUSTE, EMPTY, REDISEO }

final mallaValues = EnumValues({
    "": Malla.EMPTY,
    "Reajuste": Malla.REAJUSTE,
    "Rediseño": Malla.REDISEO
});

class Temas {
    Temas({
        required this.unidad1,
        required this.unidad2,
        required this.unidad3,
        required this.unidad4,
    });

    Unidad unidad1;
    Unidad unidad2;
    Unidad unidad3;
    Unidad unidad4;

    factory Temas.fromRawJson(String str) => Temas.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Temas.fromJson(Map<String, dynamic> json) => Temas(
        unidad1: Unidad.fromJson(json["Unidad1"]),
        unidad2: Unidad.fromJson(json["Unidad2"]),
        unidad3: Unidad.fromJson(json["Unidad3"]),
        unidad4: Unidad.fromJson(json["Unidad4"]),
    );

    Map<String, dynamic> toJson() => {
        "Unidad1": unidad1.toJson(),
        "Unidad2": unidad2.toJson(),
        "Unidad3": unidad3.toJson(),
        "Unidad4": unidad4.toJson(),
    };
}

class Unidad {
    Unidad({
        required this.objetivos,
        required this.tema,
    });

    String objetivos;
    String? tema;

    factory Unidad.fromRawJson(String str) => Unidad.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Unidad.fromJson(Map<String, dynamic> json) => Unidad(
        objetivos: json["objetivos"],
        tema: json["tema"],
    );

    Map<String, dynamic> toJson() => {
        "objetivos": objetivos,
        "tema": tema,
    };
}

enum Tema { EMPTY, INTRODUCCIN_A_LAS_PLATAFORMAS_MVILES, ARQUITECTURA_DE_APLICACIONES_MVILES, LENGUAJES_DE_PROGRAMACIN_NATIVOS, LENGUAJES_DE_PROGRAMACIN_MULTIPLATAFORMA }

final temaValues = EnumValues({
    "Arquitectura de aplicaciones móviles.": Tema.ARQUITECTURA_DE_APLICACIONES_MVILES,
    "": Tema.EMPTY,
    "Introducción a las plataformas móviles.": Tema.INTRODUCCIN_A_LAS_PLATAFORMAS_MVILES,
    "Lenguajes de programación multiplataforma.": Tema.LENGUAJES_DE_PROGRAMACIN_MULTIPLATAFORMA,
    "Lenguajes de programación nativos.": Tema.LENGUAJES_DE_PROGRAMACIN_NATIVOS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
