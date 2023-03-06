//
//  FilesViewController.swift
//  Camera Photo File
//
//  Created by Shishir_Mac on 6/3/23.
//

import UIKit

class FilesViewController: UIViewController {
    
    @IBOutlet weak var textToSaveTextField: UITextField!
    @IBOutlet weak var textReadLabel: UILabel!
    @IBOutlet weak var fileNameLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    
    
    // The file components that will be used when reading & writing the file
    let fileURLComponents = FileURLComponents(fileName: "sample",
                                              fileExtension: "json",
                                              directoryName: nil,
                                              directoryPath: .documentDirectory)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    @IBAction func saveButtonAction(_ sender: UIButton) {
        textToSaveTextField.endEditing(true)     // Hide keyboard
        
        // Get text
        guard let text = textToSaveTextField.text else { return }
        
        // Create a sample data object from the input text
        let sampleData = DataModel(text: text)
        
        // Write the sample object data
        do {
            let url = try sampleData.write(to: fileURLComponents)
            fileNameLabel.text = url.absoluteString
        } catch {
            showError(error)
        }
        
    }
    
    @IBAction func readButtonAction(_ sender: UIButton) {
        do {
            let sampleData = try DataModel.read(DataModel.self, from: fileURLComponents)
            textReadLabel.text = sampleData.text
        } catch {
            showError(error)
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        do {
            guard try DataModel.delete(fileURLComponents) else {
                showAlert(withTitle: "File Does Not Exist",
                          andMessage: "Could not delete \(fileURLComponents.fileName + "." + fileURLComponents.fileExtension!) because it does not eixst.")
                return
            }
            textReadLabel.text = nil
            fileNameLabel.text = fileURLComponents.fileName + "." + fileURLComponents.fileExtension! + " has been deleted"
            
            // Note: I do not advocate force-unwrapping, but in this case we will consider it safe because we know fileExtension has been set.
            
        } catch {
            showError(error)
        }
    }
    
    // MARK: - Function
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func showError(_ error: Error) {
        showAlert(withTitle: "Error", andMessage: error.localizedDescription)
    }
}
