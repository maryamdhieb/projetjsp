package org.example.service;

import org.example.model.Product;
import org.example.model.Promotion;
import org.example.repository.PromotionRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class PromotionService {

    private final PromotionRepository repo = new PromotionRepository();

    public List<Promotion> getAllPromotions() {
        return repo.getAllPromotions();
    }

    public List<Promotion> getActivePromotions() {
        return getAllPromotions().stream()
                .filter(Promotion::isActive)
                .collect(Collectors.toList());
    }

    public void addPromotionWithProducts(Promotion promo, String[] productIdsArray) {
        int promoId = repo.addPromotionAndReturnId(promo);

        if (promoId != -1 && productIdsArray != null && productIdsArray.length > 0) {
            List<Integer> productIds = new ArrayList<>();
            for (String idStr : productIdsArray) {
                try {
                    productIds.add(Integer.parseInt(idStr));
                } catch (NumberFormatException ignored) {}
            }
            repo.linkPromotionToProducts(promoId, productIds);
        }
    }

    public boolean isProductInPromotion(int productId, int promotionId) {
        String sql = "SELECT COUNT(*) FROM product_promotion WHERE product_id = ? AND promotion_id = ?";
        try (var conn = org.example.DBConnection.getConnection();
             var ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, promotionId);
            try (var rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hasActivePromotion(Product product, List<Promotion> activePromotions) {
        return activePromotions.stream()
                .anyMatch(promo -> isProductInPromotion(product.getId(), promo.getId()));
    }

    public double getPromoPrice(Product product, List<Promotion> activePromotions) {
        return activePromotions.stream()
                .filter(promo -> isProductInPromotion(product.getId(), promo.getId()))
                .mapToDouble(promo -> product.getPrice() * (1 - promo.getValue() / 100))
                .min()
                .orElse(product.getPrice());

    }

    public void deletePromotion(int id) {
        repo.deletePromotion(id);
    }

    public void updatePromotionWithProducts(Promotion promo, String[] productIdsArray) {
        List<Integer> productIds = new ArrayList<>();
        if (productIdsArray != null) {
            for (String idStr : productIdsArray) {
                try {
                    productIds.add(Integer.parseInt(idStr));
                } catch (NumberFormatException ignored) {}
            }
        }
        repo.updatePromotionWithProducts(promo, productIds);
    }

    public List<Product> getProductsForPromotion(int promotionId) {
        return repo.getProductsForPromotion(promotionId);
    }

    public void applyPromotion(Product product) {

        Promotion promo = repo.findActivePromotionByProduct(product.getId());

        if (promo != null && promo.isActive()) {

            double promoPrice = product.getPrice();

            if ("PERCENTAGE".equalsIgnoreCase(promo.getType())) {
                promoPrice -= product.getPrice() * promo.getValue() / 100;
            } else if ("FIXED".equalsIgnoreCase(promo.getType())) {
                promoPrice -= promo.getValue();
            }

            if (promoPrice < 0) promoPrice = 0;

            product.setPromoPrice(promoPrice);
        }
    }
}