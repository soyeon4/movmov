package kr.co.movmov.mapper;


import kr.co.movmov.vo.User;


public interface UserMapper {

   // 모든 회원 등록 회원가입
   void insertUser(User user);
   
   // user의 id를 가져와서 이용
   User getIdByUser(String id);
   
   User getEmailByUser(String email);
   
   User getNickName(String nickname);
   
   void updateUserDelete(User user);
	
}
