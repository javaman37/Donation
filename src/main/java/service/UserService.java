package service;

import java.util.List;
import java.util.Map;

import dto.CreateUserDTO;
import dto.LockUnlockUserDTO;
import dto.LoginDTO;
import dto.UpdateUserDTO;
import entity.User;

public interface UserService {
	
	List<User> getUsers();
	User getUserById(int userId);
	Map<String, Object> getUsers(int page,int numRecords, String s);

	
	public void saveUser(CreateUserDTO dto);
	
	public void updateUser(User user);
	void updateUser(UpdateUserDTO theUser);
	
	void deleteUser(int theId);
	
	void unLockUserDTO(LockUnlockUserDTO dto);
	void lockUserDTO(LockUnlockUserDTO dto);
	
	User isUsers(LoginDTO dto);

}
