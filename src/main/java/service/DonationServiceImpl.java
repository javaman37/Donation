package service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.ActionCloseDonationDTO;
import dto.CreateDonationDTO;
import dto.UpdateDonationDTO;
import entity.Donation;
import dao.DonationDAO;

@Service
public class DonationServiceImpl implements DonationService {

    @Autowired
    private DonationDAO donationDAO;

    /**
     * Retrieves donations with pagination and optional search parameters.
     * 
     * @param page       Page number of results to retrieve.
     * @param numRecords Number of records per page.
     * @param s          Optional search string for filtering.
     * @return A map containing donations and total count of records.
     */
    @Override
    public Map<String, Object> getDonations(int page, int numRecords, String s) {
        return donationDAO.getDonations(page, numRecords, s);
    }

    /**
     * Saves a new donation based on DTO input.
     * 
     * @param dto DTO containing donation information.
     */
    @Override
    public void saveDonation(CreateDonationDTO dto) {
        try {
            Donation donation = new Donation();

            donation.setCode(dto.getCode());
            donation.setName(dto.getName());
            donation.setStartDate(new SimpleDateFormat("yyyy-MM-dd").parse(dto.getStartDate()));

            // Compare start date with current date
            Date currentDate = new Date();
            donation.setEndDate(new SimpleDateFormat("yyyy-MM-dd").parse(dto.getEndDate()));

            // Set status based on end date comparison
            if (donation.getEndDate().before(currentDate)) {
                donation.setStatus(3); // Ended
            }
            if (donation.getEndDate().after(currentDate)) {
                donation.setStatus(2); // Ongoing
            }
            if (donation.getStartDate().after(currentDate)) {
                donation.setStatus(1); // Upcoming
            }

            donation.setOrganizationName(dto.getOrganizationName());
            donation.setPhoneNumber(dto.getPhoneNumber());
            donation.setDescription(dto.getDescription());

            donationDAO.saveDonation(donation);

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    /**
     * Retrieves all donations.
     * 
     * @return List of all donations.
     */
    @Override
    @Transactional
    public List<Donation> getDonations() {
        return donationDAO.getDonations();
    }

    /**
     * Updates an existing donation based on DTO input.
     * 
     * @param dto DTO containing updated donation information.
     */
    @Override
    @Transactional
    public void updateDonation(UpdateDonationDTO dto) {
        try {
            Donation donation = donationDAO.getDonationById(dto.getId());

            donation.setCode(dto.getCode());
            donation.setName(dto.getName());
            donation.setStartDate(new SimpleDateFormat("yyyy-MM-dd").parse(dto.getStartDate()));
            donation.setEndDate(new SimpleDateFormat("yyyy-MM-dd").parse(dto.getEndDate()));
            donation.setOrganizationName(dto.getOrganizationName());
            donation.setPhoneNumber(dto.getPhoneNumber());
            donation.setDescription(dto.getDescription());

            // Update status based on start and end dates
            Date currentDate = new Date();

            if (donation.getEndDate().before(currentDate)) {
                donation.setStatus(3); // Ended
            } else if (donation.getStartDate().after(currentDate)) {
                donation.setStatus(1); // Upcoming
            } else {
                donation.setStatus(2); // Ongoing
            }

            donationDAO.saveDonation(donation);

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    /**
     * Retrieves a donation by its ID.
     * 
     * @param id ID of the donation to retrieve.
     * @return The donation entity.
     */
    @Override
    @Transactional
    public Donation getDonationById(int id) {
        return donationDAO.getDonationById(id);
    }

    /**
     * Deletes a donation by its ID.
     * 
     * @param theId ID of the donation to delete.
     */
    @Override
    @Transactional
    public void deleteDonation(int theId) {
        donationDAO.deleteDonation(theId);
    }

    /**
     * Retrieves donations with pagination.
     * 
     * @param pageId  Page number of results to retrieve.
     * @param total   Number of records per page.
     * @return List of donations for the specified page.
     */
    @Override
    @Transactional
    public List<Donation> getDonationsByPage(int pageId, int total) {
        return donationDAO.getDonationsByPage(pageId, total);
    }

    /**
     * Counts the total number of donations.
     * 
     * @return Total number of donations.
     */
    @Override
    @Transactional
    public long countDonation() {
        return donationDAO.countDonation();
    }

    /**
     * Closes a donation by setting its status to closed (0).
     * 
     * @param dto DTO containing donation ID to close.
     */
    @Override
    @Transactional
    public void closeDonation(ActionCloseDonationDTO dto) {
        Donation donation = donationDAO.getDonationById(dto.getId());
        donation.setStatus(0); // Closed
        donationDAO.saveDonation(donation);
    }

    /**
     * Ends a donation by setting its status to ended (3).
     * 
     * @param dto DTO containing donation ID to end.
     */
    @Override
    public void endDonation(ActionCloseDonationDTO dto) {
        Donation donation = donationDAO.getDonationById(dto.getId());
        donation.setStatus(3); // Ended
        donationDAO.saveDonation(donation);
    }
}
