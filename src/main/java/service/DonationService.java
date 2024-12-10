package service;
import entity.Donation;

import java.util.List;
import java.util.Map;

import dto.*;


public interface DonationService {
	
	List<Donation> getDonations();
	Donation getDonationById(int id);
	Map<String, Object> getDonations(int page,int numRecords, String s);
	
	void saveDonation(CreateDonationDTO dto);
	void updateDonation(UpdateDonationDTO dto);
	
	void deleteDonation(int theId);
	List<Donation> getDonationsByPage(int pageId, int total);
	long countDonation();

	void endDonation(ActionCloseDonationDTO dto);

	void closeDonation(ActionCloseDonationDTO dto);


}
