package dao;

import java.util.List;
import java.util.Map;

import entity.Donation;

public interface DonationDAO {

	public void saveDonation(Donation theDonation);

	public List<Donation> getDonations();

	public List<Donation> getDonationsPaging(int page, int numPerPage);

	public Donation getDonationById(int id);

	public void deleteDonation(int theId);

	List<Donation> getDonationsByPage(int pageId, int total);

	long countDonation();

	public Map<String, Object> getDonations(int page, int numRecords, String s);

}
