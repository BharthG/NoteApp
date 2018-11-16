//
//  DetailViewController.swift
//  NoteApp
//

import UIKit

protocol DetailViewControllerDelegate {
    func updateText(newText:String)
}


class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var text:String = ""
    var detailViewControllerDelegate:DetailViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
    }
    
    func setText(txt:String) {
        text = txt
        
        if self.isViewLoaded {
            textView.text = txt
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        detailViewControllerDelegate.updateText(newText: textView.text)
        
    }
}
