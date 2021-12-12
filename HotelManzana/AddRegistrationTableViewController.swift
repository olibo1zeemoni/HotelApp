//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Olibo moni on 09/12/2021.

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    
    var registration: Registration?  {
        guard let roomType = roomType else {return nil}
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(adultsStepper.value)
        let numberOfChildren = Int(childrenStepper.value)
        let hasWiFi = wifiSwitch.isOn
        let calendar = Calendar.current
            let components = calendar.dateComponents([Calendar.Component.day], from: checkInDate, to: checkOutDate)
        let numberOfNights = components.day!
        
        let charges = Charges(numberOfNights: numberOfNights, roomTypeTotal: numberOfNights * roomType.price)
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfChildren: numberOfChildren, numberOfAdults: numberOfAdults, wifi: hasWiFi, roomType: roomType, charges: charges)
    }
    
   
   
    
    
   
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var childrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    @IBOutlet weak var numberOfNightsLabel: UILabel!
    @IBOutlet weak var fromToDatesLabel: UILabel!
    
    @IBOutlet weak var totalRoomCharges: UILabel!
    @IBOutlet weak var roomChargePerNight: UILabel!
    @IBOutlet weak var totalWifiCharges: UILabel!
    @IBOutlet weak var wifiIncudedLabel: UILabel!
    @IBOutlet weak var totalCharges: UILabel!
    
    
    
    
    
    
    
    
    
    
    
    
    var roomType: RoomType?
    
    
        
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        updateGuests()
        updateRoomType()
        updateCharges()


        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        guard let firstName = firstNameTextField.text,
        let lastName = lastNameTextField.text,
        let email = emailTextField.text else{return}
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(adultsStepper.value)
        let numberOfChildren = Int(childrenStepper.value)
        let hasWiFi = wifiSwitch.isOn
        let roomChoice = roomType?.name ?? "not set"
        
        print("DONE Tapped")
        print("First Name: \(firstName) \nLast Name: \( lastName) \nEmail: \(email)")
        print("\(checkInDate) \n\(checkOutDate)")
        print("Number of Adults: \(numberOfAdults) \nNumber of Children: \(numberOfChildren)")
        print(hasWiFi)
        print("Room Type: \(roomChoice)")
        
    }
    
    func updateDateViews(){
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
    }
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    
   
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
        updateCharges()
    }
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerVisible: Bool = false {
        didSet{
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    var isCheckOutDatePickerVisible: Bool = false {
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false:
            return 0
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        let checkInLabelIndexPath = IndexPath(row: 0, section: 1)
        let checkOutLabelIndexPath = IndexPath(row: 2, section: 1)
        
        if indexPath == checkInLabelIndexPath &&
        isCheckOutDatePickerVisible == false{
            isCheckInDatePickerVisible.toggle()
            
        } else if indexPath == checkOutLabelIndexPath &&
        isCheckInDatePickerVisible == false{
            isCheckOutDatePickerVisible.toggle()
        } else if indexPath == checkInLabelIndexPath || indexPath == checkOutLabelIndexPath {
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        }
        else {
            return
        }
        tableView.reloadData()

        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper){
        updateGuests()
        updateCharges()
        
    }
    
    func updateGuests(){
        numberOfAdultsLabel.text = "\(Int(adultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(childrenStepper.value))"
    }
    
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        
    }
    
    
    func updateRoomType(){
        if let roomType = roomType{
            roomTypeLabel.text = roomType.name
        } else{
            roomTypeLabel.text = "not set"
        }
    }
    
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        return selectRoomTypeController
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateCharges(){
        //let checkinDate = checkInDatePicker.date
        //let checkOutDate = checkOutDatePicker.date
        let calendar = Calendar.current
    let components = calendar.dateComponents([Calendar.Component.day], from: checkInDatePicker.date , to: checkOutDatePicker.date)
        let numberOfNights =  components.day!
        numberOfNightsLabel.text = String(describing: numberOfNights)
        
        fromToDatesLabel.text = "Jan 6 2022 - Jan 10 2022"
        totalRoomCharges.text = ""
        roomChargePerNight.text = "Penthouse Suite @ $380/night"
        totalWifiCharges.text = "$ 40"
        wifiIncudedLabel.text = "yes"
        totalCharges.text = "$1276"
        
    }
    
    
    
    
    
    
    
    
}
