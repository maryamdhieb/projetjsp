package org.example.model;

public class Order {
    private int id;
    private int userId;
    private String nom;
    private String prenom;
    private String adresse;
    private String ville;
    private String telephone;
    private String paiement;
    private double total;
    public Order() {


    }
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getNom() { return nom; }
    public String getPrenom() { return prenom; }
    public String getAdresse() { return adresse; }
    public String getVille() { return ville; }
    public String getTelephone() { return telephone; }
    public String getPaiement() { return paiement; }
    public double getTotal() { return total; }


    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public void setPaiement(String paiement) {
        this.paiement = paiement;
    }

    public void setTotal(double total) {
        this.total = total;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }

}
