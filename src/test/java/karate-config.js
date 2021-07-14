function fn(){
    var env = karate.env;
    if(!env) {
        env = "dev";
    };
    karate.log("karate environment system property is: ", env);
    var config = {
        apiUrl: "https://petstore.swagger.io/"
    };

    return config;
}