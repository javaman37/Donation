package dao;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import entity.Role;

@Repository
public class RoleDAOimpl implements RoleDAO {
    
    @Autowired
    private SessionFactory sessionFactory;

    /**
     * Retrieve a role by its ID.
     *
     * @param role the ID of the role to retrieve
     * @return the Role object corresponding to the given ID
     */
    @Override
    @Transactional
    public Role getRoleById(Integer role) {
        Session currentSession = sessionFactory.getCurrentSession();
        Role role2 = currentSession.get(Role.class, role);
        return role2;
    }
}
