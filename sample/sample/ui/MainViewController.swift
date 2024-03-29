//
//  MainViewController.swift
//  simprokmachine-sample
//
//  Created by Andrey Prokhorenko on 29.01.2022.
//

import simprokmachine
import UIKit


final class MainViewController: UIViewController {
    
    private let label = UILabel()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        label.textColor = .black
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: label.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        
        button.setTitle("increment", for: .normal)
        
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
    }
    
    private var listener: (() -> Void)?
    @objc private func didPressButton() {
        listener?()
    }
}

extension MainViewController: ChildMachine {
    typealias Input = UILayerInput
    typealias Output = UILayerOutput
    
    var queue: MachineQueue { .main }
    
    func process(input: UILayerInput?, callback: @escaping Handler<UILayerOutput>) {
        label.text = "\(input?.text ?? "loading")"
        listener = { callback(.click) }
    }
}
