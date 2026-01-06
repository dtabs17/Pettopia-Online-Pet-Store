package pettopia.com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pettopia.com.entities.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {

}
