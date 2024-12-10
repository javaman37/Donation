package service;

import java.util.List;

import dto.ActionAcceptUserDonationDTO;
import dto.ActionRefuseUserDonationDTO;
import dto.CreateUserDonationDTO;
import dto.UpdateTotalMoneyDonation;
import entity.UserDonation;

public interface UserDonationService {

	Long sumMoneyUserDonation(int theId);

	List<UserDonation> getUserDonationByDonationId(int theId);

	void saveUserDonation(CreateUserDonationDTO theUserDonation);

	void acceptUseDonation(ActionAcceptUserDonationDTO actionAcceptUserDontionDTO);

	void updateTotalMoneyDonation(UpdateTotalMoneyDonation updateTotalMoneyDontion, int theId);

	void refuseUserDonation(ActionRefuseUserDonationDTO dto);

}
