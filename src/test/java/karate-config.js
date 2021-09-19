function fn() {
    var env = karate.env;
    if (!env) {
        env = "prod";
    };
    karate.log("karate environment system property is: ", env);
    var config = {};

    if (env == 'dev') {
        apiUrl: "https://conduit.productionready.io/api/",
        config.userEmail = 'karate@test.com'
        config.userPassword = 'karate123'
    }

    if (env == 'qa') {
        apiUrl: "https://conduit.productionready.io/api/",
        config.userEmail = 'karate2@test.com'
        config.userPassword = 'Karate456'
    }

    if (env == 'prod') {
        apiUrl: "https://conduit.productionready.io/api/",
        config.userEmail = 'kvasquez@test.com'
        config.userPassword = 'Karate123'
    }

    // --- conduit config ---
    var accessToken = karate.callSingle('classpath:utils/reusable_steps/create-token.feature', config).authToken;
    karate.configure('headers', {
        Authorization: 'Token ' + accessToken
    });
    return config;
}