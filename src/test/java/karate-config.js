function fn() {
    var env = karate.env;
    if (!env) {
        env = "prod-pet";
    };
    karate.log("karate environment system property is: ", env);
    var config = {};
    if (env == 'prod-pet') {
        config.environment = karate.call('classpath:core/environment/config-' + env + '.js');
    }
    config.constants = karate.call('classpath:core/constants/constants.js');
    return config;
}