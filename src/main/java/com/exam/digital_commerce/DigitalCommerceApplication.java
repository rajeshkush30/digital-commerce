package com.exam.digital_commerce;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DigitalCommerceApplication {

	public static void main(String[] args) {
		SpringApplication.run(DigitalCommerceApplication.class, args);
		
		System.out.println("DigitalCommerceApplication for testing CI/CD Pipeline with Jenkins");
	}

}
