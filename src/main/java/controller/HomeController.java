package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dto.LoginDTO;
import entity.Donation;
import entity.User;
import service.DonationService;
import service.UserService;

@Controller
public class HomeController {

    @Autowired
    private UserService userService;

    @Autowired
    private DonationService donationService;

    /**
     * Display the home page with a list of donations.
     */
    @RequestMapping("/")
    private String home(Model theModel) {
        Map<String, Object> map = donationService.getDonations(1, 5, null);
        List<User> donations = (List<User>) map.get("donations");
        theModel.addAttribute("donations", donations);
        theModel.addAttribute("currentPage", 1);
        return "home-user";
    }

    /**
     * Display the login page.
     */
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    /**
     * Handle the login process.
     */
    @SuppressWarnings("unchecked")
    @PostMapping("/doLogin")
    public String login(HttpServletRequest request, 
                        @ModelAttribute("user") LoginDTO dto,
                        @RequestParam(required = false) Integer page, 
                        @RequestParam(required = false) Integer numRecords,
                        Model theModel) {

        HttpSession session = request.getSession(true);
        // Case user has already logged in and has a session
        User user = (User) session.getAttribute("loggedinUser");

        // Case user has not yet logged in
        if (user == null) {
            user = userService.isUsers(dto);
        }

        if (user != null) {
            // Set logged in user in session
            session.setAttribute("loggedinUser", user);

            // Admin user redirect to admin donation list
            if (user.getRole().getRoleName().equalsIgnoreCase("admin")) {
                Map<String, Object> map = donationService.getDonations(1, 5, null);
                List<Donation> donations = (List<Donation>) map.get("donations");
                theModel.addAttribute("donations", donations);
                theModel.addAttribute("currentPage", 1);
                return "redirect:/admin/listDonation";
            } 
            // Regular user display user home with donations
            else {
                int pageRq = page == null ? 1 : page;
                int numRecordsRq = numRecords == null ? 5 : numRecords;

                Map<String, Object> map1 = donationService.getDonations(pageRq, numRecordsRq, null);
                List<Donation> theDonations = (List<Donation>) map1.get("donations");
                int totalRecords = (int) map1.get("countRecords");
                int totalPages = totalRecords % numRecordsRq == 0 ? totalRecords / numRecordsRq : totalRecords / numRecordsRq + 1;
                
                theModel.addAttribute("totalPages", totalPages);
                theModel.addAttribute("donations", theDonations);
                theModel.addAttribute("currentPage", pageRq);
                
                return "home-user";
            }

        } 
        // If login fails, redirect to login page with error
        else {
            session.setAttribute("error", "error");
            return "redirect:/login";
        }
    }

    /**
     * Handle user logout.
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
