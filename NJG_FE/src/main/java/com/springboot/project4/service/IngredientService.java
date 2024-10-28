package com.springboot.project4.service;

import com.springboot.project4.data.Ingredient;
import com.springboot.project4.repository.IngredientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IngredientService {

    private final IngredientRepository ingredientRepository;

    @Autowired
    public IngredientService(IngredientRepository ingredientRepository) {
        this.ingredientRepository = ingredientRepository;
    }

    public Ingredient findById(Long id) {
        // YourContentRepository를 사용하여 ID에 해당하는 내용을 데이터베이스에서 조회
        return ingredientRepository.findById(id).orElse(null);
    }
}
