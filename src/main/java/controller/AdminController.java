package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import dto.ActionAcceptUserDonationDTO;
import dto.ActionCloseDonationDTO;
import dto.ActionRefuseUserDonationDTO;
import dto.CreateUserDTO;
import dto.UpdateTotalMoneyDonation;
import entity.Donation;
import entity.User;
import entity.UserDonation;
import service.DonationService;
import service.UserDonationService;
import service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private DonationService donationService;

    @Autowired
    private UserService userService;

    @Autowired
    private UserDonationService userDonationService;

    // Number of records per page
    final int numRecords = 3; 

    /**
     * List all donations with pagination and search functionality.
     */
    @SuppressWarnings("unchecked")
    @GetMapping("/listDonation")
    public String listDonation(@RequestParam(required = false) Integer page,
                               @RequestParam(required = false) Integer numRecords, 
                               @RequestParam(required = false) String search,
                               Model theModel) {

        int pageRq = page == null ? 1 : page;
        int numRecordsRq = numRecords == null ? 5 : numRecords;

        // Get donations from the Service
        Map<String, Object> map = donationService.getDonations(pageRq, numRecordsRq, search);
        List<Donation> theDonations = (List<Donation>) map.get("donations");

        int totalRecords = (int) map.get("countRecords");
        int totalPages = totalRecords % numRecordsRq == 0 ? totalRecords / numRecordsRq : totalRecords / numRecordsRq + 1;

        theModel.addAttribute("totalPages", totalPages);
        // Add the donations to the model
        theModel.addAttribute("donation", theDonations);
        theModel.addAttribute("currentPage", pageRq);

        return "donation";
    }

    /**
     * Show the form to add a new donation.
     */
    @PostMapping("/addDonation")
    public String showAddDonationForm(Model model) {
        // Add necessary model attributes if any
        return "add-donation"; 
    }

    /**
     * Save a new donation.
     */
    @PostMapping("/saveDonation")
    public String saveDonation(@ModelAttribute("donation") dto.CreateDonationDTO theDonation,
                               @RequestParam(required = false) Integer numRecords, Model theModel) {

        donationService.saveDonation(theDonation);
        theModel.addAttribute("numRecords", numRecords);
        return "redirect:/admin/listDonation?numRecords=" + numRecords;
    }

    /**
     * Update a donation and return its details in JSON format.
     */
    @GetMapping("/updateDonation")
    @ResponseBody
    public String updateDonation2(@RequestParam(required = false) String donationId, Model theModel) throws Exception {
        Donation donation = donationService.getDonationById(Integer.parseInt(donationId));
        return new Gson().toJson(donation);
    }

    /**
     * Save the updated donation.
     */
    @PostMapping("/saveUpdateDonation")
    public String saveUpdateDonation(@ModelAttribute("donation") dto.UpdateDonationDTO theDonation,
                                     @RequestParam("currentPage") int currentPage) {
        donationService.updateDonation(theDonation);
        return "redirect:/admin/listDonation";
    }

    /**
     * Delete a donation.
     */
    @GetMapping("/deleteDonation")
    public String deleteDonation(@RequestParam("donationID") int theId) {
        donationService.deleteDonation(theId);
        return "redirect:/admin/listDonation";
    }

    /**
     * View details of a specific donation.
     */
    @GetMapping("/detailDonation")
    public String detailDonation(@RequestParam("donationID") int theId, Model theModel) {
        Donation theDonationById = donationService.getDonationById(theId);
        theModel.addAttribute("donation", theDonationById);

        Long sumMoneyUserDonation = userDonationService.sumMoneyUserDonation(theId);
        theModel.addAttribute("sumMoneyUserDonation", sumMoneyUserDonation);

        List<UserDonation> theUserDonationByDonationId = userDonationService.getUserDonationByDonationId(theId);
        theModel.addAttribute("userDonations", theUserDonationByDonationId);

        return "detail-donation";
    }

    /**
     * End a donation.
     */
    @PostMapping("/endDonation")
    public String endDonation(@ModelAttribute("donation") ActionCloseDonationDTO dto,
                              @RequestParam("currentPage") int currentPage) {
        donationService.endDonation(dto);
        return "redirect:/admin/listDonation";
    }

    /**
     * Close a donation.
     */
    @PostMapping("/closeDonation")
    public String closeDonation(@ModelAttribute("donation") ActionCloseDonationDTO dto,
                                @RequestParam("currentPage") int currentPage) {
        donationService.closeDonation(dto);
        return "redirect:/admin/listDonation";
    }

    /**
     * Accept a user's donation.
     */
    @PostMapping("/acceptUserDonation")
    public String acceptUserDonation(@ModelAttribute("userDonation") ActionAcceptUserDonationDTO dto,
                                     UpdateTotalMoneyDonation updateTotalMoneyDontion, 
                                     @RequestParam("donationID") int theId) {
        userDonationService.acceptUseDonation(dto);
        userDonationService.updateTotalMoneyDonation(updateTotalMoneyDontion, theId);

        return "redirect:/admin/detailDonation?donationID=" + theId;
    }

    /**
     * Refuse a user's donation.
     */
    @PostMapping("/refuseUserDonation")
    public String refuseUserDonation(@ModelAttribute("userDonation") ActionRefuseUserDonationDTO dto,
                                     @RequestParam("donationID") int theId) {
        userDonationService.refuseUserDonation(dto);
        return "redirect:/admin/detailDonation?donationID=" + theId;
    }

    // User Management

    /**
     * List all users with pagination and search functionality.
     */
    @SuppressWarnings("unchecked")
    @GetMapping("/listUsers")
    public String listUsers(@RequestParam(required = false) Integer page,
                            @RequestParam(required = false) Integer numRecords, 
                            @RequestParam(required = false) String search,
                            Model theModel) {

        int pageRq = page == null ? 1 : page;
        int numRecordsRq = numRecords == null ? 5 : numRecords;

        // Get users from the Service
        Map<String, Object> map = userService.getUsers(pageRq, numRecordsRq, search);
        List<User> theUsers = (List<User>) map.get("users");
        int totalRecords = (int) map.get("countRecords");
        int totalPages = totalRecords % numRecordsRq == 0 ? totalRecords / numRecordsRq : totalRecords / numRecordsRq + 1;

        theModel.addAttribute("totalPages", totalPages);
        theModel.addAttribute("users", theUsers);
        theModel.addAttribute("currentPage", pageRq);

        return "user";
    }

    /**
     * Show the form to add a new user.
     */
    @PostMapping("/addUser")
    public String addUser(Model model) {
        // Add necessary model attributes if any
        return "add-user"; 
    }

    /**
     * Save a new user.
     */
    @PostMapping("/saveUser")
    public String saveUser(@ModelAttribute("user") CreateUserDTO theUser) {
        userService.saveUser(theUser);
        return "redirect:/admin/listUsers";
    }

    /**
     * Show the form to update an existing user.
     */
    @PostMapping("/updateUser")
    public String updateUser(@RequestParam("userId") int userId, Model theModel) {
        User user = userService.getUserById(userId);
        theModel.addAttribute("tempUser", user);
        return "update-user";
    }

    /**
     * Save the updated user.
     */
    @PostMapping("/saveUpdateUser")
    public String saveUpdateUser(@ModelAttribute("user") dto.UpdateUserDTO theUser) {
        userService.updateUser(theUser);
        return "redirect:/admin/listUsers";
    }

    /**
     * Delete a user.
     */
    @GetMapping("/deleteUser")
    public String deleteUser(@RequestParam("userID") int theId) {
        userService.deleteUser(theId);
        return "redirect:/admin/listUsers";
    }

    /**
     * Change the status of a user (lock/unlock).
     */
    @PostMapping("/changeUserStatus")
    public String changeUserStatus(@RequestParam("userId") int userId, 
                                   @RequestParam("flag") String flag,
                                   @RequestParam("status") int status) {
        User user = userService.getUserById(userId);
        user.setStatus(status);
        userService.updateUser(user);

        return "redirect:/admin/listUsers";
    }
}
