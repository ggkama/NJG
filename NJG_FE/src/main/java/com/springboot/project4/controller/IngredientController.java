package com.springboot.project4.controller;

import com.springboot.project4.data.Ingredient;
import com.springboot.project4.service.IngredientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class IngredientController {

    private final IngredientService ingredientService;

    @Autowired
    public IngredientController(IngredientService ingredientService) {
        this.ingredientService = ingredientService;
    }

    @GetMapping("/show/{id}")
    public Ingredient getContentById(@PathVariable Long id) {
        return ingredientService.findById(id);
    }
}
