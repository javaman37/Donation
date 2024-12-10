package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.RoleDAO;
import dao.UserDAO;
import entity.Role;
import entity.User;
import dto.CreateUserDTO;
import dto.LockUnlockUserDTO;
import dto.LoginDTO;
import dto.UpdateUserDTO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private RoleDAO roleDAO;

	/**
	 * Saves a new user based on DTO input.
	 * 
	 * @param dto DTO containing user information.
	 */
	@Override
	public void saveUser(CreateUserDTO dto) {
		User user = new User();

		user.setAddress(dto.getAddress());
		user.setEmail(dto.getEmail());
		user.setFullName(dto.getFullName());
		user.setNote(dto.getNote());
		user.setPassword(dto.getPassword());
		user.setPhoneNumber(dto.getPhoneNumber());
		user.setUserName(dto.getUserName());

		Role role = roleDAO.getRoleById(dto.getRole());
		user.setRole(role);

		userDAO.saveUser(user);
	}

	/**
	 * Retrieves a list of all users.
	 * 
	 * @return List of users.
	 */
	@Override
	@Transactional
	public List<User> getUsers() {
		return userDAO.getUsers();
	}

	/**
	 * Retrieves a user by their ID.
	 * 
	 * @param userId ID of the user.
	 * @return User object.
	 */
	@Override
	@Transactional
	public User getUserById(int userId) {
		return userDAO.getUserById(userId);
	}

	/**
	 * Updates an existing user based on DTO input.
	 * 
	 * @param dto DTO containing updated user information.
	 */
	@Override
	@Transactional
	public void updateUser(UpdateUserDTO dto) {
		User user = userDAO.getUserById(dto.getId());

		user.setAddress(dto.getAddress());
		user.setEmail(dto.getEmail());
		user.setFullName(dto.getFullName());
		user.setNote(dto.getNote());
		user.setPhoneNumber(dto.getPhoneNumber());

		userDAO.saveUser(user);
	}

	/**
	 * Deletes a user by their ID.
	 * 
	 * @param theId ID of the user to delete.
	 */
	@Override
	@Transactional
	public void deleteUser(int theId) {
		userDAO.deleteUser(theId);
	}

	/**
	 * Locks a user account based on DTO input.
	 * 
	 * @param dto DTO containing user ID to lock.
	 */
	@Override
	@Transactional
	public void lockUserDTO(LockUnlockUserDTO dto) {
		User user = userDAO.getUserById(dto.getId());
		user.setStatus(0); // Lock status
		userDAO.saveUser(user);
	}

	/**
	 * Unlocks a user account based on DTO input.
	 * 
	 * @param dto DTO containing user ID to unlock.
	 */
	@Override
	@Transactional
	public void unLockUserDTO(LockUnlockUserDTO dto) {
		User user = userDAO.getUserById(dto.getId());
		user.setStatus(1); // Active status
		userDAO.saveUser(user);
	}

	/**
	 * Updates an existing user.
	 * 
	 * @param user Updated user object.
	 */
	@Override
	public void updateUser(User user) {
		userDAO.saveUser(user);
	}

	/**
	 * Checks if a user exists based on login credentials.
	 * 
	 * @param dto DTO containing login credentials.
	 * @return User object if login is successful, otherwise null.
	 */
	@Override
	@Transactional
	public User isUsers(LoginDTO dto) {
		User user = userDAO.findByUserName(dto.getUserName());
		if (user != null && user.getPassword().equals(dto.getPassWord())) {
			return user;
		}
		return null;
	}

	/**
	 * Retrieves a paginated list of users based on page number, number of records per page, and optional search string.
	 * 
	 * @param page       Page number.
	 * @param numRecords Number of records per page.
	 * @param s          Optional search string.
	 * @return Map containing count of records and list of users.
	 */
	@Override
	@Transactional
	public Map<String, Object> getUsers(int page, int numRecords, String s) {
		return userDAO.getUsers(page, numRecords, s);
	}

}
