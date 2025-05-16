package kr.co.movmov.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import kr.co.movmov.vo.Address;
import kr.co.movmov.vo.User;

public interface AddressMapper {

	void insertAddress(Address address);
	
	Address getDefaultAddress(User user);
	
	Address getAddressById(int id);
	
	List<Address> getAllAddressOfUser(User user);
	
	void updateAddress(Address address);
	
	void updateDefaultAddress(@Param("addrID") int addrID, @Param("user") User user);
	
	void deleteAddressById(@Param("addrId") int addrId, @Param("userId") String userId);
}