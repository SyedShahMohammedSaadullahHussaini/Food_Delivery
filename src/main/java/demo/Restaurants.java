package demo;

public class Restaurants {
    private String name;
    private String imageUrl;
    private String cuisine;
    private String price;
    private String time;
    private String rating;
    private String offer;
    private boolean promoted;
	public Restaurants(String name, String imageUrl, String cuisine, String price, String time, String rating,
			String offer, boolean promoted) {
		super();
		this.name = name;
		this.imageUrl = imageUrl;
		this.cuisine = cuisine;
		this.price = price;
		this.time = time;
		this.rating = rating;
		this.offer = offer;
		this.promoted = promoted;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getCuisine() {
		return cuisine;
	}
	public void setCuisine(String cuisine) {
		this.cuisine = cuisine;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getOffer() {
		return offer;
	}
	public void setOffer(String offer) {
		this.offer = offer;
	}
	public boolean isPromoted() {
		return promoted;
	}
	public void setPromoted(boolean promoted) {
		this.promoted = promoted;
	}

   
}

