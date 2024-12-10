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

import entity.User;

@Repository
public class UserDAOimpl implements UserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    /**
     * Save or update a user in the database.
     *
     * @param user the user to save or update
     */
    @Override
    @Transactional
    public void saveUser(User user) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(user);
    }

    /**
     * Retrieve a list of all users from the database.
     *
     * @return a list of users
     */
    @Override
    @Transactional
    public List<User> getUsers() {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<User> theQuery = currentSession.createQuery("from User", User.class);
        return theQuery.getResultList();
    }

    /**
     * Retrieve a paginated list of users with optional search criteria.
     *
     * @param page         the current page number
     * @param numRecords   the number of records per page
     * @param searchString the search criteria
     * @return a map containing the total count of records and the list of users
     */
    @Override
    @Transactional
    public Map<String, Object> getUsers(int page, int numRecords, String searchString) {
        Map<String, Object> map = new HashMap<>();
        Session currentSession = sessionFactory.getCurrentSession();
        StringBuffer queryString = new StringBuffer("from User u");
        
        if (searchString != null) {
            queryString.append(" where u.email = :email or u.phoneNumber = :phone_number");
        }
        queryString.append(" order by u.id");

        Query<User> theQuery = currentSession.createQuery(queryString.toString(), User.class);
        
        if (searchString != null) {
            theQuery.setParameter("email", searchString);
            theQuery.setParameter("phone_number", searchString);
        }

        int countRecords = theQuery.getResultList().size();
        theQuery.setFirstResult((page - 1) * numRecords);
        theQuery.setMaxResults(numRecords);

        List<User> users = theQuery.getResultList();
        map.put("countRecords", countRecords);
        map.put("users", users);

        return map;
    }

    /**
     * Retrieve a user by their ID.
     *
     * @param id the ID of the user to retrieve
     * @return the User object corresponding to the given ID
     */
    @Override
    public User getUserById(int id) {
        Session currentSession = sessionFactory.getCurrentSession();
        return currentSession.get(User.class, id);
    }

    /**
     * Delete a user by their ID.
     *
     * @param theId the ID of the user to delete
     */
    @Override
    @Transactional
    public void deleteUser(int theId) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query theQuery = currentSession.createQuery("delete from User where id=:userID");
        theQuery.setParameter("userID", theId);
        theQuery.executeUpdate();
    }

    /**
     * Find a user by their username.
     *
     * @param userName the username of the user to find
     * @return the User object corresponding to the given username
     */
    @Override
    @Transactional
    public User findByUserName(String userName) {
        Session currentSession;
        try {
            currentSession = sessionFactory.getCurrentSession();
        } catch (HibernateException e) {
            currentSession = sessionFactory.openSession();
        }

        Query<User> theQuery = currentSession.createQuery("from User u where u.userName = :userName", User.class);
        theQuery.setParameter("userName", userName);

        return theQuery.getSingleResult();
    }
}
