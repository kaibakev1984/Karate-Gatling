function fn() {
    var env = karate.env;
    if (!env) {
        env = "prod";
    };
    karate.log("karate environment system property is: ", env);
    var config = {};
    return config;
}