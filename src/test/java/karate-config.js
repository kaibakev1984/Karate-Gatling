function fn(){
    var env = karate.env;
    if(!env) {
        env = "dev";
    };
    karate.log("karate environment system property is: ", env);
    var config = {
        apiUrl: "https://conduit.productionready.io/api/",
        petUrl: "https://petstore.swagger.io/"
    };

    if (env == 'dev') {
        config.userEmail = 'karate@test.com'
        config.userPassword = 'karate123'
    };

    if (env == 'qa') {
        config.userEmail = 'karate2@test.com'
        config.userPassword = 'Karate456'
    };
    // --- conduit config ---
   // var accessToken = karate.callSingle('classpath:utils/reusable_steps/create-token.feature', config).authToken;
   // karate.configure('headers', {Authorization: 'Token ' + accessToken});
    return config;
}