<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="kr.co.movmov.mapper.FaqMapper" %>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>
<%@ page import="kr.co.movmov.vo.Faq" %>

<%
request.setCharacterEncoding("UTF-8");

String catId = request.getParameter("catId");
String pageParam = request.getParameter("page");
String keyword = request.getParameter("keyword");

int pageNo = 1;
int rows = 10;

try {
    pageNo = Integer.parseInt(pageParam);
} catch (Exception e) {
    pageNo = 1;
}
int offset = (pageNo - 1) * rows;

Map<String, Object> condition = new HashMap<>();
condition.put("offset", offset);
condition.put("rows", rows);

if (catId != null && !catId.trim().isEmpty()) {
    condition.put("catId", catId);
}
if (keyword != null && !keyword.trim().isEmpty()) {
    condition.put("keyword", "%" + keyword.trim() + "%");
}

FaqMapper faqMapper = MybatisUtils.getMapper(FaqMapper.class);
List<Faq> faqs = faqMapper.getFaqsByCategory(condition);
int totalRows = faqMapper.getTotalRows(condition);

Map<String, Object> result = new HashMap<>();
List<Map<String, Object>> faqList = new ArrayList<>();

for (Faq faq : faqs) {
    Map<String, Object> faqMap = new HashMap<>();
    faqMap.put("id", faq.getId());
    faqMap.put("title", faq.getTitle());
    faqMap.put("content", faq.getContent());
    faqMap.put("categoryName", faq.getCategory().getName());
    faqList.add(faqMap);
}

result.put("faqs", faqList);
result.put("totalRows", totalRows);

Gson gson = new Gson();
String json = gson.toJson(result);
out.write(json);
%>
