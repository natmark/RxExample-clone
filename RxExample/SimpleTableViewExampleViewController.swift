//
//  SimpleTableViewExampleViewController.swift
//  RxExample
//
//  Created by AtsuyaSato on 2017/03/26.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Observable.just([
            "First Item",
            "Seconed Item",
            "Third Item"
        ])
        
        items
            .bindTo(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)){
                (row, element, cell) in
                cell.textLabel?.text = "\(element) @row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                print("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
