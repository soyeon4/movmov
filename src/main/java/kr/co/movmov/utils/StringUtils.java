package kr.co.movmov.utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtils {
	
	private static DecimalFormat decimalFormat = new DecimalFormat("##,###");
	private static SimpleDateFormat detailDateFormat = new SimpleDateFormat("yyyy년 M월 d일 a h시 m분 s초");
	private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 값을 전달받아서, 해당 값이 null이면 defaultValue를 반환한다.
	 * @param value null일 가능성이 있는 문자열
	 * @param defaultValue 기본값
	 * @return 문자열, null일 때는 기본값
	 */
	public static String nullToStr(String value, String defaultValue) {
		if (value == null) {
			return defaultValue;
		}
		return value.trim();
	}
	
	/**
	 * 전달받은 값이 null이면 빈 문자열을 반환한다.
	 * @param value null일 가능성이 있는 문자열
	 * @return 문자열 혹은 빈 문자열
	 */
	public static String nullToBlank(String value) {
		return nullToStr(value, "");
	}
	
	/**
	 * 날짜를 전달받아서
	 * "2024년 1월 1일 오전 9시 10분 20초" 형식의 문자열로 반환한다.
	 * @param date 날짜
	 * @return "2024년 1월 1일 오전 0시 10분 20초" 형식의 문자열
	 */
	public static String detailDate(Date date) {
		if (date == null) {
			return "";
		}
		return detailDateFormat.format(date);
	}
	
	
	/**
	 * 날짜를 전달받아서
	 * "2024-01-01" 형식의 문자열로 반환한다.
	 * @param date 날짜
	 * @return "2024-01-01" 형식의 문자열
	 */
	public static String simpleDate(Date date) {
		if (date == null) {
			return "";
		}
		return simpleDateFormat.format(date);
	}
	
	
	/**
	 * 정수를 ,가 포함된 텍스트로 변환한다.
	 * @param number 숫자
	 * @return 3자리마다 ,가 포함된 숫자형식 텍스트
	 */
	public static String commaWithNumber(int number) {
		return decimalFormat.format(number);
	}
	
	public static int strToInt(String str, int defaultValue) {
		if (str == null) {
			return defaultValue;
		}
		str = str.trim();
		if (str.isEmpty()) {
			return defaultValue;
		}
		
		try {
			return Integer.parseInt(str);
		} catch (NumberFormatException ex){
			return defaultValue;
		}
	}
	
	/**
	 * 문자열을 정수로 변환해서 반환한다.
	 * @param str
	 * @return int
	 */
	public static int strToInt(String str) {
		if (str == null) {
			throw new IllegalArgumentException("null값은 숫자로 변환할 수 없습니다.");
		}
		str = str.trim();
		if (str.isEmpty()) {
			throw new IllegalArgumentException("빈 문자열은 숫자로 변환할 수 없습니다.");
		} return Integer.parseInt(str);
	}
	
	/**
	 * String[]을 int[]로 변환해서 반환한다.
	 * @param values 문자열 배열
	 * @return 정수 배열
	 */
	public static int[] strToInt(String[] values) {
		/*
		 * ["1", "4", "10"] -> [1, 4, 10]
		 */
		int[] numbers = new int[values.length];
		
		for (int index=0; index < values.length; index++) {
			numbers[index] = strToInt(values[index]);
		}
		return numbers;
	}
	
	/**
	 * 평점에 맞는 별을 반환한다.
	 * @param rating 평점
	 * @return 별
	 */
	public static String toStar(double rating) {
		int filledCnt = (int) Math.floor(rating);
		int emptyCnt = 5 - filledCnt;
		String filledStars = "★".repeat(filledCnt);
		String emptyStars = "✰".repeat(emptyCnt);
		String starRating = filledStars + emptyStars;
		return starRating;
	}

}
