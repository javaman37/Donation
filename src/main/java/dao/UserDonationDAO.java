package dao;

import java.util.List;

import entity.UserDonation;

public interface UserDonationDAO {

	public Long sumMoneyUserDonation(int theId);

	public List<UserDonation> getUserDonationByDonationId(int theId);

	public void saveUserDonation(UserDonation userDonation);

	public UserDonation getUserDonationById(int id);

}
