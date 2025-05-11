package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Address;
import kr.co.movmov.vo.User;

public interface AddressMapper {
	
	//C:Create
	void insertAddress(Address address);
	
	//R:Retrieve
	List<Address> getAllAddressOfUser(User user);
	Address getDefaultAddress(User user);
	
	
	//U:Update
	void updateAddressInfo(Address address);
	
	//D:Delete
	void deleteAddress(Address address);
}