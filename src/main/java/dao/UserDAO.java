package dao;

import java.util.List;
import java.util.Map;

import entity.User;

public interface UserDAO {
	
	//public List<User> getUsers();
	void saveUser(User user);
	public User getUserById(int id);
	void deleteUser(int theId);
	public User findByUserName(String userName);
	
	List<User> getUsers();
	Map<String, Object> getUsers(int page,int numRecords, String s);

}
