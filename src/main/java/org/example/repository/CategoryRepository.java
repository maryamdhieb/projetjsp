package org.example.repository;
import org.example.model.Category;
import org.example.model.Product;

import java.util.ArrayList;
import java.util.List;
public class CategoryRepository {

    private static List<Category> categories = new ArrayList<>(List.of(

            new Category(1, "Sports Equipment", "Équipements pour différents sports",
                    "assets/img/accessoire.jpg", // image catégorie
                    new ArrayList<>(List.of(
                            new Product(1, "Tapis de yoga", 49.99 ,"Tapis antidérapant pour yoga et pilates", 45 ,
                                    "https://images.unsplash.com/photo-1599058917212-5aef8b64b3b4" , true , 4 , 555),
                            new Product(2, "Haltères réglables", 89.99, "Haltères pour la musculation à domicile",67,
                                    "https://images.unsplash.com/photo-1599955421446-b1f8c0d68b50" , true , 5 , 321),
                            new Product(3, "Balles de fitness", 19.99, "Balles pour exercices de renforcement musculaire", 4,
                                    "https://images.unsplash.com/photo-1605296867304-46d5465a13f1" , true , 3 , 213)
                    ))
            ),
            new Category(2, "Vêtements de sport", "Tenues confortables et techniques pour le sport",
                    "assets/img/vetement.jpg",
                    new ArrayList<>(List.of(
                            new Product(4, "T-shirt de running", 29.99, "T-shirt léger et respirant pour la course",0,
                                    "https://images.unsplash.com/photo-1597262975002-c5c3b14bbd62", false , 0 , 0),
                            new Product(5, "Short de sport", 24.99, "Short confortable pour toutes activités sportives",22,
                                    "https://images.unsplash.com/photo-1600180758895-2f4a5f2c4072" , false , 0 , 0),
                            new Product(6, "Legging de sport", 39.99, "Legging extensible et respirant pour femmes",33,
                                    "https://images.unsplash.com/photo-1584467735877-ecbba8d6dc6e" , true , 4 , 112)
                    ))
            ),
            new Category(3, "Chaussures", "Chaussures adaptées à différents sports",
                    "assets/img/chaussure.jpg",
                    new ArrayList<>(List.of(
                            new Product(7, "Chaussures de running", 89.99, "Chaussures légères pour course sur route",12,
                                    "https://images.unsplash.com/photo-1598966734936-1f4e0b9d22d5" , false , 0 , 0),
                            new Product(8, "Chaussures de fitness", 79.99, "Chaussures polyvalentes pour salle de sport",0,
                                    "https://images.unsplash.com/photo-1583225156763-0d7b0e2143f4" , true , 5 , 432),
                            new Product(9, "Chaussures de randonnée", 120.00, "Chaussures résistantes pour randonnées",8,
                                    "https://images.unsplash.com/photo-1504457040317-3e71b52b25de" , true , 4 , 256)
                    ))
            ),
            new Category(4, "Accessoires", "Accessoires pour améliorer vos performances sportives",
                    "assets/img/acc.jpg",
                    new ArrayList<>(List.of(
                            new Product(10, "Bouteille d'eau", 14.99, "Bouteille réutilisable pour rester hydraté",44,
                                    "https://images.unsplash.com/photo-1589923188900-55d9f4a0a3a3" , true , 5 , 678),
                            new Product(11, "Sac de sport", 49.99, "Sac spacieux pour transporter vos affaires",100,
                                    "https://images.unsplash.com/photo-1574169208507-84376164871b" , false , 0 , 0),
                            new Product(12, "Corde à sauter", 12.99, "Corde à sauter pour cardio et coordination",20,
                                    "https://images.unsplash.com/photo-1588891231473-1a174af3ee41" , false , 0 , 0)
                    ))
            )

    ));


    public CategoryRepository() {

    }

    public List<Category> getAllCategories() {
        return categories;
    }
    // Ajouter une catégorie
    public void addCategory(Category category) {
        categories.add(category);
    }

    // Supprimer une catégorie par id
    public void deleteCategory(int id) {
        categories.removeIf(c -> c.getId() == id);
    }

    // Modifier une catégorie par id
    public boolean updateCategory(int id, Category updatedCategory) {
        for (Category c : categories) {
            if (c.getId() == id) {
                c.setName(updatedCategory.getName());
                c.setDescription(updatedCategory.getDescription());
                if (updatedCategory.getImageUrl() != null) {
                    c.setImageUrl(updatedCategory.getImageUrl());
                }
                return true; // succès
            }
        }
        return false; // catégorie non trouvée
    }

}
