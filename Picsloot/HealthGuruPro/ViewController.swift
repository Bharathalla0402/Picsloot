//
//  ViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 05/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HMDiallingCodeDelegate,CountriesViewControllerDelegate
{

    @IBOutlet weak var txtCCode: ACFloatingTextfield!
    @IBOutlet weak var txtMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var NextButt: UIButton!
    @IBOutlet weak var CCodeButt: UIButton!
    
    var diallingCode = HMDiallingCode()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.diallingCode.delegate=self;
        
        NextButt.layer.cornerRadius = 20
        
        self.txtCCode.text! = String(format: "+%@","91")
    }
    
    
    // MARK: - Country Code Butt Clicked
    
    @IBAction func CCodeButtClicked(_ sender: UIButton)
    {
        //case

       // self.txtCCode.text! = String(format: "+%@","91")
        
//        /// Create a controller
//        let countriesViewController = CountriesViewController()
//        
//        /// Show major country
//        countriesViewController.majorCountryLocaleIdentifiers = ["IN", "GB", "US", "IT", "DE", "RU", "BR",]
//        
//        /// Set initial selected
//        //countriesViewController.selectedCountries = Countries.countriesFromCountryCodes(["AL"])
//        
//        /// Allow or disallow multiple selection
//        countriesViewController.allowMultipleSelection = false
//        
//        /// Set delegate
//        countriesViewController.delegate = self
//        
//        /// Show
//        CountriesViewController.Show(countriesViewController: countriesViewController, to: self)
        
    }
    
    func didGetDiallingCode(_ diallingCode: String!, forCountry countryCode: String!)
    {
        self.txtCCode.text! = String(format: "+%@",diallingCode)
    }
    
    public func failedToGetDiallingCode()
    {
       // AFWrapperClass.alert(Constants.applicationName, message: "Country Code not available", view: self)
    }
    
    
    
    
    /// MARK: CountriesViewControllerDelegate
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountries countries: [Country]) {
        
        var res = ""
        countries.forEach { (co) in
            res = res + co.name + "\n";
        }
    }
    
    func countriesViewControllerDidCancel(_ countriesViewController: CountriesViewController) {
        
       
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountry country: Country) {
        
        self.txtCCode.text! = "+" + country.phoneExtension
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didUnselectCountry country: Country)
    {

        
    }

    
    
    
    
    
    
    // MARK: - Next Butt Clicked
    
    @IBAction func NextButtClicked(_ sender: UIButton)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as? PasswordViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    // MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden=true
    }

    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

