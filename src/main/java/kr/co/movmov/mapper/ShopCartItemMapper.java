package kr.co.movmov.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.ShopCartItem;
import kr.co.movmov.vo.ShopItemOption;

public interface ShopCartItemMapper {
	
	/**
	 * 장바구니 상품 옵션 정보 등록
	 * @param userId 사용자 아이디
	 * @param itemNo 상품 번호
	 * @param optionNo 옵션 번호
	 */
	void updateCartItemOption(@Param("userId") String userId, 
							@Param("itemNo") int itemNo, 
							@Param("optionNo") int optionNo);
	
	/**
	 * 장바구니 상품 수량 정보 수정
	 * @param userId 사용자 아이디
	 * @param itemNo 상품 번호
	 * @param quantity 수량
	 */
	void updateCartItemQuantity(@Param("userId") String userId, 
							@Param("itemNo") int itemNo, 
							@Param("quantity") int quantity);
	
	
	
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
	 * 필요한 상품 정보 조회
	 * @param userId 사용자 아이디
	 * @param itemNo 상품 번호
	 * @param optionNo 옵션 번호
	 * @return
	 */
	ShopCartItem getCartItem(@Param("userId") String userId, 
							@Param("itemNo") int itemNo,
							@Param("optionNo") int optionNo);
	
}
