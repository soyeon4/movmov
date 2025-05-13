package kr.co.movmov.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.ShopCartItem;
import kr.co.movmov.vo.ShopItemOption;

public interface ShopCartItemMapper {
	
	void updateCartItemOption(@Param("userId") String userId, 
							@Param("itemNo") int itemNo, 
							@Param("optionNo") int optionNo);
	
	/**
	 * 사용자 아이디와 상품 아이디를 전달받아 장바구니에 추가
	 * @param itemNo
	 */
	void insertCartItem(@Param("userId") String userId, @Param("itemNo") int itemNo);
	
	/**
	 * 장바구니 번호로 장바구니에서 상품 삭제
	 * @param itemNo
	 */
	void deleteCartItemByCartNo(int cartNo);

	/**
	 * 해당 사용자의 장바구니 비우기
	 * @param userId
	 */
	void deleteCartItemByUserId(String userId);
	
	/**
	 * 사용자 아이디로 장바구니 상품리스트 조회
	 * @param userId 
	 * @return
	 */
	List<ShopCartItem> getCartItemsByUserId(String userId);
	

	/**
	 * 장바구니 번호로 상품 상세정보 조회
	 * @param id 장바구니 번호
	 * @return 상품 상세정보
	 */
//	ShopCartItem getCartItemById(int cartNo);
	
}
