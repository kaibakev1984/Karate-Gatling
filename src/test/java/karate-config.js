function fn() {
    var env = karate.env;
    if (!env) {
        env = "prod-pet";
    };
    karate.log("karate environment system property is: ", env);
    var config = {};
    if (env == 'prod-pet') {
        config.apiUrl = "https://petstore.swagger.io/";
        config.apiVersion = "v2";
        config.environment = karate.call('classpath:core/environment/config-' + env + '.js');
    }
    return config;
}