package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dto.CreateUserDonationDTO;
import entity.Donation;
import entity.UserDonation;
import service.DonationService;
import service.UserDonationService;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserDonationService userDonationService;

    @Autowired
    private DonationService donationService;

    /**
     * Display the details of a specific donation.
     */
    @GetMapping("/detail")
    public String detailDonation(@RequestParam("donationID") int theId, 
                                 Model theModel,
                                 @RequestParam(required = false) String status) {
        // Get donation by ID
        Donation theDonationById = donationService.getDonationById(theId);
        // Get user donations related to this donation
        List<UserDonation> userDonation = userDonationService.getUserDonationByDonationId(theId);
        
        // Add attributes to the model
        theModel.addAttribute("donation", theDonationById);
        theModel.addAttribute("userDonationsAccepted", userDonation);
        theModel.addAttribute("msg", status);

        return "detail";
    }

    /**
     * Save user donation and redirect to the donation detail page.
     */
    @PostMapping("saveUserDonation")
    public String saveUserDonation(@ModelAttribute("userDonation") CreateUserDonationDTO theUserDonation) {
        // Save the user donation
        userDonationService.saveUserDonation(theUserDonation);
        
        // Redirect to the donation detail page with status
        return "redirect:/user/detail?status=ss&donationID=" + theUserDonation.getDonation();
    }
}
