package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import entity.UserDonation;

@Repository
public class UserDonationDAOImpl implements UserDonationDAO {

    @Autowired
    private SessionFactory sessionFactory;

    /**
     * Calculate the total amount of money donated for a specific donation ID where the status is 1.
     *
     * @param theId the ID of the donation
     * @return the total amount of money donated
     */
    @Override
    @Transactional
    public Long sumMoneyUserDonation(int theId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Long> theQuery = currentSession.createQuery(
                "select sum(money) from UserDonation d where d.status = 1 and d.donation.id = :donationID", Long.class);
        theQuery.setParameter("donationID", theId);
        return theQuery.getSingleResult();
    }

    /**
     * Retrieve a list of user donations for a specific donation ID.
     *
     * @param theId the ID of the donation
     * @return a list of UserDonation objects
     */
    @Override
    @Transactional
    public List<UserDonation> getUserDonationByDonationId(int theId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<UserDonation> theQuery = currentSession.createQuery(
                "from UserDonation d where d.donation.id = :donationID", UserDonation.class);
        theQuery.setParameter("donationID", theId);
        return theQuery.getResultList();
    }

    /**
     * Save or update a UserDonation in the database.
     *
     * @param theUserDonation the UserDonation object to save or update
     */
    @Override
    @Transactional
    public void saveUserDonation(UserDonation theUserDonation) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(theUserDonation);
    }

    /**
     * Retrieve a UserDonation by its ID.
     *
     * @param theId the ID of the UserDonation
     * @return the UserDonation object corresponding to the given ID
     */
    @Override
    @Transactional
    public UserDonation getUserDonationById(int theId) {
        Session currentSession = sessionFactory.getCurrentSession();
        return currentSession.get(UserDonation.class, theId);
    }
}
