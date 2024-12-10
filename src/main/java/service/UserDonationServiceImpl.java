package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.DonationDAO;
import dao.UserDAO;
import dao.UserDonationDAO;
import dto.ActionAcceptUserDonationDTO;
import dto.ActionRefuseUserDonationDTO;
import dto.CreateUserDonationDTO;
import dto.UpdateTotalMoneyDonation;
import entity.Donation;
import entity.User;
import entity.UserDonation;

@Service
public class UserDonationServiceImpl implements UserDonationService {

    @Autowired
    private DonationDAO donationDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private UserDonationDAO userDonationDAO;

    /**
     * Calculates the total money donated for a specific donation.
     * 
     * @param theId ID of the donation.
     * @return Total money donated.
     */
    @Override
    @Transactional
    public Long sumMoneyUserDonation(int theId) {
        return userDonationDAO.sumMoneyUserDonation(theId);
    }

    /**
     * Retrieves user donations for a specific donation ID.
     * 
     * @param theId ID of the donation.
     * @return List of user donations.
     */
    @Override
    @Transactional
    public List<UserDonation> getUserDonationByDonationId(int theId) {
        return userDonationDAO.getUserDonationByDonationId(theId);
    }

    /**
     * Saves a new user donation based on DTO input.
     * 
     * @param dto DTO containing user donation information.
     */
    @Override
    @Transactional
    public void saveUserDonation(CreateUserDonationDTO dto) {
        UserDonation userDonation = new UserDonation();

        userDonation.setMoney(dto.getMoney());
        userDonation.setName(dto.getName());
        userDonation.setText(dto.getText());

        User user = userDAO.getUserById(dto.getUser());
        userDonation.setUser(user);

        Donation donation = donationDAO.getDonationById(dto.getDonation());
        userDonation.setDonation(donation);

        userDonationDAO.saveUserDonation(userDonation);
    }

    /**
     * Accepts a user donation by setting its status to accepted (1).
     * 
     * @param dto DTO containing user donation ID to accept.
     */
    @Override
    @Transactional
    public void acceptUseDonation(ActionAcceptUserDonationDTO dto) {
        UserDonation userDonation = userDonationDAO.getUserDonationById(dto.getId());
        userDonation.setStatus(1); // Accepted
        userDonationDAO.saveUserDonation(userDonation);
    }

    /**
     * Updates the total money donated for a specific donation.
     * 
     * @param dto   DTO containing updated donation information.
     * @param theId ID of the donation to update.
     */
    @Override
    @Transactional
    public void updateTotalMoneyDonation(UpdateTotalMoneyDonation dto, int theId) {
        UserDonation userDonation = userDonationDAO.getUserDonationById(dto.getId());
        Donation donation = donationDAO.getDonationById(theId);
        int moneyOfDonation = donation.getMoney();
        int moneyOfUserDonation = userDonation.getMoney();
        donation.setMoney(moneyOfDonation + moneyOfUserDonation);
        donationDAO.saveDonation(donation);
    }

    /**
     * Refuses a user donation by setting its status to refused (2).
     * 
     * @param dto DTO containing user donation ID to refuse.
     */
    @Override
    @Transactional
    public void refuseUserDonation(ActionRefuseUserDonationDTO dto) {
        UserDonation userDonation = userDonationDAO.getUserDonationById(dto.getId());
        userDonation.setStatus(2); // Refused
        userDonationDAO.saveUserDonation(userDonation);
    }
}
