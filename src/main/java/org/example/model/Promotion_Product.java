package org.example.model;

public class Promotion_Product {
    private  int promotionId;
    private  int productId;
    public Promotion_Product(int promotionId, int productId) {
        this.promotionId = promotionId;
        this.productId = productId;
    }
    public int getPromotionId() {
        return promotionId;
    }
    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;

    }
    public int getProductId() {
        return productId;}
    public void setProductId(int productId) {
        this.productId = productId; }
}
