package org.example.repository;

import org.example.model.Promotion;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


public class PromotionRepository {

    private static List<Promotion> promotions = new ArrayList<>(List.of(
            new Promotion(1, "Promo de Noël", "Réduction 20% sur tous les produits",
                    "percentage", 20,
                    LocalDate.of(2025, 12, 1),
                    LocalDate.of(2025, 12, 25))
    ));

    public List<Promotion> getAllPromotions() {
        return promotions;
    }

    public void addPromotion(Promotion promo) {
        promotions.add(promo);
    }

    public void deletePromotion(int id) {
        promotions.removeIf(p -> p.getId() == id);
    }

    public int getNextId() {
        return promotions.stream().mapToInt(Promotion::getId).max().orElse(0) + 1;
    }
}
