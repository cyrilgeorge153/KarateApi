package com.tests;

import com.github.javafaker.Faker;

public class faker {

    public static String fakeName()
    {
        Faker faker = new Faker();
        return faker.name().firstName();
    }
    public static String fakeJob()
    {
        Faker faker = new Faker();
        return faker.job().title();
    }
}
