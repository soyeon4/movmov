package kr.co.movmov.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.ShopCartItem;

public interface ShopCartItemMapper {

	/**
	 * 선택된 장바구니 상품의 번호로 상품 정보 조회
	 * @param cartNo 장바구니 번호
	 * @return 장바구니 상품 정보
	 */
	ShopCartItem getCartItemsByCartNo(@Param("cartNo") int cartNo);
	
	
	/**
	 * 장바구니 상품 옵션 정보 등록
	 * @param cartNo 장바구니 번호
	 * @param optionNo 옵션 번호
	 */
	void updateCartItemOptionByCartNo(@Param("cartNo") int cartNo, 
							@Param("optionNo") int optionNo);
	
	/**
	 * 장바구니 상품 수량 정보 수정
	 * @param cartNo 장바구니 번호
	 * @param quantity 수량
	 */
	void updateCartItemQuantityByCartNo(@Param("cartNo") int cartNo, 
							@Param("quantity") int quantity);
	
	/**
	 * 사용자 아이디와 상품 아이디를 전달받아 장바구니에 추가
	 * @param userId 사용자 아이디
	 * @param itemNo 상품 번호
	 * @param optionNo 옵션 번호
	 * @param quantity 수량
	 */
	void insertCartItem(@Param("userId") String userId, 
					@Param("itemNo") int itemNo, 
					@Param("optionNo") int optionNo, 
					@Param("quantity") int quantity);
	
	/**
	 * 장바구니 번호로 장바구니에서 상품 삭제
	 * @param cartNo 장바구니 번호
	 */
	void deleteCartItemByCartNo(int cartNo);

	/**
	 * 해당 사용자의 장바구니 비우기
	 * @param userId 사용자 아이디
	 */
	void deleteCartItemByUserId(String userId);
	
	/**
	 * 사용자 아이디로 장바구니 상품리스트 조회
	 * @param userId 사용자 아이디
	 * @return 해당 사용자의 장바구니 목록
	 */
	List<ShopCartItem> getCartItemsByUserId(String userId);

	/**
	 * 장바구니 상품 정보 조회
	 * @param userId 사용자 아이디
	 * @param itemNo 상품 번호
	 * @param optionNo 옵션 번호
	 * @return 장바구니 상품
	 */
	ShopCartItem getCartItem(@Param("userId") String userId, 
							@Param("itemNo") int itemNo,
							@Param("optionNo") int optionNo);
	
}