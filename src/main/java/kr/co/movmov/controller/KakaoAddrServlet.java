package kr.co.movmov.controller;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

@WebServlet("/api/search-address")
public class KakaoAddrServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String KAKAO_API_KEY = "KakaoAK 1fcd50b1638310f5958d168fdd4ebc97";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String keyword = req.getParameter("keyword");
        if (keyword == null || keyword.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "검색어가 필요합니다.");
            return;
        }

        String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + URLEncoder.encode(keyword, "UTF-8");
        HttpURLConnection conn = (HttpURLConnection) new URL(apiUrl).openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", KAKAO_API_KEY);
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setRequestProperty("User-Agent", "Mozilla/5.0"); // ⭐ 꼭 필요

        int responseCode = conn.getResponseCode();
        InputStream inputStream = (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
        String json = reader.lines().collect(Collectors.joining());
        reader.close();

        resp.setStatus(responseCode);
        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().write(json);
    }
}
