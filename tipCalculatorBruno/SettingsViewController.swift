        //
        //  SettingsViewController.swift
        //  tipCalculatorBruno
        //
        //  Created by Bruno Portela on 5/27/19.
        //  Copyright © 2019 Bruno Portela. All rights reserved.
        //

        import UIKit
        import ChameleonFramework

        class SettingsViewController: UIViewController {

            
            @IBOutlet weak var title1: UILabel!
            @IBOutlet weak var title2: UILabel!
            @IBOutlet weak var background: UIView!
            @IBOutlet weak var defaultTip: UISegmentedControl!
            @IBOutlet weak var themeOutlet: UISegmentedControl!
            override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                self.navigationController?.hidesNavigationBarHairline = true
         
            }
            
            @IBAction func defaultTipChanged(_ sender: Any) {
                UserDefaults.standard.set(defaultTip.selectedSegmentIndex, forKey: "defaultTip")
            }
            
            
            @IBAction func themeChanged(_ sender: UISegmentedControl) { UserDefaults.standard.set(themeOutlet.selectedSegmentIndex, forKey: "defaultTheme")
                makeItDark()
            }
            
            
            fileprivate func makeItDark() {
                if themeOutlet.selectedSegmentIndex == 0{
                    UIView.animate(withDuration:0.5, animations: {
                        self.background.backgroundColor = UIColor.white
                    })
                    } else {
                    UIView.animate(withDuration:0.5, animations: {
                        self.background.backgroundColor = UIColor.black
                        
                    })
                    
                }
                
            }
            
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                //Set default tip value""
                defaultTip.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "defaultTip")
                themeOutlet.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "defaultTheme")
                
                makeItDark()
                
            }

        }
