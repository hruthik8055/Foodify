package com.food.model;

public class ContactMessage {

    private int contactId;
    private int userId;
    private String name;
    private String email;
    private String category;
    private String subject;
    private String message;

    public ContactMessage() {
    }

    public ContactMessage(int userId, String name, String email,
                          String category, String subject, String message) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.category = category;
        this.subject = subject;
        this.message = message;
    }

    public int getContactId() {
        return contactId;
    }

    public void setContactId(int contactId) {
        this.contactId = contactId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}