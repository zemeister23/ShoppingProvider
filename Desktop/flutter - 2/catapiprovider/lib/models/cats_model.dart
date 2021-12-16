class Cat {
    Cat({
        this.description,
        this.imageUrl,
        this.statusCode,
    });

    String? description;
    String? imageUrl;
    int? statusCode;

    factory Cat.fromJson(Map<String, dynamic> json) => Cat(
        description: json["description"],
        imageUrl: json["imageUrl"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "imageUrl": imageUrl,
        "statusCode": statusCode,
    };
}
