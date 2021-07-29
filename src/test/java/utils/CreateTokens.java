package utils;

import com.intuit.karate.Runner;
import org.apache.commons.collections.map.HashedMap;

import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class CreateTokens {
    private static final ArrayList<String> tokens = new ArrayList<>();
    private static final AtomicInteger counter = new AtomicInteger();

    private  static String[] emails = {
            "kardemo1@test.com",
            "kardemo2@test.com",
            "kardemo3@test.com"
    };

    public static String getNextToken() {
        return tokens.get(counter.getAndIncrement() % tokens.size());
    }

    public static void createAccessTokens() {
        for(String email: emails) {
            Map<String, Object> account = new HashedMap();
            account.put("userEmail", email);
            account.put("userPassword", "Welcome1");
            Map<String, Object> result = Runner.runFeature("classpath:utils/reusable_steps/create-token.feature", account, true);
            tokens.add(result.get("authToken").toString());
        }
    }
}
