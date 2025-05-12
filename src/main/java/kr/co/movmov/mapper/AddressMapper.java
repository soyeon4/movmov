package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Address;
import kr.co.movmov.vo.User;

public interface AddressMapper {

	void insertAddress(Address address);
	
	Address getDefaultAddress(User user);
	
	Address getAddressById(int id);
	
	List<Address> getAllAddressOfUser(User user);
	
	int countAddress();
	
	void updateAddress(Address address);
	
	void deleteAddress(Address address);
}