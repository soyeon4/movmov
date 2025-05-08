package kr.co.movmov.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

@WebServlet("/api/search-address")
public class KakaoAddrServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ 본인의 Kakao REST API Key 입력 (주의: "KakaoAK " 앞 공백 포함 필수)
    private static final String KAKAO_API_KEY = "KakaoAK 1fcd50b1638310f5958d168fdd4ebc97";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 검색어 파라미터 추출
        String keyword = req.getParameter("keyword");
        if (keyword == null || keyword.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "검색어가 필요합니다.");
            return;
        }

        // Kakao 주소 검색 API 요청 URL
        String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + URLEncoder.encode(keyword, "UTF-8");

        // API 요청
        HttpURLConnection conn = (HttpURLConnection) new URL(apiUrl).openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", KAKAO_API_KEY);
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setRequestProperty("User-Agent", "Mozilla/5.0"); // 없으면 403 발생

        // 응답 읽기
        int responseCode = conn.getResponseCode();
        InputStream inputStream = (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
        String json = reader.lines().collect(Collectors.joining());
        reader.close();

        // 결과 전송
        resp.setStatus(responseCode);
        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().write(json);
    }
}
