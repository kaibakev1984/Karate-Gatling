package utils;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

import java.util.Random;

public class DataGenerator {
    public static String getRandomEmail() {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername() {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    // Create Random Data for JSON
    public static JSONObject getRandomArticleValues() {
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }

    public static JSONObject getRandomPetValues() {
        Faker faker = new Faker();
        Random random = new Random();
        int id = random.nextInt(9999);
        String category = faker.rickAndMorty().location();
        String name = faker.rickAndMorty().character();
        JSONObject json = new JSONObject();
        json.put("id", id);
        json.put("idString", Integer.toString(id));
        json.put("category", category);
        json.put("name", name);
        return json;
    }
}
