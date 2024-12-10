package entity;

import javax.persistence.*;

@Entity
@Table(name = "user_donation")
public class UserDonation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "created")
    private String created;

    @Column(name = "money")
    private int money;

    @Column(name = "name")
    private String name;

    @Column(name = "status")
    private int status;

    @Column(name = "text")
    private String text;

    @ManyToOne(cascade = { 
			CascadeType.PERSIST, 
			CascadeType.REFRESH, 
			CascadeType.MERGE, 
			CascadeType.DETACH })
    @JoinColumn(name = "donation_id")
    private Donation donation;

    @ManyToOne(cascade = { 
			CascadeType.PERSIST, 
			CascadeType.REFRESH, 
			CascadeType.MERGE, 
			CascadeType.DETACH })
    @JoinColumn(name = "user_id")
    private User user;
    
    //Contructor
    public UserDonation() {	}
    
    // Getters N setters	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Donation getDonation() {
		return donation;
	}

	public void setDonation(Donation donation) {
		this.donation = donation;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

    
    
}

