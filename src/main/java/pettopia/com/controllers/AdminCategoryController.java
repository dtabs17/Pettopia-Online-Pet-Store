package pettopia.com.controllers;

import org.springframework.web.bind.annotation.*;
import pettopia.com.entities.Category;
import pettopia.com.repositories.CategoryRepository;

import java.util.List;

@RestController
@RequestMapping("/api/admin/categories")
public class AdminCategoryController {

    private final CategoryRepository categoryRepository;

    public AdminCategoryController(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @GetMapping
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }
}
