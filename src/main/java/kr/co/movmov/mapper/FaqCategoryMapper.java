package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Category;

public interface FaqCategoryMapper {
	
	List<Category> getCategoriesByType(String Type);	// FAQ
	
	}	
