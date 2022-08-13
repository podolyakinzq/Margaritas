//
//  MargaritasTableViewController.swift
//  Margaritas
//
//  Created by Серёня on 11.08.2022.
//

import UIKit

class MargaritasTableViewController: UITableViewController {
    var margaritas: [Margarita] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMargarita()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        margaritas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsMargaritaCell", for: indexPath) as! CustomTableViewCell
        let rita = margaritas[indexPath.row]
        cell.setupCell(with: rita)

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            detailsVC.margarita = margaritas[indexPath.row]
        }
    }
    
    private func fetchMargarita() {
        Task {
            do {
                let ritas = try await NetworkManager.shared.fetchMargarita(from: Link.ritaAPI.rawValue)
                margaritas = ritas.drinks
            }
        }
    }

}
