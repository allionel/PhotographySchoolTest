//
//  AssetRepositoryTest.swift
//  PhotographyTests
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import XCTest
@testable import Photography

final class AssetRepositoryTest: XCTestCase {

    private var network: APIClient = NetworkManager()
    private var assetRepository: AssetRepository? = nil
    private var localRepository: AssetLocalRepository? = nil
    private var remoteRepository: AssetRemoteRepository? = nil
    private var fileManager: FileManagerAssetProvider? = nil
    private let imageUrl = "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560"
    
    override func setUpWithError() throws {
        fileManager = LocalFileManager.shared
        localRepository = AssetLocalRepositoryImp(fileManager: fileManager!)
        remoteRepository = AssetRemoteRepositoryImp.init(client: network)
        assetRepository = AssetRepositoryImp(localRepository: localRepository!, remoteRepository: remoteRepository!)
    }

    func testSaveRemoteImage() throws {
        let expectation = expectation(description: "Save image successfuly")
        remoteRepository?.getRemoteImage(urlString: imageUrl) { (response: Result<Data?, ClientError>) in
            if case .success(let data) = response {
                guard let data else { return }
                self.localRepository?.saveImage(with: "950", data: data) { (response: Result<Data?, ClientError>) in
                    if case .success = response { expectation.fulfill() }
                }
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGetLocalImage() throws {
        let expectation = expectation(description: "Get image locally successfuly")
        localRepository?.getLocalImage(imageName: "950", completion: { (response: Result<Data?, ClientError>) in
            if case .success = response { expectation.fulfill() }
        })
        wait(for: [expectation], timeout: 3)
    }
    
    override func tearDownWithError() throws {
        fileManager = nil
        localRepository = nil
        remoteRepository = nil
        assetRepository = nil
    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
