import UIKit


class EntryViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!

    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if entry == nil {
            entryTextView.text = "Please provide a journal entry here!"
        }else{
            entryTextView.text = entry!.text
            if let dateToBeShown = entry!.date {
                datePicker.date = dateToBeShown
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if entry == nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let entry = Entry(context: context)
                entry.date = datePicker.date
                entry.text = entryTextView.text
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext() //explicitly saves into core data
            }
        }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func deleteTapped(_ sender: Any) {
        if entry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(entry!)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
