package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.Donation;

@Repository
public class DonationDAOimpl implements DonationDAO {

    @Autowired
    private SessionFactory sessionFactory;

    /**
     * Save or update a donation in the database.
     */
    @Override
    @Transactional
    public void saveDonation(Donation theDonation) throws HibernateException {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(theDonation);
    }

    /**
     * Retrieve all donations from the database.
     */
    @Override
    @Transactional
    public List<Donation> getDonations() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Donation> theQuery = currentSession.createQuery("from Donation", Donation.class);
        return theQuery.getResultList();
    }

    /**
     * Retrieve a specific donation by its ID.
     */
    @Override
    @Transactional
    public Donation getDonationById(int id) {
        Session currentSession = sessionFactory.getCurrentSession();
        return currentSession.get(Donation.class, id);
    }

    /**
     * Delete a donation by its ID.
     */
    @Override
    @Transactional
    public void deleteDonation(int theId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createQuery("delete from Donation where id=:donationID");
        theQuery.setParameter("donationID", theId);
        theQuery.executeUpdate();
    }

    /**
     * Retrieve donations with pagination.
     */
    @Override
    @Transactional
    public List<Donation> getDonationsByPage(int pageId, int total) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Donation> theQuery = currentSession.createQuery("from Donation", Donation.class);
        theQuery.setFirstResult(pageId);
        theQuery.setMaxResults(total);
        return theQuery.getResultList();
    }

    /**
     * Count the total number of donations.
     */
    @Override
    @Transactional
    public long countDonation() {
        Session currentSession;
        try {
            currentSession = sessionFactory.getCurrentSession();
        } catch (HibernateException e) {
            currentSession = sessionFactory.openSession();
        }
        Query<Long> theQuery = currentSession.createQuery("select count(*) from Donation", Long.class);
        return theQuery.uniqueResult();
    }

    /**
     * Retrieve donations with pagination for a specific page and number of records per page.
     */
    @Override
    public List<Donation> getDonationsPaging(int page, int numPerPage) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Donation> theQuery = currentSession.createQuery("from Donation", Donation.class);
        theQuery.setFirstResult((page - 1) * numPerPage);
        theQuery.setMaxResults(numPerPage);
        return theQuery.getResultList();
    }

    /**
     * Retrieve donations with pagination and optional search criteria.
     */
    @Override
    @Transactional
    public Map<String, Object> getDonations(int page, int numRecords, String searchString) {
        Map<String, Object> map = new HashMap<>();
        Session currentSession = sessionFactory.getCurrentSession();

        StringBuilder queryString = new StringBuilder("from Donation d");
        if (searchString != null) {
            queryString.append(
                    " where d.status = :status or d.phoneNumber = :phone_number or d.code = :code or d.name=:name ");
        }
        queryString.append(" order by d.id");

        Query<Donation> theQuery = currentSession.createQuery(queryString.toString(), Donation.class);
        if (searchString != null) {
            try {
                int statusInt = Integer.parseInt(searchString);
                theQuery.setParameter("status", statusInt);
            } catch (NumberFormatException e) {
                theQuery.setParameter("status", -1); // or another invalid value if needed
            }

            theQuery.setParameter("phone_number", searchString);
            theQuery.setParameter("code", searchString);
            theQuery.setParameter("name", searchString);
        }

        int countRecords = theQuery.getResultList().size();
        theQuery.setFirstResult((page - 1) * numRecords);
        theQuery.setMaxResults(numRecords);

        List<Donation> donations = theQuery.getResultList();
        map.put("countRecords", countRecords);
        map.put("donations", donations);
        return map;
    }
}
