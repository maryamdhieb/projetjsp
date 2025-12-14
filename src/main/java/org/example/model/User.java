package org.example.model;

public class User {
    private int id;
    private String email;
    private String password;
    private String fullname;
    private String role;

    public User(String email, String password , String fullname , String role) {

        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.role = role;
    }

  //  public User(String email, String password, String fullname) {
     //   this(email, password);
     //   this.fullname = fullname;
    //}

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }


    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
}
