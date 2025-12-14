package org.example.model;

public class CartItem {

    private Product product;
    private int quantity;

    // Constructeur principal
    public CartItem(Product product) {
        this.product = product;
        this.quantity = 1; // Quantité par défaut
    }

    // Getter et Setter pour le produit
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    // Getter pour la quantité
    public int getQuantity() {
        return quantity;
    }

    // Incrémenter la quantité
    public void increment() {
        this.quantity++;
    }

    // Décrémenter la quantité (minimum 1)
    public void decrement() {
        if (quantity > 1) {
            this.quantity--;
        }
    }

    // Définir une nouvelle quantité
    public void setQuantity(int newQuantity) {
        if (newQuantity > 0) {
            this.quantity = newQuantity;
        }
    }

    public double getPrice() {
        return product.isPromo() ? product.getPromoPrice() : product.getPrice();
    }
}
