//
//  ImageDownloader.swift
//  APITest2
//
//  Created by 石田竜宇 on 2020/02/21.
//  Copyright © 2020 石田竜宇. All rights reserved.
//

import SwiftUI

class ImageDownloader : ObservableObject {
    @Published var downloadData: Data? = nil

    func downloadImage(url: String) {

        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downloadData = data
            }
        }
    }
}

struct URLImage: View {

let url: String
@ObservedObject private var imageDownloader = ImageDownloader()

init(url: String) {
    self.url = url
    self.imageDownloader.downloadImage(url: self.url)
}

var body: some View {
    if let imageData = self.imageDownloader.downloadData {
        let img = UIImage(data: imageData)
        return VStack {
            Image(uiImage: img!).resizable()
        }
    } else {
        return VStack {
            Image(uiImage: UIImage(systemName: "icloud.and.arrow.down")!).resizable()
        }
    }
}
}
