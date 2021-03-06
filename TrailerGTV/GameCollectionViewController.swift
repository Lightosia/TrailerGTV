//
//  GameCollectionViewController.swift
//  TrailerGTV
//
//  Created by Daniel Trevisan on 02/05/16.
//  Copyright © 2016 Daniel Trevisan. All rights reserved.
//

import UIKit

class GameCollectionViewController: UICollectionViewController {
    
    private let detailSegueIdentifier = "DestaquesDetail"
    var gameManager = GameService.sharedInstance
    private let reuseIdentifier = "GameCell"
    let jParser : JsonParser = JsonParser.init()

    @IBOutlet weak var backgroundImage: UIImageView!

    override func viewDidLoad() {
        
        tabBarController?.tabBar.items![0].title = "Destaques"
        tabBarController?.tabBar.items![1].title = "Plataformas"
        tabBarController?.tabBar.items![2].title = "Busca"
        tabBarController?.tabBar.items![3].title = "Lista de Desejos"
        
        super.viewDidLoad()
        jParser.getGames()
        backgroundImage.image = UIImage(named: gameManager.games[0].imageURL)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(gameManager.games.count)
        return gameManager.games.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GameCollectionViewCell

        ImageLoader.sharedLoader.imageForUrl(gameManager.games[indexPath.row].imageURL, completionHandler:{(image: UIImage?, url: String) in
            cell.gameImage.image = image
         })   
        cell.gameName.text = gameManager.games[indexPath.row].title
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedIndexPath != nil){
            backgroundImage.image = UIImage(named: gameManager.games[(context.nextFocusedIndexPath?.row)!].imageURL)

        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue,
                                  sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as?
            GameDetail, selectedIndex = collectionView?.indexPathsForSelectedItems()?.first {
            jParser.fetchGameData(selectedIndex.item, arrayName: "games")
            destinationViewController.exibewishList = false

            destinationViewController.game = gameManager.games[selectedIndex.item]

        }
    }

}

extension GameCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 525)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 90, bottom: 70, right: 90)
    }
}

