//
//  ImageView.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    @Published var image: UIImage!
    private var task: URLSessionTask?
    private var url: URL! {
        didSet {
            load()
            setPlaceholder()
        }
    }
    
    init(urlString: String) {
        if let url = URL(string: urlString) {
            setURL(with: url)
        }
    }
    
    deinit {
        cancelTask()
    }
    
    private func setURL(with url: URL) {
        self.url = url
    }
    
    private func setPlaceholder() {
        if let placeholder = UIImage(named: Strings.Images.placeholder.rawValue) {
            image = placeholder
        }
    }
    
    private func load() {
        task = ImageServiceManager.getImage(with: url, completion: { image in
            if let image = image {
                self.image = image
            }
        })
    }
    
    private func cancelTask() {
        task?.cancel()
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(withURL url: String) {
        imageLoader = ImageLoader(urlString: url)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(1.0, contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
