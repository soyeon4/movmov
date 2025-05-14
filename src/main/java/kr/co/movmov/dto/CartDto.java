package kr.co.movmov.dto;

import java.util.List;

import kr.co.movmov.vo.ShopCartItem;

public class CartDto {
	
	private List<ShopCartItem> cartItems;
	
	public CartDto(List<ShopCartItem> cartItems) {
		this.cartItems = cartItems;
	}
	
	public boolean isEmpty() {
		return cartItems.isEmpty();
	}
	
	// getter
	public List<ShopCartItem> getItems() {
		return cartItems;
	}
	
	public int getTotalItemPrice() {
		int totalItemPrice = 0;
		
		for (ShopCartItem item : cartItems) {
			totalItemPrice += item.getItem().getPrice()*item.getQuantity();
		}
		return totalItemPrice;
	}
	
	public int getDeliveryFee() {
		int deliveryFee = 3000;
		int totalItemPrice = getTotalItemPrice();
		if (totalItemPrice >= 30000) {
			deliveryFee = 0;
		}
		
		return deliveryFee;
	}
	
	public int getTotalOrderPrice() {
		int totalOrderPrice = getTotalItemPrice() + getDeliveryFee();
		
		return totalOrderPrice;
	}
	
	
}
