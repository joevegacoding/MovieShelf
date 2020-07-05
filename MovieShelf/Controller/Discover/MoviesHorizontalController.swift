//
//  MoviesHorizontalController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class MoviesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "cellIdentifier"
    
    var searchResult: SearchResult?
    var didSelectHandler: ((Result) -> ())?
    
    let closeButtton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let movie = searchResult?.results[indexPath.item] {
            
            if mode == .small {
                didSelectHandler?(movie)
            } else if mode == .fullscreen {
                let movieDetailsController = MovieDetailsController()
                movieDetailsController.searchResult = movie
                movieDetailsController.navigationItem.title = movie.original_title
                movieDetailsController.navigationItem.largeTitleDisplayMode = .automatic
                
                present(movieDetailsController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullscreen {
            layout.scrollDirection = .vertical
        }
        if mode == .fullscreen {
            setupCloseButton()
        }
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(MovieRowCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func setupCloseButton() {
        view.addSubview(closeButtton)
        closeButtton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 19, left: 0, bottom: 0, right: 14), size: .init(width: 28, height: 28))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if mode == .fullscreen {
            return searchResult?.results.count ?? 0
        } else {
            return  min(5, searchResult?.results.count ?? 0)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieRowCell
        
        let discover = searchResult?.results[indexPath.item]
        cell.titleLabel.text = discover?.original_title
        cell.releaseDateLabel.text = discover?.release_date
        cell.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(discover?.poster_path ?? "")" ))
        
        if let voteAverage = discover?.vote_average {
            cell.ratingLabel.text = String(format: "%.2f ⭐️", voteAverage)
        } else if discover?.vote_average == 0 {
            cell.ratingLabel.text = "N/A"
        }
        
        return cell
    }
    
    //layout our cells that are horizontally.
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing)
        if mode == .fullscreen {
            return .init(width: view.frame.width - 48, height: 240)
            
        } else {
            return .init(width: view.frame.width - 48, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    //specify space on the left side
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if mode == .fullscreen {
            return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
        }
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small, fullscreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
