package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.ShopItem;
import kr.co.movmov.vo.ShopItemOption;

public interface ShopItemMapper {
	
	/**
	 * 상품 번호로 옵션 정보 조회
	 * @param itemNo 상품 번호
	 * @return
	 */
	List<ShopItemOption> getOptionsByItemNo(int itemNo);

	/**
	 * 상품 번호로 상품 정보 반환
	 * @param id
	 * @return 상품 정보
	 */
	ShopItem getShopItemByItemNo(int itemNo);
	
	/**
	 * 카테고리 번호 조회해서 상품 리스트 반환
	 * @param no 카테고리 번호
	 * @return 상품 리스트
	 */
	List<ShopItem> getShopItemByCategoryNo(int categoryNo);
}