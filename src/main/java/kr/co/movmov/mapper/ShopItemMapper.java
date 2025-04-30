package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.ShopItem;

public interface ShopItemMapper {

	/**
	 * 상품 번호로 상품 정보 반환
	 * @param id
	 * @return 상품 정보
	 */
	ShopItem getShopItemById(int id);
	
	/**
	 * 카테고리 번호 조회해서 상품 리스트 반환
	 * @param no 카테고리 번호
	 * @return 상품 리스트
	 */
	List<ShopItem> getShopItemByCategoryNo(int no);
}
