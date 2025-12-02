package org.example.service;

import org.example.model.Promotion;
import org.example.repository.PromotionRepository;

import java.util.List;
import java.util.stream.Collectors;

public class PromotionService {

    private PromotionRepository repo = new PromotionRepository();

    public List<Promotion> getActivePromotions() {
        return repo.getAllPromotions().stream()
                .filter(Promotion::isActive)
                .collect(Collectors.toList());
    }

    public List<Promotion> getAllPromotions() {
        return repo.getAllPromotions();
    }

    public void addPromotion(Promotion p) {
        repo.addPromotion(p);
    }

    public int getNextId() {
        return repo.getNextId();
    }
}
